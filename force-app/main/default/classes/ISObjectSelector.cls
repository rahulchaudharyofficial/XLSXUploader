public interface ISObjectSelector {
    Schema.SObjectType sObjectType();
    List<SObject> selectSObjectsById(Set<Id> idSet);
}