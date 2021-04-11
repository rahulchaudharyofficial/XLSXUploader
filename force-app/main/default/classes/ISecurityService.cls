/*******************************************************************************
 * Copyright (c) 2020 Asmakam Inc.
 ******************************************************************************/

/**
* @description          :       Interface provide APIs for Object & Field level permissions
* @since                :       1.0.0
* @version              :       1.0.0
*/
public interface ISecurityService {
    Boolean isAccessible(SObjectType objectType);
    Boolean isCreateable(SObjectType objectType);
    Boolean isDeletable(SObjectType objectType);
    Boolean isUpdateable(SObjectType objectType);
    Boolean isUpsertable(SObjectType objectType);
    Boolean hasFullPermissions(SObjectType objectType);
    Boolean areAccessible(Set<SObjectType> objectTypes);
    Boolean areCreateable(Set<SObjectType> objectTypes);
    Boolean areDeletable(Set<SObjectType> objectTypes);
    Boolean areUpdateable(Set<SObjectType> objectTypes);
    Boolean areUpsertable(Set<SObjectType> objectTypes);
    Boolean haveFullPermissions(Set<SObjectType> objectTypes);
    Boolean isFieldAccessible(SObjectType objectType, String field);
    Boolean isFieldCreateable(SObjectType objectType, String field);
    Boolean isFieldUpdateable(SObjectType objectType, String field);
    Boolean isFieldUpsertable(SObjectType objectType, String field);
    Boolean hasFullPermissions(SObjectType objectType, String field);
    Boolean areFieldsAccessible(SObjectType objectType, Set<String> fields);
    Boolean areFieldsCreateable(SObjectType objectType, Set<String> fields);
    Boolean areFieldsUpdateable(SObjectType objectType, Set<String> fields);
    Boolean areFieldsUpsertable(SObjectType objectType, Set<String> fields);
    Boolean haveFieldsFullPermissions(SObjectType objectType, Set<String> fields);
}