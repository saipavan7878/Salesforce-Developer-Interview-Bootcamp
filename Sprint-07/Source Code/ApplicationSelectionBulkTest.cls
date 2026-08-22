@IsTest
private class ApplicationSelectionBulkTest {

    @IsTest
    static void testBulkSelectionProcessing() {

        List<Student__c> students = new List<Student__c>();

        for (Integer i = 1; i <= 200; i++) {
            students.add(
                new Student__c(
                    Name = 'Selection Test Student ' + i,
                    CGPA__c = 8.5
                )
            );
        }

        insert students;

        Job__c job = new Job__c(
            Name = 'Bulk Selection Job',
            Company__c = 'TCS',
            Minimum_CGPA__c = 7.0,
            Closing_Date__c = Date.today().addDays(30)
        );

        insert job;

        List<Application__c> applications =
            new List<Application__c>();

        for (Student__c student : students) {
            applications.add(
                new Application__c(
                    Student__c = student.Id,
                    Job__c = job.Id,
                    Status__c = 'Applied'
                )
            );
        }

        insert applications;

        for (Application__c app : applications) {
            app.Status__c = 'Selected';
        }

        Test.startTest();

        update applications;

        Test.stopTest();

        List<Application__c> updatedApplications = [
            SELECT Id, Status__c, Student__c, Job__c
            FROM Application__c
            WHERE Id IN :applications
        ];

        System.assertEquals(
            200,
            updatedApplications.size(),
            'Expected 200 Applications.'
        );

        for (Application__c app : updatedApplications) {
            System.assertEquals(
                'Selected',
                app.Status__c
            );
        }

        Set<Id> studentIds = new Set<Id>();

        for (Student__c student : students) {
            studentIds.add(student.Id);
        }

        List<Student__c> updatedStudents = [
            SELECT Id, Placement_Status__c, Joining_Company__c
            FROM Student__c
            WHERE Id IN :studentIds
        ];

        System.assertEquals(
            200,
            updatedStudents.size(),
            'Expected 200 Students.'
        );

        for (Student__c student : updatedStudents) {
            System.assertEquals(
                'Placed',
                student.Placement_Status__c
            );

            System.assertEquals(
                'TCS',
                student.Joining_Company__c
            );
        }
    }
}
