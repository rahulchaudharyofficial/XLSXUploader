public class AnimalLocator {
    public static String getAnimalNameById(Integer id) {
        String toReturn = '';
        if(id!=null) {
            Http ht = new Http();
            HttpRequest request = new HttpRequest();
            request.setMethod('GET');
            request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/'+id);
            HttpResponse response =  ht.send(request);
            if(response!=null && response.getStatusCode()==200) {
                Map<String,Object> data = (Map<String,Object>) JSON.deserializeUntyped(response.getBody());
                Map<String,Object> res = (Map<String,Object>) data.get('animal');
                if(res.get('name') !=null) {
                    toReturn = STring.valueOf(res.get('name'));
                }
            }
        }
        return toReturn;
    }
}