@IsTest
private class ExpiredJobSchedulerTest {

    @IsTest
    static void testExpiredJobScheduler() {

        Test.startTest();

        String cronExpression = '0 0 6 * * ?';

        String scheduledJobId = System.schedule(
            'Expired Job Test Schedule',
            cronExpression,
            new ExpiredJobScheduler()
        );

        Test.stopTest();

        System.assertNotEquals(
            null,
            scheduledJobId,
            'Scheduled Apex job should be created.'
        );
    }
}