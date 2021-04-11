public class JsonParser {
    public static Map<String,Object> parse(String jsonString) {
        Map<String,Object> toReturn = new Map<String,Object>();
        if(!String.isBlank(jsonString)) {
            try {
                Map<String,Object> parsedObjects = (Map<String,Object>) JSON.deserializeUntyped(jsonString);
                if(!parsedObjects.isEmpty()) {
                    for(String parseObject : parsedObjects.keySet()) {
                        //Map<String, Object> payloadContent = (Map<String,Object>) parseObject;
                        //System.debug(payloadContent);
                        System.debug('Key => '+ parseObject+' , value => '+ parsedObjects.get(parseObject));
                    }
                }
            }
            catch(Exception ex) {
                System.debug(LoggingLevel.ERROR, 'Error occured during parsing = '+ ex.getMessage());
            }
        }
        return toReturn;
    }
}