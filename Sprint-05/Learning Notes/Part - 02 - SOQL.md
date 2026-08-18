# Part 2 – SOQL

## Engineering Principle

Software cannot make good decisions without first finding the right
information.

SOQL is the way Salesforce applications ask Salesforce for the
information they need before making business decisions.

---

## What is SOQL?

SOQL stands for Salesforce Object Query Language.

It is used to retrieve information from Salesforce records.

SOQL is not about memorising syntax. It is about asking precise
business questions.

A useful question to ask before writing a query is:

"I am writing this query because I need to know..."

---

## Business Question 1

### Has this student already applied for the selected company?

The relevant Salesforce object is:

`Application__c`

The required information includes:

- Student
- Job
- Application Status
- Application Date

Example query:

```apex
SELECT Id, Name, Student__c, Job__c, Status__c, Application_Date__c
FROM Application__c
WHERE Student__c = :studentId
AND Job__c = :jobId
