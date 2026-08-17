# Day 3 – Validation Rules, Flows & Triggers

## Objective

The objective of Day 3 was to understand the differences between
Validation Rules, Flows and Apex Triggers and select the appropriate
automation tool for different business requirements.

The Placement Management System was enhanced using declarative
automation wherever possible.

---

## Business Scenario

The Placement Cell requires additional automation for the Placement
Management System.

The new requirements are:

1. Send an email to the Placement Officer whenever a student submits
   an application.
2. Automatically populate the Application Date whenever an application
   is created.
3. Prevent duplicate applications.
4. Reject applications when the student's CGPA is below the job's
   minimum requirement.
5. Automatically create an Offer Letter when an application Status
   changes to Selected.

---

## Automation Design

| Requirement | Solution | Reason |
|---|---|---|
| Reject duplicate applications | Apex / automation with record lookup | Duplicate checking requires comparing the new application with existing records. |
| Auto-fill Application Date | Flow | Simple field automation can be handled declaratively. |
| Send Email | Flow | Flow provides standard email automation. |
| Reject low CGPA | Validation Rule | This is a data-quality/business rule that should prevent the record from being saved. |
| Create Offer Letter record | Flow | Flow can create related records when a business event occurs. |

---

## Record-Triggered Flow

A Record-Triggered Flow was designed for `Application__c`.

### Flow Responsibilities

- Automatically populate Application Date.
- Send a confirmation email to the Placement Officer.
- Complete the application automation after creation.

The Flow is triggered when a new Application record is created.

---

## Offer Letter Automation

A second Record-Triggered Flow was created for `Application__c`.

### Business Rule

When an application's Status changes to `Selected`, an Offer Letter
record is automatically created.

### Offer Letter Fields Populated

- Application
- Student
- Job
- Offer Date
- Offer Letter Name

The automation was tested successfully by changing an Application
status from `Applied` to `Selected` and verifying that an
`Offer_Letter__c` record was created.

---

## Validation Rules

The following business rules are enforced:

### 1. Minimum CGPA

The student's CGPA must be greater than or equal to the Job's
Minimum CGPA.

Formula:

```text
Student__r.CGPA__c < Job__r.Minimum_CGPA__c
