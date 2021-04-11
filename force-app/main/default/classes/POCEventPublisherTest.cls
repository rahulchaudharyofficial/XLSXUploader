@IsTest
private class POCEventPublisherTest {
	@IsTest
    static void test1() {
        Test.startTest();
        POCEventPublisher.publish('Run throw platform circular thing',10);
        Test.stopTest();
    }
}