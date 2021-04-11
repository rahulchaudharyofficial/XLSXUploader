/*******************************************************************************
 * Copyright (c) 2020 Asmakam Inc.
 ******************************************************************************/

/**
* @description          :       Interface for the service for providing meaninful exceptions on access violations
* @since                :       1.0.0
* @version              :       1.0.0
*/

public interface IAccessGuardService {
    // Single Object verification
    void assertAccessible(SObjectType objectType);
    void assertCreateable(SObjectType objectType);
    void assertDeletable(SObjectType objectType);
    void assertUpdateable(SObjectType objectType);
    void assertUpsertable(SObjectType objectType);
    void assertFullPermissions(SObjectType objectType);
    
    // Set of Objects Verification
    void assertAccessible(Set<SObjectType> objectTypes);
    void assertCreateable(Set<SObjectType> objectTypes);
    void assertDeletable(Set<SObjectType> objectTypes);
    void assertUpdateable(Set<SObjectType> objectTypes);
    void assertUpsertable(Set<SObjectType> objectTypes);
    void assertFullPermissions(Set<SObjectType> objectTypes);

    // Single Field verification
    void assertFieldAccessible(SObjectType objectType, String field);
    void assertFieldCreateable(SObjectType objectType, String field);
    void assertFieldUpdateable(SObjectType objectType, String field);
    void assertFieldUpsertable(SObjectType objectType, String field);
    void assertFieldHasFullPermissions(SObjectType objectType, String field);
    
    // Set of Fields Verification
    void assertFieldsAccessible(SObjectType objectType, Set<String> fields);
    void assertFieldsCreateable(SObjectType objectType, Set<String> fields);
    void assertFieldsUpdateable(SObjectType objectType, Set<String> fields);
    void assertFieldsUpsertable(SObjectType objectType, Set<String> fields);
    void assertFieldsHaveFullPermissions(SObjectType objectType, Set<String> fields);
}