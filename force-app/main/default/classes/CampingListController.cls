public with sharing class CampingListController {
    @AuraEnabled(cacheable=true)
    public static List<Camping_Item__c> getItems() {
        return [select id, Name,Quantity__c,Packed__c,Price__c from Camping_Item__c];
    }

    @AuraEnabled
    public static Camping_Item__c saveItem(Camping_Item__c itemToSave) {
        upsert itemToSave;
        return itemToSave;
    }
}