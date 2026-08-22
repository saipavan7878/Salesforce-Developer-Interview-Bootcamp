public class ApplicationTriggerHandler {

    public static void beforeInsert(List<Application__c> applications) {
        PlacementService.validateNewApplications(applications);
    }

    public static void afterUpdate(
        List<Application__c> applications,
        Map<Id, Application__c> oldMap
    ) {
        List<Application__c> selectedApplications =
            new List<Application__c>();

        List<Application__c> notificationApplications =
            new List<Application__c>();

        for (Application__c app : applications) {

            Application__c oldApp = oldMap.get(app.Id);

            if (app.Status__c == 'Selected' &&
                oldApp.Status__c != 'Selected') {

                selectedApplications.add(app);
                notificationApplications.add(app);
            }

            if (
                (app.Status__c == 'Interview Scheduled' &&
                 oldApp.Status__c != 'Interview Scheduled') ||

                (app.Status__c == 'Rejected' &&
                 oldApp.Status__c != 'Rejected') ||

                (app.Status__c == 'Offer Accepted' &&
                 oldApp.Status__c != 'Offer Accepted')
            ) {
                notificationApplications.add(app);
            }
        }

        if (!selectedApplications.isEmpty()) {

            Set<Id> studentIds = new Set<Id>();
            Set<Id> jobIds = new Set<Id>();

            for (Application__c app : selectedApplications) {
                if (app.Student__c != null) {
                    studentIds.add(app.Student__c);
                }

                if (app.Job__c != null) {
                    jobIds.add(app.Job__c);
                }
            }

            Map<Id, Student__c> studentsById =
                new Map<Id, Student__c>(
                    [
                        SELECT Id,
                               Placement_Status__c,
                               Joining_Company__c
                        FROM Student__c
                        WHERE Id IN :studentIds
                    ]
                );

            Map<Id, Job__c> jobsById =
                new Map<Id, Job__c>(
                    [
                        SELECT Id, Company__c
                        FROM Job__c
                        WHERE Id IN :jobIds
                    ]
                );

            List<Student__c> studentsToUpdate =
                new List<Student__c>();

            for (Application__c app : selectedApplications) {

                Student__c student =
                    studentsById.get(app.Student__c);

                Job__c job =
                    jobsById.get(app.Job__c);

                if (student != null) {

                    student.Placement_Status__c = 'Placed';

                    if (job != null) {
                        student.Joining_Company__c = job.Company__c;
                    }

                    studentsToUpdate.add(student);
                }
            }

            if (!studentsToUpdate.isEmpty()) {
                update studentsToUpdate;
            }
        }

        if (!notificationApplications.isEmpty()) {
            NotificationService.notifyPlacementEvent(
                notificationApplications
            );
        }

        if (!selectedApplications.isEmpty()) {
            StatisticsService.updatePlacementStatistics(
                selectedApplications
            );
        }
    }
}
