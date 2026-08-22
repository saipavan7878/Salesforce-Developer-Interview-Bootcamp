public static List<Job__c> getEligibleJobs(Id studentId) {

    Student__c student = [
        SELECT Id, CGPA__c
        FROM Student__c
        WHERE Id = :studentId
        LIMIT 1
    ];

    return [
        SELECT Id,
               Name,
               Company__c,
               Role__c,
               Minimum_CGPA__c,
               Closing_Date__c,
               Status__c
        FROM Job__c
        WHERE Status__c = 'Open'
          AND Closing_Date__c >= TODAY
          AND Minimum_CGPA__c <= :student.CGPA__c
        ORDER BY Closing_Date__c ASC
    ];
}
