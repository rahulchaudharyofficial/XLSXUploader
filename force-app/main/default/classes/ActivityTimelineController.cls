public with sharing class ActivityTimelineController {
    
    @AuraEnabled(cacheable=true)
    public static List<SObject> getTaskByWhatId(String recordId) {
        System.debug('Id received : '+ recordId);
        System.assert(!String.isBlank(recordId), 'What Id must not be null or blank');
        Id recId = (Id) recordId;
        Schema.DescribeSObjectResult result = recId.getSobjectType().getDescribe();
        SObjectSelectorAPI selector = new SObjectSelectorAPI(Task.SObjectType);
        String query = selector.getBaseQuery() + ' where WhatId = :recId order by ActivityDate Desc';
        List<SObject> toReturn = Database.query(query);
        System.debug('returning '+ JSON.serialize(toReturn));
        return toReturn;
    }
}