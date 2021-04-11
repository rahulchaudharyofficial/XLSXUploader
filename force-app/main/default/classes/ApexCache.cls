public class ApexCache {
    public static Map<Schema.SObjectType, List<SObject>> persistantCache {
        get {
            if(persistantCache==null) {
                persistantCache = new Map<Schema.SObjectType, List<SObject>>();
            }
            return persistantCache;
        }
        private set;
    }

    public static Map<Schema.SObjectType, List<SObject>> nonPersistantCache {
        get {
            if(nonPersistantCache==null) {
                nonPersistantCache = new Map<Schema.SObjectType, List<SObject>>();
            }
            return nonPersistantCache;
        }
        private set;
    }
}