@IsTest
private class DailyLeadProcessorTest {
    @TestSetup
    static void makeData(){
        List<Lead> leds = new List<Lead>();
        for(Integer i=0;i<200;i++) {
            leds.add(
                new Lead(LastName='Dummy_'+i,Company='Shell Company '+i,Status='Open - Not Contacted')
            );
        }

        insert leds;
    }

    @IsTest
    static void test() {
        DailyLeadProcessor instance = new DailyLeadProcessor();
        // Seconds Minutes Hours Day_of_month Month Day_of_week optional_year
        String CRON_JOB='0 0 0 15 3 ? 2022';
        Test.startTest();
        String jobId = System.schedule('Update to Dreamforce', CRON_JOB, instance);
        Test.stopTest();

        List<Lead> records = [Select Id,LeadSource from Lead where LastName like 'Dummy_%' and Company like 'Shell Company%' and status='Open - Not Contacted'];
        if(records!=null && records.size()>0) {
            boolean status=false;
            for(Lead l :records) {
                if(l.LeadSource=='Dreamforce') {
                    status=true;
                }
                else {
                    status=false;
                }
            }
            System.assert(status==true);
        }
    }
}