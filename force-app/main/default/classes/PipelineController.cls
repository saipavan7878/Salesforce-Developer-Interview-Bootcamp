/**
 * PipelineController
 * Exposes Opportunity pipeline data to the pipelineBoard LWC and handles
 * stage updates triggered by drag-and-drop on the Kanban board.
 */
public with sharing class PipelineController {

    public class StageColumn {
        @AuraEnabled public String stageName;
        @AuraEnabled public List<Opportunity> opportunities;
        @AuraEnabled public Decimal stageTotal;
    }

    private static final List<String> STAGE_ORDER = new List<String>{
        'Prospecting', 'Qualification', 'Needs Analysis',
        'Proposal/Price Quote', 'Negotiation/Review', 'Closed Won', 'Closed Lost'
    };

    @AuraEnabled(cacheable=true)
    public static List<StageColumn> getPipeline() {
        Map<String, StageColumn> columnsByStage = new Map<String, StageColumn>();
        for (String stage : STAGE_ORDER) {
            StageColumn col = new StageColumn();
            col.stageName = stage;
            col.opportunities = new List<Opportunity>();
            col.stageTotal = 0;
            columnsByStage.put(stage, col);
        }

        List<Opportunity> opps = [
            SELECT Id, Name, Amount, StageName, CloseDate, Probability,
                   Account.Name, Owner.Name
            FROM Opportunity
            WHERE IsClosed = false OR CloseDate = LAST_N_DAYS:30
            WITH SECURITY_ENFORCED
            ORDER BY CloseDate ASC
            LIMIT 500
        ];

        for (Opportunity o : opps) {
            if (!columnsByStage.containsKey(o.StageName)) {
                StageColumn col = new StageColumn();
                col.stageName = o.StageName;
                col.opportunities = new List<Opportunity>();
                col.stageTotal = 0;
                columnsByStage.put(o.StageName, col);
            }
            StageColumn col = columnsByStage.get(o.StageName);
            col.opportunities.add(o);
            col.stageTotal += (o.Amount != null ? o.Amount : 0);
        }

        List<StageColumn> result = new List<StageColumn>();
        for (String stage : STAGE_ORDER) {
            result.add(columnsByStage.get(stage));
        }
        return result;
    }

    @AuraEnabled
    public static void updateOpportunityStage(Id opportunityId, String newStage) {
        if (!Schema.sObjectType.Opportunity.isUpdateable()) {
            throw new AuraHandledException('You do not have permission to update Opportunities.');
        }
        Opportunity opp = new Opportunity(Id = opportunityId, StageName = newStage);
        try {
            update opp;
        } catch (DmlException e) {
            throw new AuraHandledException('Could not move deal: ' + e.getDmlMessage(0));
        }
    }
}