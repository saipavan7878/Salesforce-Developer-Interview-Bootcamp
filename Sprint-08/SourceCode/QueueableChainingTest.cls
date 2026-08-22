@IsTest
private class QueueableChainingTest {

    @IsTest
    static void testExternalSyncJob() {

        Student__c student = new Student__c(
            Name = 'Chaining Test Student',
            CGPA__c = 8.5
        );
        insert student;

        Job__c job = new Job__c(
            Name = 'Chaining Test Job',
            Company__c = 'TCS',
            Minimum_CGPA__c = 7.0,
            Closing_Date__c = Date.today().addDays(30)
        );
        insert job;

        Application__c application = new Application__c(
            Student__c = student.Id,
            Job__c = job.Id,
            Status__c = 'Applied'
        );
        insert application;

        Offer_Letter__c offer = new Offer_Letter__c(
            Name = 'Chaining Test Offer',
            Application__c = application.Id,
            Job__c = job.Id,
            Student__c = student.Id,
            Offer_Date__c = Date.today()
        );
        insert offer;

        // Prevent recursive child execution during this unit test.
        ExternalPlacementSyncJob.disableChainingForTest = true;

        Test.startTest();

        Id parentJobId = System.enqueueJob(
            new ExternalPlacementSyncJob(offer.Id)
        );

        Test.stopTest();

        System.assertNotEquals(
            null,
            parentJobId,
            'ExternalPlacementSyncJob should be queued.'
        );

        AsyncApexJob parentJob = [
            SELECT Id, Status, JobType
            FROM AsyncApexJob
            WHERE Id = :parentJobId
            LIMIT 1
        ];

        System.assertEquals(
            'Queueable',
            parentJob.JobType,
            'Expected a Queueable job.'
        );

        System.assertEquals(
            'Completed',
            parentJob.Status,
            'ExternalPlacementSyncJob should complete successfully.'
        );
    }
}
