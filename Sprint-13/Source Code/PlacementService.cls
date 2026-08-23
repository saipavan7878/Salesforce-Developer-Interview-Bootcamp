public with sharing class PlacementService {

    public static List<Student__c> getEligibleStudents(
        Decimal minimumCGPA
    ) {
        return [
            SELECT Id, Name, CGPA__c, Department__c
            FROM Student__c
            WHERE CGPA__c >= :minimumCGPA
            ORDER BY CGPA__c DESC
        ];
    }

    public static List<Student__c> getStudentsByDepartment(
        String department
    ) {
        return [
            SELECT Id, Name, CGPA__c, Department__c
            FROM Student__c
            WHERE Department__c = :department
            ORDER BY Name
        ];
    }

    public static Application__c createApplication(
        Id studentId,
        Id jobId
    ) {
        Application__c app = new Application__c();

        app.Student__c = studentId;
        app.Job__c = jobId;
        app.Application_Date__c = Date.today();
        app.Status__c = 'Applied';

        insert app;

        return app;
    }

    public static void validateNewApplications(
        List<Application__c> applications
    ) {
        Set<Id> studentIds = new Set<Id>();
        Set<Id> jobIds = new Set<Id>();

        for (Application__c app : applications) {
            if (app.Student__c != null) {
                studentIds.add(app.Student__c);
            }

            if (app.Job__c != null) {
                jobIds.add(app.Job__c);
            }
        }

        Map<Id, Student__c> students = new Map<Id, Student__c>(
            [
                SELECT Id, CGPA__c
                FROM Student__c
                WHERE Id IN :studentIds
            ]
        );

        Map<Id, Job__c> jobs = new Map<Id, Job__c>(
            [
                SELECT Id, Minimum_CGPA__c, Closing_Date__c
                FROM Job__c
                WHERE Id IN :jobIds
            ]
        );

        for (Application__c app : applications) {
            Student__c student = students.get(app.Student__c);
            Job__c job = jobs.get(app.Job__c);

            if (student != null && job != null) {

                if (student.CGPA__c < job.Minimum_CGPA__c) {
                    app.addError(
                        'Student CGPA is below the minimum CGPA required for this job.'
                    );
                }

                if (
                    job.Closing_Date__c != null &&
                    Date.today() > job.Closing_Date__c
                ) {
                    app.addError(
                        'You cannot apply after the job closing date.'
                    );
                }
            }

            if (app.Application_Date__c == null) {
                app.Application_Date__c = Date.today();
            }

            if (app.Status__c == null) {
                app.Status__c = 'Applied';
            }
        }
    }

    public static void bulkUpdateApplicationStatus(
        List<Application__c> applications
    ) {
        List<Application__c> applicationsToUpdate =
            new List<Application__c>();

        for (Application__c app : applications) {
            app.Status__c = 'Shortlisted';
            applicationsToUpdate.add(app);
        }

        if (!applicationsToUpdate.isEmpty()) {
            update applicationsToUpdate;
        }
    }

    public static List<Job__c> getEligibleJobs(Id studentId) {

        Student__c student = [
            SELECT Id, CGPA__c
            FROM Student__c
            WHERE Id = :studentId
            LIMIT 1
        ];

        return [
            SELECT Id,
                   Name,
                   Company__c,
                   Role__c,
                   Minimum_CGPA__c,
                   Closing_Date__c,
                   Status__c
            FROM Job__c
            WHERE Status__c = 'Open'
              AND Closing_Date__c >= TODAY
              AND Minimum_CGPA__c <= :student.CGPA__c
            ORDER BY Closing_Date__c ASC
        ];
    }
}
