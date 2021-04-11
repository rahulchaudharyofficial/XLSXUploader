public with sharing class ProcessBusinessRuleSelector implements IProcessBusinessRuleSelector {
    
    private String baseQueryTemplate = 'select {0} from {1}';
    
    private List<String> getChildSObjectFields() {
        return new List<String> {
            'id',
            'name',
            'Field_API__c',
            'Is_Expression__c',
            'Process_Business_Rule__c',
            'Operator__c,Value__c',
            'Rule_Key__c,Sequence__c'
        };
    }

    private List<String> getParentSObjectFields() {
        return new List<String> {
            'id',
            'name',
            'Parent_Object__c',
            'Business_Process_Name__c',
            'business_rule_expression__c',
            '({0})'
        };
    }
    
    private String getChildBaseQuery() {
        String base = baseQueryTemplate;
        List<String> parameters = new List<String> {
            String.join(getChildSObjectFields(), ','),
            'Process_Business_Rule_Items__r'
        };
        return String.format(base,parameters);
    }

    private String getParentBaseQuery() {
        String base = baseQueryTemplate;
        List<String> parameters = new List<String> {
            String.join(getParentSObjectFields(), ','),
            'Process_Business_Rule__c'
        };
        return String.format(base, parameters);
    }

    private String getFinalQuery() {
        String parentQuery = getParentBaseQuery();
        String childQuery = getChildBaseQuery();        
        String finalQuery = String.format(parentQuery, new List<String> {childQuery});
        return finalQuery;
    }


    public List<Process_Business_Rule__c> selectBusinessProcessRuleById(Set<Id> idSet) {
        List<Process_Business_Rule__c> toReturn = new List<Process_Business_Rule__c>();
        if(!idSet.isEmpty()) {
            try {
                String finalQuery = getFinalQuery();
                finalQuery = finalQuery+' where id in :idSet';
                toReturn = Database.query(finalQuery);
            }
            catch(Exception ex) {
                System.debug(LoggingLevel.ERROR, 'Failed to fetch business process rule by id');
                toReturn=new List<Process_Business_Rule__c>();
            }
        }
        else {
            System.debug(LoggingLevel.ERROR, 'Required parameters are null or empty');
        }
        return toReturn;
    }
    public List<Process_Business_Rule__c> selectBusinessProcessRuleByProcessName(String businessProcessName) {
        List<Process_Business_Rule__c> toReturn = new List<Process_Business_Rule__c>();
        if(!String.isBlank(businessProcessName)) {
            try {
                String finalQuery = getFinalQuery();
                finalQuery = finalQuery+' where Business_Process_Name__c = :businessProcessName';
                toReturn = Database.query(finalQuery);
            }
            catch(Exception ex) {
                System.debug(LoggingLevel.ERROR, 'Failed to fetch business process rule by id');
                toReturn=new List<Process_Business_Rule__c>();
            }
        }
        else {
            System.debug(LoggingLevel.ERROR, 'Required parameters are null or empty');
        }
        return toReturn;
    }
    public List<Process_Business_Rule__c> selectBusinessProcessRuleByObjectType(String objectType) {
        List<Process_Business_Rule__c> toReturn = new List<Process_Business_Rule__c>();
        if(!String.isBlank(objectType)) {
            try {
                String finalQuery = getFinalQuery();
                finalQuery = finalQuery+' where Parent_Object__c = :objectType';
                toReturn = Database.query(finalQuery);
            }
            catch(Exception ex) {
                System.debug(LoggingLevel.ERROR, 'Failed to fetch business process rule by id');
                toReturn=new List<Process_Business_Rule__c>();
            }
        }
        else {
            System.debug(LoggingLevel.ERROR, 'Required parameters are null or empty');
        }
        return toReturn;
    }
}