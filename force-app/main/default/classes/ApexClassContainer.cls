public with sharing class ApexClassContainer {

    public class ApexTestSuite {
        @AuraEnabled public String apexTestSuiteId {get;set;}
        @AuraEnabled public String apexTestSuiteName {get;set;}
        @AuraEnabled public List<TestSuiteMembership> testSuiteMembership {get;set;}

        public ApexTestSuite() {
            this.apexTestSuiteId = '';
            this.apexTestSuiteName = '';
            this.testSuiteMembership = new List<TestSuiteMembership>();
        }
    }

    public class TestSuiteMembership {
        @AuraEnabled public String testSuiteMembershipId {get;set;}
        @AuraEnabled public String apexClassId {get;set;}
        @AuraEnabled public String apexClassName {get;set;}
        @AuraEnabled public String apexTestSuiteId {get;set;}

        public TestSuiteMembership() {
            this.testSuiteMembershipId = '';
            this.apexClassId = '';
            this.apexClassName = '';
            this.apexTestSuiteId = '';
        }
    }
}