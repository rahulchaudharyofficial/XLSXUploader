/*******************************************************************************
 * Copyright (c) 2020 Asmakam Inc.
 ******************************************************************************/

/**
 * @Author               :       rahulchaudharyofficial@outlook.com
 * @description          :       Factory for AccessGuardService
 * @since                :       1.0.0
 * @version              :       1.0.0
*/
public with sharing class AccessGuardServiceFactory {

    private static IAccessGuardService service;

    @TestVisible
    private static void setInstance(IAccessGuardService instance){
        service = instance;
    }

    public static IAccessGuardService getInstance(){
        if(service == null){
            service = (IAccessGuardService) new AccessGuardService();
        }
        return service;
    }
}