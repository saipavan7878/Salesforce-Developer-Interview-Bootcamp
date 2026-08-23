public with sharing class CandidateSyncQueueable
    implements Queueable, Database.AllowsCallouts {

    private Id applicationId;

    public CandidateSyncQueueable(Id applicationId) {
        this.applicationId = applicationId;
    }

    public void execute(QueueableContext context) {

        Application__c app = [
            SELECT Id,
                   status__c,
                   Student__c,
                   Student__r.Name,
                   Student__r.email__c,
                   Student__r.CGPA__c,
                   Student__r.Department__r.Name,
                   Job__c,
                   Job__r.Name,
                   Job__r.Company__c,
                   Job__r.Role__c
            FROM Application__c
            WHERE Id = :applicationId
            LIMIT 1
        ];

        if (app.status__c != 'Selected') {
            return;
        }

        Map<String, Object> payload = new Map<String, Object>{
            'studentId' => app.Student__c,
            'name' => app.Student__r.Name,
            'email' => app.Student__r.email__c,
            'branch' => app.Student__r.Department__r.Name,
            'cgpa' => app.Student__r.CGPA__c,
            'jobId' => app.Job__c,
            'company' => app.Job__r.Company__c,
            'role' => app.Job__r.Role__c,
            'selectionDate' => String.valueOf(Date.today())
        };

        HttpRequest request = new HttpRequest();

        request.setEndpoint(
            'callout:Recruitment_API/post'
        );

        request.setMethod('POST');

        request.setHeader(
            'Content-Type',
            'application/json'
        );

        request.setBody(
            JSON.serialize(payload)
        );

        HttpResponse response;

        try {

            Http http = new Http();

            response = http.send(request);

            Integer statusCode = response.getStatusCode();

            if (statusCode == 200 || statusCode == 201) {

                app.Integration_Status__c = 'Sent';

                app.External_Candidate_Id__c =
                    'EXT-' + String.valueOf(app.Id);

                app.Last_Integration_Attempt__c =
                    System.now();

                app.Integration_Error__c = null;

            } else if (
                statusCode == 400 ||
                statusCode == 401 ||
                statusCode == 403 ||
                statusCode == 500
            ) {

                app.Integration_Status__c =
                    'Retry Required';

                app.Last_Integration_Attempt__c =
                    System.now();

                app.Integration_Error__c =
                    'HTTP ' +
                    String.valueOf(statusCode) +
                    ': ' +
                    response.getBody();

            } else {

                app.Integration_Status__c = 'Failed';

                app.Last_Integration_Attempt__c =
                    System.now();

                app.Integration_Error__c =
                    'Unexpected HTTP ' +
                    String.valueOf(statusCode) +
                    ': ' +
                    response.getBody();
            }

            update app;

        } catch (Exception e) {

            app.Integration_Status__c =
                'Retry Required';

            app.Last_Integration_Attempt__c =
                System.now();

            app.Integration_Error__c =
                e.getTypeName() + ': ' + e.getMessage();

            update app;
        }
    }
}
