public without sharing class ApexClassManager {

    @AuraEnabled(cacheable=true)
    public static ApexTestDTO getApexTestConfiguration() {
        List<ApexTestSuite> suites = [select id, TestSuiteName from ApexTestSuite where isDeleted=false];
        ApexTestDTO output = new ApexTestDTO();
        List<ApexClassContainer.ApexTestSuite> toReturn = new List<ApexClassContainer.ApexTestSuite>();
        if(suites!=null && !suites.isEmpty()) {
            List<TestSuiteMembership> members = [select id,ApexClassId,ApexClass.Name,ApexTestSuiteId from TestSuiteMembership where IsDeleted = false];
            for(ApexTestSuite suite : suites) {
                ApexClassContainer.ApexTestSuite temp = new ApexClassContainer.ApexTestSuite();
                temp.apexTestSuiteId = suite.Id;
                temp.apexTestSuiteName = suite.TestSuiteName;
                List<ApexClassContainer.TestSuiteMembership> memberships = new List<ApexClassContainer.TestSuiteMembership>();
                for(TestSuiteMembership member : members) {
                    if(member.ApexTestSuiteId == suite.Id) {
                        ApexClassContainer.TestSuiteMembership memship = new ApexClassContainer.TestSuiteMembership();
                        memship.apexClassId = member.ApexClassId;
                        memship.apexClassName = member.ApexClass.Name;
                        memship.apexTestSuiteId = suite.id;
                        memship.testSuiteMembershipId = member.Id;
                        memberships.add(memship);
                    }
                }
                temp.testSuiteMembership = memberships;
                toReturn.add(temp);
            }
        }
        output.values = toReturn;
        return output;
    }

    public static Map<String,Object> buildActions() {
        Map<String,Object> actions = new Map<String,Object>();
        Map<String,List<Map<String,String>>> acts = new Map<String, List<Map<String,String>>> {
            'rowActions'  => new List<Map<String,String>> {
                                    new Map<String,String> {'label' => 'Delete',
                                        'name' => 'Delete'
                                    },
                                    new Map<String,String> {'label' => 'Edit',
                                        'name' => 'Edit'
                                    },
                                    new Map<String,String> {'label' => 'View',
                                       'name' => 'View'
                                    }
            }
        };
        actions.put('type','action');
        actions.put('typeAttributes',acts);
        return actions;
    }

    public class ApexTestDTO {
        @AuraEnabled public List<Object> columns = new List<Object> {
            new ApexTestColumn('Id','Id','text'),
            new ApexTestColumn('Name','Name','text'),
            buildActions()
        };

        @AuraEnabled public List<ApexClassContainer.ApexTestSuite> values = new List<ApexClassContainer.ApexTestSuite>();
    }


    public class ApexTestAction {
        @AuraEnabled public String type {get;set;}
        @AuraEnabled public Map<String,Map<String,List<Map<String,String>>>> typeAttributes = new Map<String,Map<String,List<Map<String,String>>>> ();
        public ApexTestAction(String type, Map<String,Map<String,List<Map<String,String>>>> typeAttributes) {
            this.type = type;
            this.typeAttributes = typeAttributes;
        }
    }

    public class ApexTestColumn {
        @AuraEnabled public String label {get;set;}
        @AuraEnabled public String fieldName {get;set;}
        @AuraEnabled public String type {get;set;}

        public ApexTestColumn(String label,String fieldName,String type) {
            this.label = label;
            this.fieldName = fieldName;
            this.type = type;
        }
    }
}