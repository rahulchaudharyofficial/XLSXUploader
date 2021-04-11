@IsTest
private class AnimalLocatorTest {

    @IsTest
    static void testName() {
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());
        String name = AnimalLocator.getAnimalNameById(1);
        System.assertEquals('chicken', name);
    }
}