public with sharing class EligibleJobsController {

    @AuraEnabled(cacheable=true)
    public static List<Job__c> getEligibleJobs(Id studentId) {
        return PlacementService.getEligibleJobs(studentId);
    }
}
