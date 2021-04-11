public with sharing class CampingItemController {

    @AuraEnabled(cacheable=true)
    public static Camping_Item__c initialize() {
        return [select id, Name,Quantity__c,Packed__c,Price__c from Camping_Item__c Limit 1];
    }
    
    @AuraEnabled(cacheable=true)
    public static List<Camping_Item__c> getCampingItems() {
        return [select id, Name,Quantity__c,Packed__c,Price__c from Camping_Item__c];
    }

    @AuraEnabled
    public static Camping_Item__c saveCampingItem(Camping_Item__c itemToSave) {
        upsert itemToSave;
        return itemToSave;
    }
}