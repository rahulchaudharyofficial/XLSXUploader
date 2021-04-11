@IsTest
private class EmailControllerTest {
	
    private static EmailController ec = new EmailController();
    @TestSetup
    static void makeData(){
        Account a = new Account(Name='Test Account');
        insert a;
        Contact c = new Contact(AccountId = a.Id,FirstName='Rahul',LastName='Chaudhary',Email='rahul.chaudhary.1711@gmail.com');
        insert c;
    }

    @IsTest
    static void testSendEmail() {
        
        Test.startTest();
        ec.sendEmail();
        Test.stopTest();    
    }
    
    @IsTest
    static void throwExceptionScenario() {
        Test.startTest();
        ec.throwException=true;
        ec.sendEmail();
        Test.stopTest();
    }
}