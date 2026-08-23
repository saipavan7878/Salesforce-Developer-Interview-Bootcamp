@isTest
private class OpportunityTriggerHandlerTest {

    @TestSetup
    static void setup() {
        Account acc = new Account(Name = 'Trigger Test Account');
        insert acc;

        insert new Opportunity(
            Name = 'Trigger Deal',
            AccountId = acc.Id,
            StageName = 'Negotiation/Review',
            CloseDate = Date.today().addDays(10)
        );
    }

    @isTest
    static void testClosedWonCreatesKickoffTask() {
        Opportunity opp = [SELECT Id FROM Opportunity LIMIT 1];

        Test.startTest();
        opp.StageName = 'Closed Won';
        update opp;
        Test.stopTest();

        List<Task> kickoffTasks = [
            SELECT Id, Subject, Priority FROM Task WHERE WhatId = :opp.Id
        ];
        System.assertEquals(1, kickoffTasks.size(), 'Expected exactly one kickoff task');
        System.assert(kickoffTasks[0].Subject.startsWith('Kickoff call'));
    }

    @isTest
    static void testStageChangeWithoutClosedWonCreatesNoTask() {
        Opportunity opp = [SELECT Id FROM Opportunity LIMIT 1];

        Test.startTest();
        opp.StageName = 'Proposal/Price Quote';
        update opp;
        Test.stopTest();

        List<Task> tasks = [SELECT Id FROM Task WHERE WhatId = :opp.Id];
        System.assertEquals(0, tasks.size(), 'No kickoff task expected for non Closed-Won stage change');
    }

    @isTest
    static void testBulkClosedWonUpdate() {
        Account acc = [SELECT Id FROM Account LIMIT 1];
        List<Opportunity> bulkOpps = new List<Opportunity>();
        for (Integer i = 0; i < 50; i++) {
            bulkOpps.add(new Opportunity(
                Name = 'Bulk Deal ' + i,
                AccountId = acc.Id,
                StageName = 'Negotiation/Review',
                CloseDate = Date.today().addDays(5)
            ));
        }
        insert bulkOpps;

        Test.startTest();
        for (Opportunity o : bulkOpps) {
            o.StageName = 'Closed Won';
        }
        update bulkOpps;
        Test.stopTest();

        Integer taskCount = [SELECT COUNT() FROM Task WHERE Subject LIKE 'Kickoff call: Bulk Deal%'];
        System.assertEquals(50, taskCount, 'Handler should be bulk-safe across 50 records');
    }
}