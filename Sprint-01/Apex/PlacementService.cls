public class PlacementService {

    public static List<Student__c> getEligibleStudents(Decimal minimumCGPA) {
        return [
            SELECT Id, Name, CGPA__c, Department__c
            FROM Student__c
            WHERE CGPA__c >= :minimumCGPA
            ORDER BY CGPA__c DESC
        ];
    }

    public static List<Student__c> getStudentsByDepartment(String department) {
        return [
            SELECT Id, Name, CGPA__c, Department__c
            FROM Student__c
            WHERE Department__c = :department
            ORDER BY Name
        ];
    }

    public static Application__c createApplication(Id studentId, Id jobId) {

        Application__c app = new Application__c();

        app.Student__c = studentId;
        app.Job__c = jobId;
        app.Application_Date__c = Date.today();
        app.status__c = 'Applied';

        insert app;

        return app;
    }
}
