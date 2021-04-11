public class GenericController {
    private static Map<String, Schema.SObjectType> glocalDescribeCache = Schema.getGlobalDescribe();
    
    @AuraEnabled(cacheable=true)
    public static List<SObjectTypePropertyDTO> getAllSObjectType() {
        List<SObjectTypePropertyDTO> toReturn = new List<SObjectTypePropertyDTO>();
        Schema.DescribeSObjectResult result = null;
        for(String key : glocalDescribeCache.keySet()) {
            result = glocalDescribeCache.get(key).getDescribe();
            toReturn.add(new SObjectTypePropertyDTO(result.getName(), result.getLabel()));
        }
        System.debug('Return size = '+ toReturn.size());
        for(Integer x = 0; x<4343; x++) {
            toReturn.add(new SObjectTypePropertyDTO('DUMMY_KEY'+(x+1),'DUMMY_VALUE'+(x+1)));
        }
        System.debug('Return size = '+ toReturn.size());
        return toReturn;
    }
    class SObjectTypePropertyDTO {
        @AuraEnabled String name {get;private set;}
        @AuraEnabled String label {get;private set;}
        SObjectTypePropertyDTO(String name, String label) {
            this.name = name;
            this.label = label;
        }
    }
}