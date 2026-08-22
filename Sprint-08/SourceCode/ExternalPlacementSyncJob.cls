public with sharing class ExternalPlacementSyncJob implements Queueable {

    private Id offerId;

    @TestVisible
    private static Boolean disableChainingForTest = false;

    public ExternalPlacementSyncJob(Id offerId) {
        this.offerId = offerId;
    }

    public void execute(QueueableContext context) {

        Offer_Letter__c offer = [
            SELECT Id,
                   Name,
                   Application__c,
                   Job__c,
                   Student__c,
                   Offer_Date__c
            FROM Offer_Letter__c
            WHERE Id = :offerId
            LIMIT 1
        ];

        System.debug(
            'External placement synchronization started for Offer: ' +
            offer.Id
        );

        System.debug(
            'Synchronizing Student ' +
            offer.Student__c +
            ' with Job ' +
            offer.Job__c
        );

        System.debug('External sync completed successfully.');

        // Production: continue to Job B.
        // Test: disable chaining so Job A can be tested independently.
        if (!disableChainingForTest) {

            Id notificationJobId = System.enqueueJob(
                new PlacementNotificationJob(offer.Id)
            );

            System.debug(
                'PlacementNotificationJob queued: ' +
                notificationJobId
            );
        }
    }
}
