public class ConsolidatedReportsService {
    private static final String TEMPLATE_ENDPOINT = '{printbrokerURL}/byobject/{objectApiName}'; 

    private static String getGuid() {
        Blob b = Crypto.GenerateAESKey(128);
        String h = EncodingUtil.ConvertTohex(b);
        return h.SubString(0,8)+ '-' + h.SubString(8,12) + '-' + h.SubString(12,16) + '-' + h.SubString(16,20) + '-' + h.substring(20);
    }

    private static Integer getRandomNumber() {
        return Integer.valueOf(Math.random()*10);
    }
    
    public static List<ReportTemplate> getTemplateMetaBySObjectType(String recordId) {
        Integer howMany = getRandomNumber();
        List<ReportTemplate> restTemplateList = new List<ReportTemplate>();
        for (Integer count = 0; count < howMany; count++ ) {
            String templateId = getGuid();
            restTemplateList.add(
                new ReportTemplate(String.valueOf((count+1)),'Test Template '+ (count+1),'Test Template '+ (count+1), (Math.mod(getRandomNumber(),2)==0?true:false),(Math.mod(getRandomNumber(),2)==0?true:false),(Math.mod(getRandomNumber(),2)==0?true:false),'Template Description for '+ (count+1),templateId,UserInfo.getName())
            );
        }
        return restTemplateList;
    }

    public class ReportTemplate {
        public String id {get;set;}
        public String title {get;set;}
        public String name {get;set;}
        public Boolean enabled {get;set;}
        public Boolean landscape {get;set;}
        public Boolean esignature {get;set;}
        public String description {get;set;}
        public String   templateId  {get;set;}
        public String   createdBy   {get;set;}
        public System.SelectOption  option {get;set;}
        public ReportTemplate(String id, String title, String name, Boolean enabled, Boolean landscape, Boolean esignature, String description,String templateId, String createdBy) {
            this.id=id;
            this.title = title;
            this.name = name;
            this.enabled = enabled;
            this.landscape = landscape;
            this.esignature = esignature;
            this.description = description;
            this.createdBy   = createdBy;
            this.templateId  = templateId;
            this.option = new System.SelectOption(templateId,'');
        }
    }

    private static List<TemplateDAO> readMockPayload(String apiName) {
        List<TemplateDAO> toReturn = new List<TemplateDAO>();
        String query = 'Select Id, SObjectType_API__r.QualifiedApiName, Priority__c,Mock_Response__c,IsActive__c from Consolidated_Report_Config__mdt where IsActive__c=true and SObjectType_API__r.QualifiedApiName = :apiName order by Priority__c asc';
        List<Consolidated_Report_Config__mdt> activeConfigs = Database.query(query);
        if(activeConfigs!=null && activeConfigs.size()>0) {
            for(Consolidated_Report_Config__mdt config : activeConfigs) {
                String payload = config.Mock_Response__c;
                if(!String.isBlank(payload)) {
                    toReturn = (List<TemplateDAO>) JSON.deserialize(payload, List<TemplateDAO>.class);
                }
            }
        }
        return toReturn;
    } 

    public static List<TemplateDAO> getTemplateConfigBySObjectType(String apiName) {
        List<TemplateDAO> toReturn = new List<TemplateDAO>();
        if(!String.isBlank(apiName)) {
            if(Label.USING_MOCK_REPORTS.equalsIgnoreCase('true')) {
                toReturn=readMockPayload(apiName);
                
                if(toReturn==null) {
                    toReturn = new List<TemplateDAO>();
                }
            }
            else {
                //TODO Take care of actual API Calls
            }
        }
        return toReturn;
    }
}