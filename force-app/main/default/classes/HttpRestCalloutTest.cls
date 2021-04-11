@IsTest
private class HttpRestCalloutTest {
    
    @IsTest
    static void testGet() {
        StaticResourceCalloutMock mockCallout = new StaticResourceCalloutMock();
        mockCallout.setStaticResource('GetAnimalResource');
        mockCallout.setStatusCode(200);
        mockCallout.setHeader('Content-Type','application/json;chatset=UTF-8');
        Test.setMock(HttpCalloutMock.class, mockCallout);
        Test.startTest();
        HttpResponse response = HttpRestCallout.makeHttpCall();
        Test.stopTest();
        System.assert(response!=null);
        System.assertEquals(200,response.getStatusCode());
        System.assertEquals('application/json;chatset=UTF-8', response.getHeader('Content-Type'));
        Map<String,Object> result =(Map<String,Object>) JSON.deserializeUntyped(response.getBody());
        List<Object> animals = (List<Object>)result.get('animals');
        System.assertEquals(3, animals.size());
    }

    @IsTest
    static void testPost() {
        Test.setMock(HttpCalloutMock.class, new HttpRestCalloutMock());
        HttpResponse response = HttpRestCallout.makePostCallout();
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json;charset=UTF-8');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = '{"animals":["sub1","sub2","sub3"]}';
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, response.getStatusCode());
    }
}