@IsTest
private class ApplicationQueueableChainTest {

    @IsTest
    static void testQueueableChain() {

        Student__c student = new Student__c(
            Name = 'Chain Test Student',
            CGPA__c = 8.5
        );
        insert student;

        Job__c job = new Job__c(
            Name = 'Chain Test Job',
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
            Name = 'Chain Test Offer',
            Application__c = application.Id,
            Job__c = job.Id,
            Student__c = student.Id,
            Offer_Date__c = Date.today()
        );
        insert offer;

        Test.startTest();

        Id jobId = System.enqueueJob(
            new ExternalPlacementSyncJob(offer.Id)
        );

        Test.stopTest();

        System.assertNotEquals(
            null,
            jobId,
            'ExternalPlacementSyncJob should be queued.'
        );
    }
}