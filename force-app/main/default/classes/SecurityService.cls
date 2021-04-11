/*******************************************************************************
 * Copyright (c) 2020 Asmakam Inc.
 ******************************************************************************/

/**
* @Author               :       rahulchaudharyofficial@outlook.com
* @description          :       class provide APIs for Object & Field level 
*                               permissions
* @since                :       1.0.0
* @version              :       1.0.0
*/
public inherited sharing class SecurityService implements ISecurityService {
    private ISchemaSelector schemaSelector;
    public SecurityService() {
        this.schemaSelector = new SchemaSelector();
    }
    
    private static final Boolean BYPASS_SECURITY = false;

    /*******************************************************************************
     * CRUD permissions for object(s)
     ******************************************************************************/

    public Boolean isAccessible(SObjectType objectType){
        Boolean isAccessible = false;
        if(objectType!=null) {
            if(BYPASS_SECURITY) {
                isAccessible = true;
            }
            else {
                try {
                    SecurityUtils.checkObjectIsReadable(objectType);
                    isAccessible = true;
                }
                catch(SecurityUtils.SecurityException se) {
                    System.debug(se.getMessage());
                }
            }
        }
        return isAccessible;
    }
    public Boolean isCreateable(SObjectType objectType){
        Boolean isCreateable = false;
        if (objectType != null){
            if (BYPASS_SECURITY) {
                isCreateable = true;
            } else {
                try {
                    SecurityUtils.checkObjectIsInsertable(objectType);
                    isCreateable = true;
                } catch(SecurityUtils.SecurityException se) {
                    System.debug(se.getMessage());
                }
            }
        }
        return isCreateable;
    }
    public Boolean isDeletable(SObjectType objectType){
        Boolean isDeleteable = false;
        if (objectType != null){
            if (BYPASS_SECURITY) {
                isDeleteable = true;
            } else {
                try {
                    SecurityUtils.checkObjectIsDeletable(objectType);
                    isDeleteable = true;
                } catch(SecurityUtils.SecurityException se) {
                    System.debug(se.getMessage());
                }
            }
        }
        return isDeleteable;
    }
    public Boolean isUpdateable(SObjectType objectType){
        Boolean isUpdateable = false;
        if (objectType != null){
            if (BYPASS_SECURITY) {
                isUpdateable = true;
            } else {
                try {
                    SecurityUtils.checkObjectIsUpdateable(objectType);
                    isUpdateable = true;
                } catch(SecurityUtils.SecurityException se) {
                    System.debug(se.getMessage());
                }
            }
        }
        return isUpdateable;
    }
    public Boolean isUpsertable(SObjectType objectType){
        Boolean isUpsertable = false;
        if(isCreateable(objectType) && isUpdateable(objectType)){
            isUpsertable = true;
        }
        return isUpsertable;
    }
    public Boolean hasFullPermissions(SObjectType objectType){
        Boolean hasFullPermissions = false;
        if(isAccessible(objectType) && isDeletable(objectType) && isUpsertable(objectType)){
            hasFullPermissions = true;
        }
        return hasFullPermissions;
    }
    public Boolean areAccessible(Set<SObjectType> objectTypes){
        Boolean allObjectsAreAccessible = false;
        if (objectTypes != null) {
            if (BYPASS_SECURITY) {
                allObjectsAreAccessible = true;
            } else {
                allObjectsAreAccessible = true;
                for (SObjectType objectType : objectTypes) {
                    if (!isAccessible(objectType)) {
                        allObjectsAreAccessible = false;
                        break;
                    }
                }
            }
        }
        return allObjectsAreAccessible;
    }
    public Boolean areCreateable(Set<SObjectType> objectTypes){
        Boolean allObjectsAreCreateable = false;
        if (objectTypes != null) {
            if (BYPASS_SECURITY) {
                allObjectsAreCreateable = true;
            } else {
                allObjectsAreCreateable = true;
                for (SObjectType objectType : objectTypes) {
                    if (!isCreateable(objectType)) {
                        allObjectsAreCreateable = false;
                        break;
                    }
                }
            }
        }
        return allObjectsAreCreateable;
    }
    public Boolean areDeletable(Set<SObjectType> objectTypes){
        Boolean allObjectsAreDeletable = false;
        if (objectTypes != null) {
            if (BYPASS_SECURITY) {
                allObjectsAreDeletable = true;
            } else {
                allObjectsAreDeletable = true;
                for (SObjectType objectType : objectTypes) {
                    if (!isDeletable(objectType)) {
                        allObjectsAreDeletable = false;
                        break;
                    }
                }
            }
        }
        return allObjectsAreDeletable;
    }
    public Boolean areUpdateable(Set<SObjectType> objectTypes){
        Boolean allObjectsAreUpdateable = false;
        if (objectTypes != null) {
            if (BYPASS_SECURITY) {
                allObjectsAreUpdateable = true;
            } else {
                allObjectsAreUpdateable = true;
                for (SObjectType objectType : objectTypes) {
                    if (!isUpdateable(objectType)) {
                        allObjectsAreUpdateable = false;
                        break;
                    }
                }
            }
        }
        return allObjectsAreUpdateable;
    }
    public Boolean areUpsertable(Set<SObjectType> objectTypes){
        Boolean allObjectsAreUpsertable = false;
        if(areCreateable(objectTypes) && areUpdateable(objectTypes)){
            allObjectsAreUpsertable = true;
        }
        return allObjectsAreUpsertable;
    }
    public Boolean haveFullPermissions(Set<SObjectType> objectTypes){
        Boolean isUpsertable = false;
        if(areAccessible(objectTypes) && areDeletable(objectTypes) && areUpsertable(objectTypes)){
            isUpsertable = true;
        }
        return isUpsertable;
    }


    /*******************************************************************************
     * FLS (field)
     ******************************************************************************/
    public Boolean isFieldAccessible(SObjectType objectType, String field){
        Boolean isFieldAccessible = false;
        if (isValidObjectAndField(objectType, field) && isAccessible(objectType)) {
            try {
                SecurityUtils.checkFieldIsReadable(objectType, schemaSelector.getFieldMap(objectType).get(field));
                isFieldAccessible = true;
            } catch (SecurityUtils.SecurityException se) {
                System.debug(se.getMessage());
            }
        }
        return isFieldAccessible;
    }
    public Boolean isFieldCreateable(SObjectType objectType, String field){
        Boolean isFieldCreateable = false;
        if (isValidObjectAndField(objectType, field) && isCreateable(objectType)) {
            try {
                SecurityUtils.checkFieldIsInsertable(objectType, schemaSelector.getFieldMap(objectType).get(field));
                isFieldCreateable = true;
            } catch (SecurityUtils.SecurityException se) {
                System.debug(se.getMessage());
            }
        }
        return isFieldCreateable;
    }
    public Boolean isFieldUpdateable(SObjectType objectType, String field){
        Boolean isFieldUpdateable = false;
        if (isValidObjectAndField(objectType, field) && isUpdateable(objectType)) {
            try {
                SecurityUtils.checkFieldIsUpdateable(objectType, schemaSelector.getFieldMap(objectType).get(field));
                isFieldUpdateable = true;
            } catch (SecurityUtils.SecurityException se) {
                System.debug(se.getMessage());
            }
        }
        return isFieldUpdateable;
    }
    public Boolean isFieldUpsertable(SObjectType objectType, String field){
        Boolean isFieldUpsertable = false;
        if(isFieldCreateable(objectType, field) && isFieldUpdateable(objectType, field)){
            isFieldUpsertable = true;
        }
        return isFieldUpsertable;
    }
    public Boolean hasFullPermissions(SObjectType objectType, String field){
        Boolean hasFullPermissions = false;
        if(isFieldAccessible(objectType, field) && isFieldUpsertable(objectType, field)){
            hasFullPermissions = true;
        }
        return hasFullPermissions;
    }
    public Boolean areFieldsAccessible(SObjectType objectType, Set<String> fields){
        Boolean allFieldsAreAccessible = false;
        if (fields != null && !fields.isEmpty() && objectType != null) {
            allFieldsAreAccessible = true;
            for (String field : fields) {
                if (String.isBlank(field) || !isFieldAccessible(objectType, field)) {
                    allFieldsAreAccessible = false;
                    break;
                }
            }
        }
        return allFieldsAreAccessible;
    }
    public Boolean areFieldsCreateable(SObjectType objectType, Set<String> fields){
        Boolean allFieldsAreCreateable = false;
        if (fields != null && !fields.isEmpty() && objectType != null) {
            allFieldsAreCreateable = true;
            for (String field : fields) {
                if (String.isBlank(field) || !isFieldCreateable(objectType, field)) {
                    allFieldsAreCreateable = false;
                    break;
                }
            }
        }
        return allFieldsAreCreateable;
    }
    public Boolean areFieldsUpdateable(SObjectType objectType, Set<String> fields){
        Boolean allFieldsAreUpdateable = false;
        if (fields != null && !fields.isEmpty() && objectType != null) {
            allFieldsAreUpdateable = true;
            for (String field : fields) {
                if (String.isBlank(field) || !isFieldUpdateable(objectType, field)) {
                    allFieldsAreUpdateable = false;
                    break;
                }
            }
        }
        return allFieldsAreUpdateable;
    }
    public Boolean areFieldsUpsertable(SObjectType objectType, Set<String> fields){
        Boolean allObjectsAreUpsertable = false;
        if(areFieldsCreateable(objectType, fields) && areFieldsUpdateable(objectType, fields)){
            allObjectsAreUpsertable = true;
        }
        return allObjectsAreUpsertable;
    }
    public Boolean haveFieldsFullPermissions(SObjectType objectType, Set<String> fields){
        Boolean haveFieldsFullPermissions = false;
        if(areFieldsAccessible(objectType, fields) && areFieldsUpsertable(objectType, fields)){
            haveFieldsFullPermissions = true;
        }
        return haveFieldsFullPermissions;
    }

    /*******************************************************************************
     * FLS helpers
     ******************************************************************************/

    private Boolean isValidObjectAndField(SObjectType objectType, String field) {
        return objectType != null && 
                String.isNotBlank(field) && 
                schemaSelector.getFieldMap(objectType).containsKey(field.toLowerCase());
    }
}