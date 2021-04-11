@isTest
public class ExternalSearchMock implements HttpCalloutMock {
	public HTTPResponse respond(HTTPRequest req) {
    HttpResponse res = new HttpResponse();
    res.setBody('');
    res.setStatusCode(500);
    res.setStatus('Failed');
    return res;
  }
}