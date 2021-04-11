@IsTest
private class myDataGenerationTests {
	@TestSetup
    static void setup() {
        List<Account> mockData = Test.loadData(Account.SObjectType, 'Mock_Data');
    }
    
    @IsTest
    static void verifyload() {
        List<Account> accounts = [select id,Name from Account where createddate=TODAY];
        System.assert(accounts.size()==15);
    }
}