/*******************************************************************************
 * Copyright (c) 2020 Asmakam Inc.
 ******************************************************************************/

/**
* @Author               :       rahulchaudharyofficial@outlook.com
* @description          :       Validiting user read access permision for the record Id.
                                UserRecordAccess - Backend object stroes the user access 
                                permissions for the record.
* @since                :       1.0.0
* @version              :       1.0.0
*/
public without sharing class UserRecordAccessService implements IUserRecordAccessService {
    private static final String CONTRACT_VIOLATION ='The Apex/Record/Component: {0} has been used or accessed in an invalid fashion; this operation is not permitted.';

    private String baseQuery = 'Select {} from {} where {}';
    
    public Boolean verifyUserReadAccess(Set<Id> recIdset, Id usrId) {
        if(recIdset.isEmpty() || recIdset == null || String.isBlank(usrId)){
            throw new UserRecordAccessException(String.format(CONTRACT_VIOLATION, new List<String>{'UserRecordAccessService.verifyUserReadAccess'}));
        }
        Boolean userHasAccessToParentRecord = false;
        String condition = 'RecordId IN:recIdset AND UserId=:usrId AND HasReadAccess = true';
        List<String> params = new List<String> {
            'RecordId',
            'UserRecordAccess',
            condition
        };

        String query = String.format(baseQuery,params);
        List<UserRecordAccess> userRecordAccessList = Database.query(query);
        if(!userRecordAccessList.isEmpty()){
            userHasAccessToParentRecord = true;
        }
        return userHasAccessToParentRecord;
    }

    public Boolean verifyRecordIsDeleted (Id recordId){
        if(recordId == null){
            throw new UserRecordAccessException(String.format(CONTRACT_VIOLATION, new List<String>{'UserRecordAccessService.verifyRecordIsDeleted'}));
        }
        Boolean isRecordDeleted = false;
        String condition = 'Id =: recordId';
        List<String> params = new List<String> {
            'RecordId',
            recordId.getSobjectType().getDescribe().getName(),
            condition
        };
        String query = String.format(baseQuery,params);
        List<SObject> retrievedSObjectList = Database.query(query);
        if(retrievedSObjectList.isEmpty()){
            isRecordDeleted = true;
        }
        return isRecordDeleted;
    }
}