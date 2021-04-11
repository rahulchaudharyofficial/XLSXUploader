@IsTest
private class PlatformEventTest {

    /*
    @TestSetup
    static void makeData(){
        Group g = new Group(Name='Regional Dispatch',Type='Queue');    
        insert g;
    } */

    @IsTest
    static void test1() {
        Cloud_News__e newsEvent = new Cloud_News__e(
            Location__c='Mountain City', 
            Urgent__c=true, 
            News_Content__c='Test message.');
            Test.startTest();
            Database.SaveResult sr = Eventbus.publish(newsEvent);
            Test.stopTest();

            System.assert(sr.isSuccess()==true);
            List<Case> cases = [select id from case];
            System.assert(cases.size()==1);
    }
}