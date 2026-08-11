# SOQL Queries

## 1. Retrieve all students

```sql
SELECT Id, Name
FROM Student__c

-- Get student name, department and CGPA
SELECT Name, Department__c, CGPA__c
FROM Student__c
-- Find students who have CGPA >= 8
SELECT Name, Department__c, CGPA__c
FROM Student__c
WHERE CGPA__c >= 8

-- Find CSE students with CGPA >= 8
SELECT Name, Department__c, CGPA__c
FROM Student__c
WHERE Department__c = 'CSE'
AND CGPA__c >= 8

-- Display the 5 students with the highest CGPA
SELECT Name, Department__c, CGPA__c
FROM Student__c
ORDER BY CGPA__c DESC
LIMIT 5

-- Get applications whose status is Selected
SELECT Id, Name, Student__c, Job__c, status__c
FROM Application__c
WHERE status__c = 'Selected'

-- Get application details along with related Student and Job names
SELECT Name,
       Student__r.Name,
       Job__r.Name,
       status__c,
       Application_Date__c
FROM Application__c

-- Count the number of applications for each Job
SELECT Job__c, COUNT(Id)
FROM Application__c
GROUP BY Job__c
