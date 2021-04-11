@IsTest 
private class OrderEventTriggerTest {
    @IsTest
    static void test() {
        Order_Event__e oe = new Order_Event__e(Has_Shipped__c=true);

        Test.startTest();
        Database.SaveResult sr = Eventbus.publish(oe);
        Test.stopTest();

        System.assert(sr.isSuccess()==true);

        List<Task> t = [select id from task];
        System.assert(t!=null && t.size()==1);

    }
}