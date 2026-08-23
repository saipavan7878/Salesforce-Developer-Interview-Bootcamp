@IsTest
private class PlacementNotificationJobTest {

    @IsTest
    static void testNotificationJob() {

        Student__c student = new Student__c(
            Name = 'Notification Test Student',
            CGPA__c = 8.5
        );
        insert student;

        Job__c job = new Job__c(
            Name = 'Notification Test Job',
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
            Name = 'Notification Test Offer',
            Application__c = application.Id,
            Job__c = job.Id,
            Student__c = student.Id,
            Offer_Date__c = Date.today()
        );
        insert offer;

        Test.startTest();

        Id jobId = System.enqueueJob(
            new PlacementNotificationJob(offer.Id)
        );

        Test.stopTest();

        System.assertNotEquals(
            null,
            jobId,
            'Notification Queueable should be submitted.'
        );
    }
}