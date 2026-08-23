public with sharing class ApplicationService {

    public static Application__c createApplication(
        Id studentId,
        Id jobId
    ) {

        List<Application__c> existingApplications = [
            SELECT Id, Status__c
            FROM Application__c
            WHERE Student__c = :studentId
              AND Job__c = :jobId
            LIMIT 1
        ];

        if (!existingApplications.isEmpty()) {
            throw new AuraHandledException(
                'You have already applied for this job.'
            );
        }

        Application__c applicationRecord = new Application__c(
            Student__c = studentId,
            Job__c = jobId,
            Status__c = 'Applied'
        );

        insert applicationRecord;

        return applicationRecord;
    }
}
