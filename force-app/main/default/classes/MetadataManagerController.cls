public with sharing class MetadataManagerController {
  private static List<Schema.SObjectType> globalCache = refreshCache();

  private static final String BASE_ERROR = 'Content of/against {} is null or blank';
  private static final String STATUS_SUCCESS='SUCCESS';
  private static final String STATUS_ERROR='ERROR';

  private static final Set<String> IGNORED_METADATA_FIELDS = new Set<String> {
    'Id',
    'DeveloperName',
    'MasterLabel',
    'Language',
    'NamespacePrefix',
    'Label',
    'QualifiedApiName'
  };

  @AuraEnabled
  public static Object getCSVHeaders(String metadata, String documentId) {
    CSVHeaderResponseDTO toReturn = new CSVHeaderResponseDTO();
    if(String.isBlank(documentId)) {
      toReturn.status =   STATUS_ERROR;
      toReturn.message = String.format(BASE_ERROR, new List<String> {documentId});
      toReturn.csvHeaders.clear();
    }
    else {
      List<ContentVersion> fileContent = [SELECT VersionData,ContentSize,FileType,FileExtension,PublishStatus,Title FROM ContentVersion WHERE ContentDocumentId = :documentId  AND IsLatest = true];
      if(fileContent!=null && !fileContent.isEmpty()) {
        Blob csvBlob = fileContent.get(0).VersionData;
        String csvText = csvBlob.toString();
        if(!String.isBlank(csvText)) {
          List<String> csvFileLines= csvText.trim().split('\n');
          if(csvFileLines!=null && !csvFileLines.isEmpty()) {
            String firstLine = csvFileLines.get(0);
            List<String> headers = firstLine.split(',');

            List<List<Object>> values = new List<List<Object>>();
            if(csvFileLines.size()>1) {//1st Row will always be header
              for(Integer i=1;i<csvFileLines.size();i++) {
                String row = csvFileLines.get(i);
                List<Object> rowValue= (List<Object>) row.split(',');
                values.add(rowValue);
              }
            }
            toReturn.values = values;
            
            if(headers!=null && !headers.isEmpty()) {
              for(String head : headers) {
                toReturn.csvHeaders.add(head);
              }
              toReturn.status=STATUS_SUCCESS;
            }
            else {
              toReturn.status = STATUS_ERROR;
              toReturn.csvHeaders.clear();
              toReturn.message = String.format(BASE_ERROR, new List<String> {documentId});
            }
          }
          else {
            toReturn.status = STATUS_ERROR;
            toReturn.csvHeaders.clear();
            toReturn.message = String.format(BASE_ERROR, new List<String> {documentId});
          }
        }
        else {
          toReturn.status = STATUS_ERROR;
          toReturn.csvHeaders.clear();
          toReturn.message = String.format(BASE_ERROR, new List<String> {documentId});
        }
      }
      else {
        toReturn.status = STATUS_ERROR;
        toReturn.csvHeaders.clear();
        toReturn.message = String.format(BASE_ERROR, new List<String> {documentId});
      }
    }

    return transform(metadata,toReturn, documentId);
  }

  private static Object transform(String metadata, CSVHeaderResponseDTO result, String documentId) {

    MetadataDTO resultDTO = new MetadataDTO();
    resultDTO.documentId = documentId;
    List<MetadataColumnDTO> columns = new List<MetadataColumnDTO>();
    List<SObject> values = new List<SObject>();

    Map<String, Schema.SObjectType> cache = Schema.getGlobalDescribe();
    Schema.SObjectType sObjTyp = null;
    for(String key : cache.keySet()) {
      if(key.equalsIgnoreCase(metadata)) {
        sObjTyp = cache.get(key);
        break;
      }
    }
    if(sObjTyp!=null) {
      // Populate Columns
      resultDTO.sObjType = sObjTyp.getDescribe().getName();
      List<String> fields = result.csvHeaders;
      Map<String, Schema.SObjectField> fieldMap = sObjTyp.getDescribe().fields.getMap();
      
      for(String field : fields) {
        if(fieldMap.containsKey(field.toLowerCase())) {
          Schema.DescribeFieldResult fieldResult = fieldMap.get(field.toLowerCase()).getDescribe();
          MetadataColumnDTO column = new MetadataColumnDTO();
          column.label = fieldResult.getLabel();
          column.fieldName = fieldResult.getName();
          column.type = fieldResult.getType().name();
          columns.add(column);
        }
      }
      resultDTO.columns = columns;
      if(result.values!=null && !result.values.isEmpty()) {
        for(Integer i=0;i < result.values.size(); i++) {
          SObject sObj = sObjTyp.newSObject();
          for(Integer j=0; j< fields.size(); j++) {
            sObj.put(fields.get(j), result.values.get(i).get(j));
          }
          values.add(sObj);
        }
      }
      resultDTO.values = values;
    }
    else {
      throw new InvalidParamException(String.format(Invalid_Param_Exception, new List<String> {metadata}));
    }
    return resultDTO;
  }


  @AuraEnabled(cacheable=true)
  public static List<MetadataWrapper> getAccessibleMetadata() {
    List<MetadataWrapper> toReturn = new List<MetadataWrapper>();

    if (globalCache == null || globalCache.isEmpty()) {
      globalCache = refreshCache();
    }
    MetadataWrapper temp = null;
    for (Schema.SObjectType sObjTyp : globalCache) {
      Schema.DescribeSObjectResult result = sObjTyp.getDescribe();
      if (result.isAccessible() && result.getName().endsWith('__mdt')) {
        temp = new MetadataWrapper();
        temp.name = result.getName();
        temp.label = result.getLabel();

        List<MetadataFieldWrapper> fieldAPI = new List<MetadataFieldWrapper>();

        Schema.DescribeFieldResult fResult = null;
        for (Schema.SObjectField f : result.fields.getMap().values()) {
          fResult = f.getDescribe();
          if(fResult.isAccessible() && !fResult.isCalculated() && !fResult.isAutoNumber() && !IGNORED_METADATA_FIELDS.contains(fResult.getName())) {
            fieldAPI.add(
              new MetadataFieldWrapper(
                fResult.getLabel(),
                fResult.getName(),
                fResult.getType().name()
              )
            );
          }
        }

        temp.fields = fieldAPI;
        toReturn.add(temp);
      }
    }
    return toReturn;
  }

  private static List<Schema.SObjectType> refreshCache() {
    return Schema.getGlobalDescribe().values();
  }

  public class MetadataWrapper {
    @AuraEnabled
    public String label { get; set; }
    
    @AuraEnabled
    public String name { get; set; }
    
    @AuraEnabled
    public List<MetadataFieldWrapper> fields = new List<MetadataFieldWrapper>();
  }

  public class MetadataFieldWrapper {
    @AuraEnabled
    public String label { get; set; }
    
    @AuraEnabled
    public String name { get; set; }
    
    @AuraEnabled
    public String type { get; set; }

    public MetadataFieldWrapper(String lbl, String nm, String typ) {
      this.label = lbl;
      this.name = nm;
      this.type = typ;
    }
  }

  @AuraEnabled
  public static Object submitDataUpload(MetadataDTO inputDTO) {
    return MetadataManagerService.initiate(inputDTO);
  } 

  public class CSVHeaderResponseDTO {
    @AuraEnabled public List<String> csvHeaders {get;private set;}

    @AuraEnabled public String status {get; set;}

    @AuraEnabled public String message {get; set;}

    @AuraEnabled public List<List<Object>> values {get;set;}

    public CSVHeaderResponseDTO() {
      csvHeaders = new List<String>();
    }
  }

  private static final String Invalid_Param_Exception = 'Given param {0} does not exist';
  
  public class MetadataDTO {
    @AuraEnabled public List<MetadataColumnDTO> columns {get;set;}
    @AuraEnabled public List<SObject> values {get;set;}
    @AuraEnabled public String sObjType {get;set;}
    @AuraEnabled public String documentId {get;set;}
  }

  public class MetadataColumnDTO {
    @AuraEnabled public String label {get;set;}
    @AuraEnabled public String fieldName {get;set;}
    @AuraEnabled public String type {get;set;}
  }
  public class InvalidParamException extends Exception {}
}
//SELECT VersionData,ContentSize,FileType,FileExtension,PublishStatus,Title FROM ContentVersion WHERE ContentDocumentId = '0690p000000UVT9AAO' AND IsLatest = true