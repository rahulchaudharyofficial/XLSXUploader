public interface ISchemaSelector {
    Map<String,Schema.SObjectType> getAllSObjectTypesMap();
    Map<String,Schema.SObjectField> getFieldMap(Schema.SObjectType sObjTyp);
    List<Schema.SObjectType> getAllSObjectTypes();
    Schema.SObjectType getSObjectTypeByName(String sObjTypName);
    List<Schema.SObjectField> getAllSObjectTypeFieldsBySobjectType(Schema.SObjectType sObjTyp);
    List<Schema.SObjectField> getAllSObjectTypeFieldsBySobjectTypeName(String sObjTypName);
}