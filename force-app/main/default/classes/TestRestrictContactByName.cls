@IsTest
private class TestRestrictContactByName {

    @IsTest
    private static void test() {
        Test.startTest();
        Contact c = new COntact(lastName='INVALIDNAME');
        insert c;
        Test.stopTest();
        
    }
}