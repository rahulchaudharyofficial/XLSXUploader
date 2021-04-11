/*******************************************************************************
 * Copyright (c) 2020 Asmakam Inc.
 ******************************************************************************/

/**
  * @Author               :       rahulchaudharyofficial@outlook.com
  * @description          :       This class provide APIs to interact with Salesforce Schema
  * @since                :       1.0.0
  * @version              :       1.0.0
*/
public without Sharing class SchemaSelector implements ISchemaSelector {
    private Map<String,Schema.SObjectType> cachedSObjTypeMap = Schema.getGlobalDescribe();
    public List<Schema.SObjectType> getAllSObjectTypes() {
        if(!isCacheDescribeValid()) {
            refreshCachedSObjTypeMap();
        }
        return this.cachedSObjTypeMap.values();
    }

    @TestVisible
    private void refreshCachedSObjTypeMap() {
        this.cachedSObjTypeMap = Schema.getGlobalDescribe();
    }

    @TestVisible
    private Boolean isCacheDescribeValid() {
        if(this.cachedSObjTypeMap==null || this.cachedSObjTypeMap.isEmpty()) {
            return false;
        }
        else {
            return true;
        }
    }
    public Schema.SObjectType getSObjectTypeByName(String sObjTypName) {
        if(!String.isBlank(sObjTypName)) {
            if(!isCacheDescribeValid()) {
                refreshCachedSObjTypeMap();
            }
            String key = sObjTypName.toLowerCase();
            if(this.cachedSObjTypeMap.containsKey(key)) {
                return this.cachedSObjTypeMap.get(key);
            }
            else {
                throw new ExceptionContainer.InvalidParamException(Label.PARAM_INVALID);
            }
        }
        else {
            throw new ExceptionContainer.ConstraintViolationException(Label.PARAM_NULL_OR_BLANK);
        }
    }
    public List<Schema.SObjectField> getAllSObjectTypeFieldsBySobjectType(Schema.SObjectType sObjTyp) {
        if(sObjTyp!=null) {
            return sObjTyp.getDescribe().fields.getMap().values();
        }
        else {
            throw new ExceptionContainer.ConstraintViolationException(Label.PARAM_NULL_OR_BLANK);
        }
    }
    public List<Schema.SObjectField> getAllSObjectTypeFieldsBySobjectTypeName(String sObjTypName) {
        if(!String.isBlank(sObjTypName)) {
            if(!isCacheDescribeValid()) {
                refreshCachedSObjTypeMap();
            }
            String key = sObjTypName.toLowerCase();
            if(this.cachedSObjTypeMap.containsKey(key)) {
                return this.cachedSObjTypeMap.get(key).getDescribe().fields.getMap().values();
            }
            else {
                throw new ExceptionContainer.InvalidParamException(Label.PARAM_INVALID);
            }
        }
        else {
            throw new ExceptionContainer.ConstraintViolationException(Label.PARAM_NULL_OR_BLANK);
        }
    }
    public Map<String,Schema.SObjectType> getAllSObjectTypesMap() {
        if(!isCacheDescribeValid()) {
            refreshCachedSObjTypeMap();
        }
        return this.cachedSObjTypeMap;
    }
    public Map<String,Schema.SObjectField> getFieldMap(Schema.SObjectType sObjTyp) {
        if(sObjTyp!=null) {
            return sObjTyp.getDescribe().fields.getMap();
        }
        else {
            throw new ExceptionContainer.ConstraintViolationException(Label.PARAM_NULL_OR_BLANK);
        }
    }
}