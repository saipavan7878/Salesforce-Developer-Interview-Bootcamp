public with sharing class ExpiredJobBatch
    implements Database.Batchable<SObject> {

    public Database.QueryLocator start(
        Database.BatchableContext context
    ) {
        return Database.getQueryLocator([
            SELECT Id,
                   Name,
                   Closing_Date__c,
                   Status__c
            FROM Job__c
            WHERE Status__c = 'Open'
              AND Closing_Date__c < TODAY
        ]);
    }

    public void execute(
        Database.BatchableContext context,
        List<Job__c> scope
    ) {

        for (Job__c job : scope) {
            job.Status__c = 'Closed';
        }

        if (!scope.isEmpty()) {
            update scope;
        }
    }

    public void finish(
        Database.BatchableContext context
    ) {
        System.debug(
            'ExpiredJobBatch completed successfully.'
        );
    }
}
