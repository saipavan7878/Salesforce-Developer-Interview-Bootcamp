@IsTest
private class ApplicationTriggerBulkTest {

    @IsTest
    static void testBulkApplicationInsert() {

        // Create test Student
        Student__c student = new Student__c(
            Name = 'Bulk Test Student',
            CGPA__c = 8.5
        );
        insert student;

        // Create test Job
        Job__c job = new Job__c(
            Name = 'Bulk Test Job',
            Minimum_CGPA__c = 7.0,
            Closing_Date__c = Date.today().addDays(30)
        );
        insert job;

        // Create 200 Applications
        List<Application__c> applications =
            new List<Application__c>();

        for (Integer i = 1; i <= 200; i++) {

            applications.add(
                new Application__c(
                    Student__c = student.Id,
                    Job__c = job.Id,
                    Status__c = 'Applied'
                )
            );
        }

        Test.startTest();

        insert applications;

        Test.stopTest();

        // Verify that 200 Applications were created
        Integer applicationCount = [
            SELECT COUNT()
            FROM Application__c
            WHERE Student__c = :student.Id
            AND Job__c = :job.Id
        ];

        System.assertEquals(
            200,
            applicationCount,
            'Expected 200 Applications to be created.'
        );
    }

    @IsTest
static void testBulkUpdateApplicationStatus() {

    Student__c student = new Student__c(
        Name = 'DML Test Student',
        CGPA__c = 8.5
    );
    insert student;

    Job__c job = new Job__c(
        Name = 'DML Test Job',
        Minimum_CGPA__c = 7.0,
        Closing_Date__c = Date.today().addDays(30)
    );
    insert job;

    List<Application__c> applications =
        new List<Application__c>();

    for (Integer i = 1; i <= 200; i++) {
        applications.add(
            new Application__c(
                Student__c = student.Id,
                Job__c = job.Id,
                Status__c = 'Applied'
            )
        );
    }

    insert applications;

    Test.startTest();

    PlacementService.bulkUpdateApplicationStatus(applications);

    Test.stopTest();

    List<Application__c> updatedApplications = [
        SELECT Id, Status__c
        FROM Application__c
        WHERE Student__c = :student.Id
        AND Job__c = :job.Id
    ];

    System.assertEquals(
        200,
        updatedApplications.size(),
        'Expected 200 Applications.'
    );

    for (Application__c app : updatedApplications) {
        System.assertEquals(
            'Shortlisted',
            app.Status__c,
            'All Applications should be Shortlisted.'
        );
    }
}
}