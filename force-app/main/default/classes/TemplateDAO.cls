public with sharing class TemplateDAO {
    @AuraEnabled private String id {get;set;}
    @AuraEnabled private String title {get;set;}
    @AuraEnabled private String name {get;set;}
    @AuraEnabled private Boolean enabled {get;set;}
    @AuraEnabled private Boolean landscape {get;set;}
    @AuraEnabled private Boolean esignature {get;set;}
    @AuraEnabled private String description {get;set;}
    @AuraEnabled private String   templateId  {get;set;}
    @AuraEnabled private String   createdBy   {get;set;}
}