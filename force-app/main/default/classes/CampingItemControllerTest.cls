@IsTest
private class CampingItemControllerTest {


    @TestSetup
    static void makeData(){
        Camping_Item__c item = new Camping_Item__c(
            Name='Demo',
            Quantity__c=2,
            Price__c=120.543,
            Packed__c=false
        );
        insert item;
    }

    @IsTest
    static void testDoInit() {
        Camping_Item__c item = CampingItemController.initialize();
        System.assert(item!=null);
    }
}