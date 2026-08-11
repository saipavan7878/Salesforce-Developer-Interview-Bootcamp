# Day 1 – Placement Management System

## Objective

The objective of Day 1 was to develop Salesforce Developer thinking by
converting a business requirement into a working Salesforce solution.

The business requirement was to design a Placement Management System
for a college using Salesforce.

---

## Business Scenario

Our college wants to build a Placement Management System in Salesforce.

Companies publish job openings with eligibility criteria. Students can
apply for jobs, and the placement team tracks every application.

The system was designed using Salesforce Custom Objects, Relationships,
SOQL, Apex and an Apex Trigger.

---

# Task 1 – Data Model

## Objects Created

The following custom objects were created:

- Student__c
- Job__c
- Application__c

### Student__c

Stores information about students.

Important fields:

- Name
- Department
- CGPA

### Job__c

Stores information about company job openings.

Important fields:

- Company
- Role
- Minimum CGPA

### Application__c

Stores applications submitted by students for jobs.

Important fields:

- Student
- Job
- Status

---

## Why is Application__c Required?

Application__c is required to track the relationship between students
and jobs.

A student can apply for multiple jobs, and a job can receive
applications from multiple students.

Therefore, Application__c acts as the junction object between
Student__c and Job__c.

It also allows the placement team to track the status of each
application, such as Applied, Shortlisted, Selected or Rejected.

---

# Task 2 – SOQL Practice

The following SOQL queries were practiced:

1. Retrieve all students.
2. Retrieve Name, Department and CGPA.
3. Retrieve students with CGPA >= 8.
4. Retrieve CSE students with CGPA >= 8.
5. Retrieve the top 5 students by CGPA.
6. Retrieve selected applications.
7. Retrieve applications with Student and Job details.
8. Count applications for each job.

The queries demonstrate filtering, sorting, limiting records,
relationship queries, aggregation and grouping.

---

# Task 3 – Apex Class

## PlacementService.cls

An Apex class named `PlacementService` was created.

The class contains the following methods:

### getEligibleStudents(minimumCGPA)

Retrieves students whose CGPA is greater than or equal to the
specified minimum CGPA.

### getStudentsByDepartment(department)

Retrieves students belonging to the specified department.

### createApplication(studentId, jobId)

Creates an application for a selected student and job.

---

# Task 4 – Trigger Challenge

## ApplicationTrigger.trigger

A `before insert` trigger was created on `Application__c`.

### Business Rule

A student should not be allowed to apply for a job if the student's
CGPA is below the minimum CGPA required by that job.

### Validation Flow

Student CGPA
    ↓
Compare with Job Minimum CGPA
    ↓
If CGPA is below requirement
    ↓
Application is prevented

If the student satisfies the eligibility criteria, the application
can be created.

---

# Technologies Used

- Salesforce
- Custom Objects
- Custom Fields
- Lookup Relationships
- SOQL
- Apex
- Apex Triggers
- Git
- GitHub

---

