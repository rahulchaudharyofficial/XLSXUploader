@IsTest
public class AnimalLocatorMock implements HttpCalloutMock {
    public HttpResponse respond(HttpRequest request) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type','application/json;charset=UTF-8');
        response.setBody('{"animal": {"eats":"chicken food", "id":1, "name":"chicken", "says":"cluck cluck"}}');
        response.setStatusCode(200);
        return response;
    }
}