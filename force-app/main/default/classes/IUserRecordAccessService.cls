/*******************************************************************************
 * Copyright (c) 2020 Asmakam Inc.
 ******************************************************************************/

/**
* @Author               :       rahulchaudharyofficial@outlook.com
* @description          :       class provide APIs for record level access
* @since                :       1.0.0
* @version              :       1.0.0
*/
public interface IUserRecordAccessService {
    Boolean verifyUserReadAccess(Set<Id> recIdset, Id usrId);  
    Boolean verifyRecordIsDeleted(Id recordId);    
}