/**
 * @Author Rahul Chaudhary
 * @Date 18 Sept 2020
 * @Version 0.1 
 */

public without sharing class ApexTestGenerator {

    private List<ApexClass> testClassList;
    private List<ApexClass> nonTestClassList;

    public ApexTestGenerator() {
        testClassList = getAllTestClasses();
        nonTestClassList = getAllNonTestClasses();

        System.debug('Total Test classes = '+ testClassList.size());
        System.debug('Total Non Test Classes = '+ nonTestClassList.size());
    }

    /**
     * Purpose: This method return Test Classes available in org which are not part of some third party package 
     * Lets call this List as SET A
     */
    @TestVisible
    private List<ApexClass> getAllTestClasses() {
        List<ApexClass> toReturn = new List<ApexClass>();

        List<List<SObject>> output = [FIND 'class and (istest or testmethod or testsetup)' IN ALL Fields RETURNING ApexClass(Id,Name Where NamespacePrefix = null order by name asc)];
        if(output!=null && !output.isEmpty()) {
            toReturn.addAll((List<ApexClass>) output.get(0));
        }
        
        return toReturn;
    }


    /**
     * Purpose: This method return Apex Classes which are not Test classes and are not part of any third party
     * package or app, Lets call this List as a SET B
     */
    @TestVisible
    private List<ApexClass> getAllNonTestClasses() {
        List<Id> testClassIdList = new List<Id>();

        for(ApexClass ac : testClassList) {
            testClassIdList.add(ac.id);
        }
        return [select id, name from apexclass where namespaceprefix=null and id not in :testClassIdList];
    }


    /**
     * Purpose: This method basically does
     * SET B = All classes which are not Test Classes
     * SET A = All classes which are test Classes
     * This method return list of classes from NonTestClasses SET B which possibly do not have a Test class in SET A
     */
    public List<ApexClass> getAllClassWithoutTest() {
        List<ApexClass> toReturn = new List<ApexClass>();
        
        for(ApexClass acOuter : nonTestClassList) {
            
            Boolean isTestAvailable = false;

            for(ApexClass acInner : testClassList) {
                if(acInner.name.toLowerCase().contains(acOuter.name.tolowercase())) {
                    isTestAvailable = true;
                    break;
                }
            }

            if(!isTestAvailable) {
                toReturn.add(acOuter);
            }
        }
        System.debug('Total '+ toReturn.size() + ' classes found which do not have Test Classes');
        return toReturn;
    }
}