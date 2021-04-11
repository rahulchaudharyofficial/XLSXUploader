@IsTest
private class RecordProducerTest {
    /**
     * === Test Summary
        NAME                 VALUE
        ───────────────────  ─────────────────────────────────────────────────────
        Outcome              Passed
        Tests Ran            1
        Passing              1
        Failing              0
        Skipped              0
        Pass Rate            100%
        Fail Rate            0%
        Test Start Time      Oct 7, 2020 11:45 AM
        Test Execution Time  1205 ms
        Test Total Time      1205 ms
        Command Time         10635 ms
        Hostname             https://curious-wolf-ng77sz-dev-ed.my.salesforce.com
        Org Id               00D2w000001PvvHEAS
        Username             rahul.chaudhary.1711@curious-wolf-ng77sz.com
        Test Run Id          7072w00001Lr5gp
        User Id              0052w0000014tBAAAY
     */

    @Istest
    static void testGetRecordsWithoutCache() {
        List<Account> aa = new List<Account>();
        for(Integer i=0;i<100;i++) {
            Account a = new Account(Name= 'Test Account '+ (i+1));
            aa.add(a);
        }
        insert aa;

        RecordProducer rp = new RecordProducer();
        List<SObject> records = rp.getRecords(Account.getSObjectType(), 100);
        System.assert(records!=null && !records.isEmpty());       
    }

    /**
     * === Test Results
        TEST NAME                          OUTCOME  MESSAGE  RUNTIME (MS)
        ─────────────────────────────────  ───────  ───────  ────────────
        RecordProducerTest.testGetRecords  Pass              514
        
        === Test Summary
        NAME                 VALUE
        ───────────────────  ─────────────────────────────────────────────────────
        Outcome              Passed
        Tests Ran            1
        Passing              1
        Failing              0
        Skipped              0
        Pass Rate            100%
        Fail Rate            0%
        Test Start Time      Oct 7, 2020 11:57 AM
        Test Execution Time  514 ms
        Test Total Time      514 ms
        Command Time         8183 ms
        Hostname             https://curious-wolf-ng77sz-dev-ed.my.salesforce.com
        Org Id               00D2w000001PvvHEAS
        Username             rahul.chaudhary.1711@curious-wolf-ng77sz.com
        Test Run Id          7072w00001Lr79M
        User Id              0052w0000014tBAAAY
     */
    @IsTest
    static void testGetRecords() {
        for(Integer i=0;i<100;i++) {
            Map<String,Object> props = new Map<String,Object> {
                'Name' => 'Testing Cache'+ (i+1)
            };
            TestDataFactory.create(Account.getSObjectType(), props);
        }
        RecordProducer rp = new RecordProducer();
        List<SObject> records = rp.getRecords(Account.getSObjectType(), 10);
        System.assert(records!=null && !records.isEmpty());       
    }
}