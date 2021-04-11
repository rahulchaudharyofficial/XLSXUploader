public class TestDataFactory {
    public static SObject create(Schema.SObjectType objTyp, Map<String,Object> props) {
        System.assert(objTyp!=null);
        try {
            SObject cache = ApexCacheManager.getPersistantSObjectByType(objTyp);
            SObject clonedCache = cache.clone(false, false, false, false); //Possible
            System.assert(props!=null && !props.isEmpty());
            for(String key : props.keySet()) {
                clonedCache.put(key, props.get(key));
            }
            return clonedCache;
        }
        catch(Exception ex) {
            System.debug('Underflow detected');
        }

        return updateCache(objTyp,props);
    }

    private static SObject updateCache(Schema.SObjectType objTyp, Map<String,Object> props) {
        SObject record = objTyp.newSObject();
        for(String key : props.keySet()) {
            record.put(key, props.get(key));
        }
        insert record;
        ApexCacheManager.saveToPersistantCache(record);
        return record;
    }
}