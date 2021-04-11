public with sharing class RecordProducer {
    public List<SObject> saveRecords(List<SObject> records) {
        System.assert(records!=null && !records.isEmpty());
        insert records;
        return records;
    }

    public List<SObject> getRecords(Schema.SObjectType typ,Integer count) {
        System.assert(typ!=null);
        if(count==null || count < 0) {
            count = Limits.getLimitQueryRows();
        }
        List<String> fields = new List<String>();
        fields.addAll(typ.getDescribe().fields.getMap().keySet());
        String fieldAPIs = String.join(fields, ',');
        
        String query = 'select '+fieldAPIs+' from '+typ.getDescribe().getName()+' limit '+ count;
        return Database.query(query);
    }
}