# Day 5 – SOQL, DML and Business Transactions

## Engineering Principle

Software cannot make good decisions without first finding the right
information.

The first responsibility of enterprise software is to retrieve the
required information. After retrieving the information, the software can
make business decisions.

The basic process is:

Business Question
↓
Information Required
↓
SOQL Query
↓
Retrieved Information
↓
Business Decision
↓
DML Operation

---

# Part 1 – Information Requirements

Before writing a SOQL query, first identify the information required by
the business problem.

For example, when a student wants to apply for a job, the software may
need information such as:

- Student CGPA
- Student Department
- Active Backlogs
- Graduation Year
- Job Eligibility
- Application Deadline
- Existing Applications
- Number of Current Offers

The important question is:

> What information do I need before making this decision?

Professional developers identify the information requirement before
writing the query.

---

# Part 2 – SOQL

## What is SOQL?

SOQL stands for Salesforce Object Query Language.

SOQL is used to retrieve information from Salesforce records.

SOQL should be viewed as a way of asking Salesforce precise business
questions rather than simply memorizing syntax.

Before writing a query, ask:

> "I am writing this query because I need to know..."

Every query should answer a clear business question.

---

## Business Question 1 – Has This Student Already Applied?

### Business Question

Has this student already applied for the selected company?

### Relevant Object

`Application__c`

### Required Information

- Student
- Job
- Application Status
- Application Date

### Example Query

```apex
SELECT Id, Name, Student__c, Job__c, Status__c, Application_Date__c
FROM Application__c
WHERE Student__c = :studentId
AND Job__c = :jobId
