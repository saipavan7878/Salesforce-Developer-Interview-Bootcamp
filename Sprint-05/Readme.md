# Day 5 – Retrieving and Managing Information with SOQL and DML

## Objective

The objective of Day 5 was to understand how Salesforce applications
retrieve information using SOQL and modify Salesforce records using DML.

The Placement Management System was extended to retrieve Student, Job
and Application information before making business decisions.

---

## Key Engineering Principle

Software cannot make good decisions without first finding the right
information.

The development process followed:

Business Question
↓
Information Required
↓
SOQL Query
↓
Retrieved Data
↓
Business Decision
↓
DML Operation

---

## SOQL

SOQL was used to retrieve information from Salesforce objects.

### Business Questions Practiced

1. Has this student already applied for the selected company?
2. Which companies are currently accepting applications?
3. How many students have already been selected by Amazon?
4. Which students satisfy Microsoft's eligibility criteria?

The queries demonstrated:

- Filtering with WHERE
- Sorting with ORDER BY
- LIMIT
- Relationship queries
- Aggregate queries using COUNT()
- Retrieving related Salesforce data

---

## DML

DML was used to modify Salesforce data.

The following operations were practiced:

- INSERT
- UPDATE
- DELETE

### Create

Created an Application record using DML.

### Update

Updated an existing Application record.

### Delete

Deleted a test Application record.

---

## ApplicationService

Created `ApplicationService.cls` to implement a complete business
transaction.

The process is:

Retrieve Student
↓
Retrieve Job
↓
Validate Eligibility
↓
Check Duplicate Application
↓
Create Application
↓
Save Application
↓
Return Confirmation

The class uses SOQL to retrieve required information and DML to create
the Application record.

---

## Business Rules

The service checks:

- Student eligibility based on CGPA.
- Job closing date.
- Existing duplicate applications.

Only after the business rules are satisfied is the Application record
created.

---

## Technologies Used

- Salesforce
- Apex
- SOQL
- DML
- Custom Objects
- Git
- GitHub

---

## Learning Outcomes

By completing Day 5, I learned:

- Why software must retrieve information before making decisions.
- How to write SOQL based on business questions.
- How relationship and aggregate queries work.
- How DML creates, updates and deletes Salesforce records.
- How to combine SOQL and DML in an Apex business transaction.
- How to write reusable data-access and business logic in Apex.

---

## Source Code

The `Source Code/` folder contains:

```text
ApplicationService.cls
