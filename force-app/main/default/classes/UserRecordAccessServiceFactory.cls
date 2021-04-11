/*******************************************************************************
 * Copyright (c) 2020 Asmakam Inc.
 ******************************************************************************/

/**
* @Author               :       rahulchaudharyofficial@outlook.com
* @description          :       Factory for UserRecordAccessService
* @since                :       1.0.0
* @version              :       1.0.0
*/

public with sharing class UserRecordAccessServiceFactory {
    
    private static IUserRecordAccessService service;
    
    @TestVisible
    private static void setInstance(IUserRecordAccessService instance){
        service = instance;
    }
    
    public static IUserRecordAccessService getInstance(){
        if(service == null){
            service = (IUserRecordAccessService) new UserRecordAccessService();
        }
        return service;
    }    
}