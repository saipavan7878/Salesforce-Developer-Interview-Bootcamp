public with sharing class ApplicationController {

    @AuraEnabled
    public static Id applyForJob(Id studentId, Id jobId) {

        Application__c applicationRecord =
            ApplicationService.createApplication(
                studentId,
                jobId
            );

        return applicationRecord.Id;
    }
}