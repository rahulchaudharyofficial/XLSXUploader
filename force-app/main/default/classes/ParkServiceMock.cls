@IsTest
public class ParkServiceMock implements WebServiceMock {
    public void doInvoke(Object stub,
            Object request,
            Map<String, Object> response,
            String endpoint,
            String soapAction,
            String requestName,
            String responseNS,
            String responseName,
            String responseType) {
                ParkService.byCountryResponse service = new ParkService.byCountryResponse();
                service.return_x = new String[] {'Res1','Res2'};
                response.put('response_x', service);
    }
}