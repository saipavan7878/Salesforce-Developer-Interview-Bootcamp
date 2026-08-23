public class PlacementAsyncService {

    @future
    public static void updateStudent(Id studentId) {

        Student__c student = [
            SELECT Id, CGPA__c
            FROM Student__c
            WHERE Id = :studentId
            LIMIT 1
        ];

        student.CGPA__c = student.CGPA__c + 0.01;

        update student;
    }
}