@IsTest
public class HttpRestCalloutMock implements HttpCalloutMock {
    public HttpResponse respond(HttpRequest request) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type','application/json;charset=UTF-8');
        response.setBody('{"animals":["sub1","sub2","sub3"]}');
        response.setStatusCode(200);
        return response;
    }
}