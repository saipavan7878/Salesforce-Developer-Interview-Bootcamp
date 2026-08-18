public class ApplicationService {

    public static String createApplication(Id studentId, Id jobId) {

        // 1. Retrieve Student
        Student__c student = [
            SELECT Id, Name, CGPA__c
            FROM Student__c
            WHERE Id = :studentId
            LIMIT 1
        ];

        // 2. Retrieve Job
        Job__c job = [
            SELECT Id, Name, Minimum_CGPA__c, Closing_Date__c
            FROM Job__c
            WHERE Id = :jobId
            LIMIT 1
        ];

        // 3. Validate Eligibility
        if (student.CGPA__c < job.Minimum_CGPA__c) {
            return 'Student is not eligible for this job.';
        }

        if (job.Closing_Date__c != null &&
            Date.today() > job.Closing_Date__c) {
            return 'Job application deadline has passed.';
        }

        // 4. Check Duplicate Application
        List<Application__c> existingApplications = [
            SELECT Id
            FROM Application__c
            WHERE Student__c = :studentId
            AND Job__c = :jobId
            LIMIT 1
        ];

        if (!existingApplications.isEmpty()) {
            return 'Student has already applied for this job.';
        }

        // 5. Create Application
        Application__c application = new Application__c(
            Student__c = studentId,
            Job__c = jobId,
            Application_Date__c = Date.today(),
            Status__c = 'Applied'
        );

        // 6. Save Application
        insert application;

        // 7. Return Confirmation
        return 'Application created successfully: ' + application.Id;
    }
}
