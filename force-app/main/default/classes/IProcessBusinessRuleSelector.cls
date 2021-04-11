public interface IProcessBusinessRuleSelector {
    List<Process_Business_Rule__c> selectBusinessProcessRuleById(Set<Id> idSet);
    List<Process_Business_Rule__c> selectBusinessProcessRuleByProcessName(String businessProcessName);
    List<Process_Business_Rule__c> selectBusinessProcessRuleByObjectType(String objectType);
}