public class ObjectSelector {

    @AuraEnabled(cacheable=true)
    public static List<SchemaObject> getSchemaObjects() {
        Schema.DescribeSObjectResult result = null;
        List<SchemaObject> toReturn = new List<SchemaObject>();
        for(Schema.SObjectType objTyp :  Schema.getGlobalDescribe().values()) {
            result = objTyp.getDescribe();
            toReturn.add(new SchemaObject(result.getLabel(), result.getName()));
        }
        return toReturn;
    }

    class SchemaObject {
        public SchemaObject(String label, String value) {
            this.label = label;
            this.value = value;
        }
        @AuraEnabled public String label {get;private set;}
        @AuraEnabled public String value {get; private set;}
    }
}