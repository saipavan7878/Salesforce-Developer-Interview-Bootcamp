trigger BadStudentTrigger on Student__c (before insert) {

    Set<String> studentNames = new Set<String>();

    for (Student__c student : Trigger.new) {
        if (student.Name != null) {
            studentNames.add(student.Name);
        }
    }

    Map<String, Student__c> existingStudents = new Map<String, Student__c>();

    for (Student__c student : [
        SELECT Id, Name
        FROM Student__c
        WHERE Name IN :studentNames
    ]) {
        existingStudents.put(student.Name, student);
    }

    for (Student__c student : Trigger.new) {
        if (existingStudents.containsKey(student.Name)) {
            student.Name = student.Name + ' - Duplicate';
        }
    }
}