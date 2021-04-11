/*******************************************************************************
 * Copyright (c) 2020 Asmakam Inc.
 ******************************************************************************/

/**
* @Author               :       rahulchaudharyofficial@outlook.com
* @description          :       class provide APIs for Object & Field level 
*                               security
* @since                :       1.0.0
* @version              :       1.0.0
*/
public with sharing class AccessGuardService implements IAccessGuardService {
    private ISecurityService secService;

    public AccessGuardService() {
        secService = SecurityServiceFactory.getInstance();
    }
    /** Single Object */
    public void assertAccessible(SObjectType objectType) {
        if(!secService.isAccessible(objectType)){
            throw new AccessViolationException(AccessViolationException.Type.READ_ERROR, objectType);
        }
        return;
    }

    public void assertCreateable(SObjectType objectType) {
        if(!secService.isCreateable(objectType)){
            throw new AccessViolationException(AccessViolationException.Type.CREATE_ERROR, objectType);
        }
        return;
    }

    public void assertDeletable(SObjectType objectType) {
        if(!secService.isDeletable(objectType)){
            throw new AccessViolationException(AccessViolationException.Type.DELETE_ERROR, objectType);
        }
        return;
    }

    public void assertUpdateable(SObjectType objectType) {
        if(!secService.isUpdateable(objectType)){
            throw new AccessViolationException(AccessViolationException.Type.UPDATE_ERROR, objectType);
        }
        return;
    }

    public void assertUpsertable(SObjectType objectType) {
        assertCreateable(objectType);
        assertUpdateable(objectType);

        return;
    }

    public void assertFullPermissions(SObjectType objectType) {
        assertAccessible(objectType);
        assertDeletable(objectType);
        assertUpsertable(objectType);

        return;
    }

    /** Set of Objects */
    public void assertAccessible(Set<SObjectType> objectTypes) {
        if(objectTypes == null){
            throw new AccessViolationException(AccessViolationException.Type.READ_ERROR, null);
        }
        for(SObjectType objectType : objectTypes){
            assertAccessible(objectType);
        }
        return;
    }

    public void assertCreateable(Set<SObjectType> objectTypes) {
        if(objectTypes == null){
            throw new AccessViolationException(AccessViolationException.Type.CREATE_ERROR, null);
        }
        for(SObjectType objectType : objectTypes){
            assertCreateable(objectType);
        }
        return;
    }

    public void assertDeletable(Set<SObjectType> objectTypes) {
        if(objectTypes == null){
            throw new AccessViolationException(AccessViolationException.Type.DELETE_ERROR, null);
        }
        for(SObjectType objectType : objectTypes){
            assertDeletable(objectType);
        }
        return;
    }

    public void assertUpdateable(Set<SObjectType> objectTypes) {
        if(objectTypes == null){
            throw new AccessViolationException(AccessViolationException.Type.UPDATE_ERROR, null);
        }
        for(SObjectType objectType : objectTypes){
            assertUpdateable(objectType);
        }
        return;
    }

    public void assertUpsertable(Set<SObjectType> objectTypes) {
        assertCreateable(objectTypes);
        assertUpdateable(objectTypes);

        return;
    }

    public void assertFullPermissions(Set<SObjectType> objectTypes) {
        assertAccessible(objectTypes);
        assertDeletable(objectTypes);
        assertUpsertable(objectTypes);

        return;
    }

    /** Single Field */
    public void assertFieldAccessible(SObjectType objectType, String field) {
        if(!secService.isFieldAccessible(objectType, field)){
            throw new AccessViolationException(AccessViolationException.Type.READ_ERROR, objectType, field);
        }
        return;
    }

    public void assertFieldCreateable(SObjectType objectType, String field) {
        if(!secService.isFieldCreateable(objectType, field)){
            throw new AccessViolationException(AccessViolationException.Type.CREATE_ERROR, objectType, field);
        }
        return;
    }

    //Deletable does not exist: Do not delete fields in this manner

    public void assertFieldUpdateable(SObjectType objectType, String field) {
        if(!secService.isFieldUpdateable(objectType, field)){
            throw new AccessViolationException(AccessViolationException.Type.UPDATE_ERROR, objectType, field);
        }
        return;
    }

    public void assertFieldUpsertable(SObjectType objectType, String field) {
        assertFieldCreateable(objectType, field);
        assertFieldUpdateable(objectType, field);

        return;
    }

    public void assertFieldHasFullPermissions(SObjectType objectType, String field) {
        assertFieldAccessible(objectType, field);
        assertFieldUpsertable(objectType, field);

        return;
    }

    /** Set of Fields */
    public void assertFieldsAccessible(SObjectType objectType, Set<String> fields) {
        if(fields == null){
            throw new AccessViolationException(AccessViolationException.Type.READ_ERROR,  objectType, null);
        }
        for(String field : fields){
            assertFieldAccessible(objectType, field);
        }
        return;
    }

    public void assertFieldsCreateable(SObjectType objectType, Set<String> fields) {
        if(fields == null){
            throw new AccessViolationException(AccessViolationException.Type.CREATE_ERROR,  objectType, null);
        }
        for(String field : fields){
            assertFieldCreateable(objectType, field);
        }
        return;
    }

    //Deletable does not exist: Do not delete fields in this manner

    public void assertFieldsUpdateable(SObjectType objectType, Set<String> fields) {
        if(fields == null){
            throw new AccessViolationException(AccessViolationException.Type.UPDATE_ERROR,  objectType, null);
        }
        for(String field : fields){
            assertFieldUpdateable(objectType, field);
        }
        return;
    }

    public void assertFieldsUpsertable(SObjectType objectType, Set<String> fields) {
        assertFieldsCreateable(objectType, fields);
        assertFieldsUpdateable(objectType, fields);

        return;
    }

    public void assertFieldsHaveFullPermissions(SObjectType objectType, Set<String> fields) {
        assertFieldsAccessible(objectType, fields);
        assertFieldsUpsertable(objectType, fields);

        return;
    }
}