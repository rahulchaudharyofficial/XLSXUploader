@IsTest
private class ParkLocatorTest {

    @IsTest
    static void testByCountry() {
        Test.setMock(WebServiceMock.class, new ParkServiceMock());
        String[] res = ParkLocator.country('India');
        System.assert(res!=null);
        System.assertEquals(true, res.contains('Res1'));
    }
}