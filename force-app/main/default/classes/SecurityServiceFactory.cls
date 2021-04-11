/*******************************************************************************
 * Copyright (c) 2020 Asmakam Inc.
 ******************************************************************************/

/**
* @Author               :       rahulchaudharyofficial@outlook.com
* @description          :       Factory class for Security Service 
                                CRUD permissions
* @since                :       1.0.0
* @version              :       1.0.0
*/
public with sharing class SecurityServiceFactory {

    private static ISecurityService service;

    @TestVisible
    private static void setInstance(ISecurityService instance){
        service = instance;
    }

    public static ISecurityService getInstance(){
        if(service == null){
            service = (ISecurityService) new SecurityService();
        }
        return service;
    }
}