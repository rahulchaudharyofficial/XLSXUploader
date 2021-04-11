public class DummyEventSubscriber {
    public static void process(List<Dummy_Event__e> newRecords,List<Dummy_Event__e> oldRecords,Map<Id,Dummy_Event__e> newMap,Map<Id,Dummy_Event__e> oldMap) {
        for(Dummy_Event__e e : newRecords) {
            System.debug(e);
        }
    }
}