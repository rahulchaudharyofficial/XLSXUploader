@IsTest
private class PositivePermission_tests {
	
    
    @TestSetup
    static void testSetupMethod() {
        List<Account> accounts = Test.loadData(Account.sobjectType, 'Mock_Data'); //Ran as Sys Admin
    }
    
    @IsTest
    static void CustomUserAccessTest() {
        Profile p = [Select id from profile where name='Custom User'];
        User u = new User(ProfileId=p.Id, LastName='Sample',Username='Sample@emai.com', Email='Sample@emai.com', Alias='Sample', TimeZoneSidKey='Asia/Kolkata', LocaleSidKey=' en_US', EmailEncodingKey='UTF-8', LanguageLocaleKey='en_US');
        System.runAs(u) {
            List<Account> accounts = [Select id from Account where CreatedDate=TODAY];
            System.assert(accounts!=null && accounts.size()>0);
        }
    }
}