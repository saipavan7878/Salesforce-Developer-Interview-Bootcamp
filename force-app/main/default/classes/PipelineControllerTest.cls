@isTest
private class PipelineControllerTest {

    @TestSetup
    static void setup() {
        Account acc = new Account(Name = 'Test Account');
        insert acc;

        List<Opportunity> opps = new List<Opportunity>{
            new Opportunity(Name = 'Deal 1', AccountId = acc.Id, StageName = 'Prospecting',
                             CloseDate = Date.today().addDays(30), Amount = 10000),
            new Opportunity(Name = 'Deal 2', AccountId = acc.Id, StageName = 'Qualification',
                             CloseDate = Date.today().addDays(20), Amount = 25000),
            new Opportunity(Name = 'Deal 3', AccountId = acc.Id, StageName = 'Closed Won',
                             CloseDate = Date.today().addDays(-1), Amount = 50000)
        };
        insert opps;
    }

    @isTest
    static void testGetPipelineReturnsAllStages() {
        Test.startTest();
        List<PipelineController.StageColumn> columns = PipelineController.getPipeline();
        Test.stopTest();

        System.assert(!columns.isEmpty(), 'Pipeline should return stage columns');

        Boolean foundProspecting = false;
        Boolean foundClosedWon = false;
        for (PipelineController.StageColumn col : columns) {
            if (col.stageName == 'Prospecting' && !col.opportunities.isEmpty()) {
                foundProspecting = true;
            }
            if (col.stageName == 'Closed Won' && col.stageTotal == 50000) {
                foundClosedWon = true;
            }
        }
        System.assert(foundProspecting, 'Prospecting column should contain Deal 1');
        System.assert(foundClosedWon, 'Closed Won column total should equal 50000');
    }

    @isTest
    static void testUpdateOpportunityStageSuccess() {
        Opportunity opp = [SELECT Id, StageName FROM Opportunity WHERE Name = 'Deal 1' LIMIT 1];

        Test.startTest();
        PipelineController.updateOpportunityStage(opp.Id, 'Negotiation/Review');
        Test.stopTest();

        Opportunity updated = [SELECT StageName FROM Opportunity WHERE Id = :opp.Id];
        System.assertEquals('Negotiation/Review', updated.StageName);
    }

    @isTest
    static void testUpdateOpportunityStageInvalidIdThrows() {
        Boolean errorCaught = false;
        Test.startTest();
        try {
            PipelineController.updateOpportunityStage(null, 'Closed Won');
        } catch (Exception e) {
            errorCaught = true;
        }
        Test.stopTest();
        System.assert(errorCaught, 'Expected an exception for null Id');
    }
}