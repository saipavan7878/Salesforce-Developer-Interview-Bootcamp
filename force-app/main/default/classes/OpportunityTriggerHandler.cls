/**
 * OpportunityTriggerHandler
 * Bulkified handler for Opportunity automation:
 *  - When a deal moves to Closed Won, auto-create a "Kickoff call" follow-up Task.
 *  (Probability is left to Salesforce's standard stage configuration rather than
 *  duplicated here, to avoid two sources of truth.)
 */
public with sharing class OpportunityTriggerHandler {

    public static void handleAfterUpdate(List<Opportunity> newOpps, Map<Id, Opportunity> oldMap) {
        List<Task> tasksToInsert = new List<Task>();

        for (Opportunity opp : newOpps) {
            Opportunity oldOpp = oldMap.get(opp.Id);

            Boolean justWon = opp.StageName == 'Closed Won' && oldOpp.StageName != 'Closed Won';
            if (justWon) {
                tasksToInsert.add(new Task(
                    WhatId = opp.Id,
                    Subject = 'Kickoff call: ' + opp.Name,
                    ActivityDate = Date.today().addDays(2),
                    Status = 'Not Started',
                    Priority = 'High'
                ));
            }
        }

        if (!tasksToInsert.isEmpty() && Schema.sObjectType.Task.isCreateable()) {
            insert tasksToInsert;
        }
    }
}