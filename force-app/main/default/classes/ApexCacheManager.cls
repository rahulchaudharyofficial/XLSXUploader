public class ApexCacheManager {
    private static final String REQUIRED_PARAM_ERROR = 'Required param(s) null or empty';
    private static final String CACHE_UNDERFLOW_ERROR='Cache is not available or empty';

    public static SObject getPersistantSObjectByType(Schema.SObjectType sObjType) {
        System.assert(sObjType!=null,REQUIRED_PARAM_ERROR);
        List<SObject> cache = ApexCache.persistantCache.get(sObjType);
        if(cache!=null && !cache.isEmpty()) {
            return cache.get(0);
        }
        throw new CacheUnderflowException();
    }

    public static SObject getNonPersistantSObjectByType(Schema.SObjectType sObjType) {
        System.assert(sObjType!=null,REQUIRED_PARAM_ERROR);
        List<SObject> cache = ApexCache.nonPersistantCache.get(sObjType);
        if(cache!=null && !cache.isEmpty()) {
            return cache.get(0);
        }
        throw new CacheUnderflowException();
    }

    public static void saveToPersistantCache(SObject record) {
        System.assert(record!=null,REQUIRED_PARAM_ERROR);
        
        if(ApexCache.persistantCache.containsKey(record.getSObjectType())) {
            List<SObject> cacheRecords = ApexCache.persistantCache.get(record.getSObjectType());
            if(cacheRecords==null) {
                cacheRecords = new List<SObject> {record};
                ApexCache.persistantCache.put(record.getSObjectType(), cacheRecords);
            }
            else {
                ApexCache.persistantCache.get(record.getSObjectType()).add(record);
            }
        }
        else {
            ApexCache.persistantCache.put(record.getSObjectType(), new List<SObject> {record});
        }
        System.debug('Updated cache is '+ JSON.serialize(ApexCache.persistantCache));
    }

    public static void saveToNonPersistantCache(SObject record) {
        System.assert(record!=null,REQUIRED_PARAM_ERROR);
        
        if(ApexCache.nonPersistantCache.containsKey(record.getSObjectType())) {
            List<SObject> cacheRecords = ApexCache.nonPersistantCache.get(record.getSObjectType());
            if(cacheRecords==null) {
                cacheRecords = new List<SObject> {record};
                ApexCache.nonPersistantCache.put(record.getSObjectType(), cacheRecords);
            }
            else {
                ApexCache.nonPersistantCache.get(record.getSObjectType()).add(record);
            }
        }

        System.debug('Updated cache is '+ JSON.serialize(ApexCache.nonPersistantCache));
    }

    class CacheUnderflowException extends Exception {}
    class ConstraintViolationException extends Exception {}
}