@IsTest
private class AddPrimaryContactTest {
    private static Contact c = null;
    @TestSetup
    static void makeData(){
        List<Account> acc1 = new List<Account>();
        List<Account> acc2 = new List<Account>();
        for(Integer i=0;i<50;i++) {
            acc1.add(new Account(BillingState='NY',Name='Dummy'+i));    
        }
        insert acc1;

        for(Integer i=0;i<50;i++) {
            acc2.add(new Account(BillingState='CA',Name='Dummy'+i+50));
        }
        insert acc2;
        List<Contact> cc = new List<Contact>();
        for(Account a: acc2) {
            c = new Contact(LastName='Dummy00dsd',AccountId=a.Id);
            cc.add(c);
        }
        insert cc;
    }

    @IsTest
    static void test() {
        makeData();
        AddPrimaryContact ap = new AddPrimaryContact(c,'NY');
        Test.startTest();
        System.enqueueJob(ap);
        Test.stopTest();
        List<Account> aa = [Select Id, (Select Id,LastName from Contacts) from Account where BillingState='NY'];
        System.assert(aa.get(0).contacts.get(0).LastName=='Dummy00dsd','Matched');
    }
}