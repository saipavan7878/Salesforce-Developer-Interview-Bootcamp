public with sharing class PlacementNotificationJob implements Queueable {

    private Id offerId;

    public PlacementNotificationJob(Id offerId) {
        this.offerId = offerId;
    }

    public void execute(QueueableContext context) {

        Offer_Letter__c offer = [
            SELECT Id,
                   Name,
                   Student__c,
                   Job__c
            FROM Offer_Letter__c
            WHERE Id = :offerId
            LIMIT 1
        ];

        System.debug(
            'Placement notification processing started for Offer: ' +
            offer.Id
        );

        System.debug(
            'Notification prepared for Student: ' +
            offer.Student__c
        );
    }
}
