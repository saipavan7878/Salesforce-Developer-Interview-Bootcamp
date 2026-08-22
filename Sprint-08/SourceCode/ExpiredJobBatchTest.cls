@IsTest
private class ExpiredJobBatchTest {

    @IsTest
    static void testExpiredJobBatch() {

        // Expired Job
        Job__c expiredJob = new Job__c(
            Name = 'Expired Test Job',
            Company__c = 'TCS',
            Role__c = 'Java Developer',
            Minimum_CGPA__c = 7.0,
            Closing_Date__c = Date.today().addDays(-1),
            Status__c = 'Open'
        );

        // Active Job
        Job__c activeJob = new Job__c(
            Name = 'Active Test Job',
            Company__c = 'Infosys',
            Role__c = 'Software Developer',
            Minimum_CGPA__c = 7.0,
            Closing_Date__c = Date.today().addDays(30),
            Status__c = 'Open'
        );

        insert new List<Job__c>{
            expiredJob,
            activeJob
        };

        Test.startTest();

        Id batchJobId = Database.executeBatch(
            new ExpiredJobBatch(),
            50
        );

        Test.stopTest();

        System.assertNotEquals(
            null,
            batchJobId,
            'ExpiredJobBatch should be submitted.'
        );

        Map<Id, Job__c> jobs = new Map<Id, Job__c>([
            SELECT Id,
                   Status__c,
                   Closing_Date__c
            FROM Job__c
            WHERE Id IN :new Set<Id>{
                expiredJob.Id,
                activeJob.Id
            }
        ]);

        System.assertEquals(
            'Closed',
            jobs.get(expiredJob.Id).Status__c,
            'Expired open job should be closed.'
        );

        System.assertEquals(
            'Open',
            jobs.get(activeJob.Id).Status__c,
            'Active job should remain open.'
        );
    }
}
