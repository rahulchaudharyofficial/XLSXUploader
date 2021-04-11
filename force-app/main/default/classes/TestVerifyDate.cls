@IsTest
private class TestVerifyDate {
    @IsTest
    private static void testCheckDates() {
    }
    
    @IsTest
    private static void testDateWithin30Days() {
        Date d1 = System.today();
        Date d2 = System.today();

        //Scenario 1, d1 is today and d2 in past
        d2=d2.addDays(-15);
        Date d3 = Date.newInstance(d1.year(),d1.month(),Date.daysInMonth(d1.year(),d1.month()));
        System.assert(VerifyDate.CheckDates(d1, d2)== d3);

        d2=d2.addDays(50);
        System.assert(VerifyDate.CheckDates(d1, d2)== d3);

        d2=d2.addDays(-25);
        System.assert(VerifyDate.CheckDates(d1, d2)== d2);

    }

    @IsTest
    private static void testSetEndOfMonthDate() {
    }
}