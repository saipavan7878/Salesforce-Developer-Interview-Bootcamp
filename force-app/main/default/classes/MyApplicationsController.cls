public with sharing class MyApplicationsController {

    public class ApplicationRow {
        @AuraEnabled public Id id;
        @AuraEnabled public String jobName;
        @AuraEnabled public String company;
        @AuraEnabled public String role;
        @AuraEnabled public String status;

        public ApplicationRow(
            Application__c applicationRecord
        ) {
            id = applicationRecord.Id;
            jobName = applicationRecord.Job__r.Name;
            company = applicationRecord.Job__r.Company__c;
            role = applicationRecord.Job__r.Role__c;
            status = applicationRecord.Status__c;
        }
    }

    @AuraEnabled(cacheable=true)
    public static List<ApplicationRow> getMyApplications(
        Id studentId
    ) {
        List<Application__c> records = [
            SELECT Id,
                   Status__c,
                   Student__c,
                   Job__c,
                   Job__r.Name,
                   Job__r.Company__c,
                   Job__r.Role__c
            FROM Application__c
            WHERE Student__c = :studentId
            ORDER BY CreatedDate DESC
        ];

        List<ApplicationRow> results = new List<ApplicationRow>();

        for (Application__c applicationRecord : records) {
            results.add(new ApplicationRow(applicationRecord));
        }

        return results;
    }
}