public class ApplicationTriggerHandler {

    // BEFORE INSERT
    public static void beforeInsert(List<Application__c> applications) {

        PlacementService.validateNewApplications(applications);
    }


    // AFTER UPDATE
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

            // Status changed to Selected
            if (app.Status__c == 'Selected' &&
                oldApp.Status__c != 'Selected') {

                selectedApplications.add(app);
                notificationApplications.add(app);
            }

            // Other important placement events
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
            StatisticsService.updatePlacementStatistics(
                selectedApplications
            );
        }

        if (!notificationApplications.isEmpty()) {
            NotificationService.notifyPlacementEvent(
                notificationApplications
            );
        }
    }
}
