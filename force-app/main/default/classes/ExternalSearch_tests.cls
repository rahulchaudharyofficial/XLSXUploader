@IsTest
private class ExternalSearch_tests {
	
    @IsTest
    static void testPositiveGoogleIt() {
        Test.setMock(HttpCalloutMock.class, new HTTPMockFactory(200, 'OK', 'I found it!', new Map<String,String>()));
        String result;
    	Test.startTest();
      	Boolean caught = false;
        try {
        	result = ExternalSearch.googleIt('epic search');
        }
        catch(ExternalSearch.ExternalSearchException ex) {
            caught = true;
        }
    	Test.stopTest();
    	system.assertEquals(caught, false);
    }
    @IsTest
    static void testNegetiveGoogleIt() {
        Test.setMock(HttpCalloutMock.class, new HTTPMockFactory(500, 'NOT_OK', 'I Did not find it!', new Map<String,String>()));
        String result;
    	Test.startTest();
      	Boolean caught = false;
        try {
        	result = ExternalSearch.googleIt('epic search');
        }
        catch(ExternalSearch.ExternalSearchException ex) {
            caught = true;
        }
    	Test.stopTest();
    	system.assertEquals(caught, true);
    }
}