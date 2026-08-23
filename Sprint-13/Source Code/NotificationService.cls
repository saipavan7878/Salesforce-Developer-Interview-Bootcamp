public with sharing class NotificationService {

    public static void notifyPlacementEvent(
        List<Application__c> applications
    ) {
        for (Application__c app : applications) {
            System.debug(
                'Placement notification triggered for Application: ' +
                app.Id +
                ' | Status: ' +
                app.Status__c
            );
        }
    }
}
