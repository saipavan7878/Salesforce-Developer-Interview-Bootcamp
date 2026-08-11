public class ApplicationTriggerHandler {

    public static void beforeInsert(List<Application__c> applications) {

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
            [SELECT Id, CGPA__c
             FROM Student__c
             WHERE Id IN :studentIds]
        );

        Map<Id, Job__c> jobs = new Map<Id, Job__c>(
            [SELECT Id, Minimum_CGPA__c, Closing_Date__c
             FROM Job__c
             WHERE Id IN :jobIds]
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

                if (job.Closing_Date__c != null &&
                    Date.today() > job.Closing_Date__c) {

                    app.addError(
                        'You cannot apply after the job closing date.'
                    );
                }
            }

            if (app.Application_Date__c == null) {
                app.Application_Date__c = Date.today();
            }

            if (app.status__c == null) {
                app.status__c = 'Applied';
            }
        }
    }
}
