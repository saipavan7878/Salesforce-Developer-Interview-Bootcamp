@IsTest
private class OfferPostProcessingJobTest {

    @IsTest
    static void testOfferPostProcessingJob() {

        // Create Student
        Student__c student = new Student__c(
            Name = 'Queueable Test Student',
            CGPA__c = 8.5
        );
        insert student;

        // Create Job
        Job__c job = new Job__c(
            Name = 'Queueable Test Job',
            Company__c = 'TCS',
            Minimum_CGPA__c = 7.0,
            Closing_Date__c = Date.today().addDays(30)
        );
        insert job;

        // Create Application
        Application__c application = new Application__c(
            Student__c = student.Id,
            Job__c = job.Id,
            Status__c = 'Selected'
        );
        insert application;

        // Create Offer Letter
        Offer_Letter__c offer = new Offer_Letter__c(
            Name = 'Queueable Test Offer',
            Application__c = application.Id,
            Job__c = job.Id,
            Student__c = student.Id,
            Offer_Date__c = Date.today()
        );
        insert offer;

        Test.startTest();

        Id jobId = System.enqueueJob(
            new OfferPostProcessingJob(offer.Id)
        );

        Test.stopTest();

        System.assertNotEquals(
            null,
            jobId,
            'Queueable job should be submitted successfully.'
        );
    }
}