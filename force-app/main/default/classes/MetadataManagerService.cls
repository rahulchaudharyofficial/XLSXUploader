public class MetadataManagerService {
    private static List<String> IGNORE_LIST = new List<String> {
        'ID',
        'LABEL',
        'MASTERLABEL',
        'DEVELOPERNAME',
        'LANGUAGE',
        'QUALIFIEDAPINAME',
        'NAMESPACEPREFIX'
    };

    public static Object initiate(MetadataManagerController.MetadataDTO result) {
        Map<String,String> toReturn = new Map<String,String>();
        List<SObject> sObjectRecords = result.values;
        Metadata.DeployContainer container = new Metadata.DeployContainer();
        for(SObject sObjRecord : sObjectRecords) {
            Metadata.CustomMetadata cm = new Metadata.CustomMetadata();
            cm.label = String.valueOf(sObjRecord.get('Label'));
            cm.fullName = result.sObjType.substringBefore('__')+'.'+sObjRecord.get('DeveloperName');

            for(MetadataManagerController.MetadataColumnDTO field : result.columns) {
                String fieldAPI = field.fieldName;
                if(!IGNORE_LIST.contains(fieldAPI.toUpperCase())) {
                    Metadata.CustomMetadataValue cmv = new Metadata.CustomMetadataValue();
                    cmv.field=fieldAPI;
                    cmv.value=sObjRecord.get(fieldAPI);

                    cm.values.add(cmv);
                }
            }
            container.addMetadata(cm);
        }
        
        if(!container.getMetadata().isEmpty()) {
            MetadataCallback callback = new MetadataCallback();
            Id jobId = Metadata.Operations.enqueueDeployment(container, callback);
            System.debug('Job Id = '+ jobId+' published');
            toReturn.put('SUCCESS', jobId);
        }
        else {
            toReturn.put('ERROR', 'Nothing to deploy');
        }
        return toReturn;
    }
}