@IsTest
private class AccountProcessorTest {
    
    static Id makeData(){
        Account a = new Account(Name='Dummy');
        insert a;
        Contact c1 = new Contact(LastName='L1',AccountId=a.Id);
        Contact c2 = new Contact(LastName='L2',AccountId=a.Id);
        insert c1;
        insert c2;

        return a.Id;
    }

    @IsTest
    static void test() {
        String Idss = makeData();
        Test.startTest();
        AccountProcessor.countContacts(new List<String>{Idss});
        Test.stopTest();
        Account a = [select Number_of_Contacts__c, Id from Account where id = :Idss];
        System.assert(a!=null);
        System.assert(a.Number_of_Contacts__c==2);
    }
}