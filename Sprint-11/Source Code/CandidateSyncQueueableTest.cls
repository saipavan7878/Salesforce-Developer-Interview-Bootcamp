@IsTest
private class CandidateSyncQueueableTest {

    private class RecruitmentApiMock implements HttpCalloutMock {

        public HttpResponse respond(HttpRequest request) {

            System.assertEquals(
                'POST',
                request.getMethod()
            );

            System.assertEquals(
                'callout:Recruitment_API/post',
                request.getEndpoint()
            );

            HttpResponse response = new HttpResponse();

            response.setStatusCode(201);

            response.setHeader(
                'Content-Type',
                'application/json'
            );

            response.setBody(
                '{"id":"EXT-10045","success":true,"message":"Candidate created successfully"}'
            );

            return response;
        }
    }

    @IsTest
    static void testCandidateSyncQueueableSuccess() {

        Department__c department = new Department__c(
            Name = 'CSE'
        );
        insert department;

        Student__c student = new Student__c(
            Name = 'Test Student',
            email__c = 'test@example.com',
            CGPA__c = 8.5,
            Department__c = department.Id,
            phone__c = '9999999999'
        );
        insert student;

        Job__c job = new Job__c(
            Name = 'Test Salesforce Developer',
            Company__c = 'TCS',
            Role__c = 'Salesforce Developer',
            Minimum_CGPA__c = 7.0,
            Closing_Date__c = Date.today().addDays(30),
            Status__c = 'Open'
        );
        insert job;

        Application__c applicationRecord = new Application__c(
            Student__c = student.Id,
            Job__c = job.Id,
            status__c = 'Selected'
        );
        insert applicationRecord;

        Test.setMock(
            HttpCalloutMock.class,
            new RecruitmentApiMock()
        );

        Test.startTest();

        System.enqueueJob(
            new CandidateSyncQueueable(
                applicationRecord.Id
            )
        );

        Test.stopTest();

        Application__c result = [
            SELECT Id,
                   status__c,
                   Integration_Status__c,
                   External_Candidate_Id__c,
                   Last_Integration_Attempt__c,
                   Integration_Error__c
            FROM Application__c
            WHERE Id = :applicationRecord.Id
        ];

        System.assertEquals(
            'Selected',
            result.status__c
        );

        System.assertEquals(
            'Sent',
            result.Integration_Status__c,
            'Integration failed: ' + result.Integration_Error__c
        );

        System.assertNotEquals(
            null,
            result.External_Candidate_Id__c
        );

        System.assertNotEquals(
            null,
            result.Last_Integration_Attempt__c
        );

        System.assertEquals(
            null,
            result.Integration_Error__c
        );
    }
}
