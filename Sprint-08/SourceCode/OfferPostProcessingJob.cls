public with sharing class OfferPostProcessingJob implements Queueable {

    private Id offerId;

    public OfferPostProcessingJob(Id offerId) {
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

        System.debug('Queueable Offer Processing Started');
        System.debug('Offer Id: ' + offer.Id);
        System.debug('Offer Name: ' + offer.Name);
        System.debug('Application Id: ' + offer.Application__c);
        System.debug('Job Id: ' + offer.Job__c);
        System.debug('Student Id: ' + offer.Student__c);
        System.debug('Offer Date: ' + offer.Offer_Date__c);
    }
}
