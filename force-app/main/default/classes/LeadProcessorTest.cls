@IsTest
private class LeadProcessorTest {

    @TestSetup
    static void makeData(){
        List<Lead> leads = new List<Lead>();
        for(Integer i=0;i<200;i++) {
            leads.add(new Lead(LastName='Dumy'+i,Company='Shell'+i,Status='Open - Not Contacted'));
        }
        insert leads;
    }

    @IsTest
    static void test() {
        Test.startTest();
        Database.executeBatch(new LeadProcessor());
        Test.stopTest();
        List<Lead> leads = [Select Id from Lead where name like 'Dumy%' and Company like 'Shell%'];
        System.assert(leads!=null && leads.size()==200);
    }
}