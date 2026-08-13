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

A Record-Triggered Flow was designed for Application__c.

### Flow Responsibilities

- Automatically populate Application Date.
- Send a confirmation email to the Placement Officer.
- Complete the application automation after creation.

The Flow is triggered when a new Application record is created.

---

## Validation Rules

The following business rules are enforced:

### 1. Minimum CGPA

The student's CGPA must be greater than or equal to the Job's
Minimum CGPA.

### 2. Closing Date

The Application Date cannot be after the Job Closing Date.

### 3. Mandatory Fields

Required Application fields cannot be left blank.

The formulas used for these Validation Rules are documented separately
with the Day 3 implementation.

---

## Flow vs Trigger

### Update a field automatically

Flow is preferred because simple field updates can be performed
declaratively.

### Create a related record

Flow is preferred because it can create related records without
requiring Apex.

### Send an email notification

Flow is preferred because email actions are available declaratively.

### Call an external REST API

Apex is preferred because HTTP callouts require programmatic
integration logic.

### Complex calculations involving multiple objects

Apex may be preferred when the calculations require complex logic that
is difficult to maintain in Flow.

### Process 10,000 imported records

The solution should be designed with scale and governor limits in mind.
For complex high-volume processing, Apex and appropriate asynchronous
processing may be required.

---

## Debugging Challenge

If a Trigger, Flow and Workflow all update the same field, several
automation paths may execute during one transaction.

This can cause:

- Conflicting field values
- Repeated execution
- Difficult debugging
- Unnecessary processing

### Better Design

Each automation requirement should have a clear owner.

- Validation Rules → Data validation
- Flow → Declarative business automation
- Apex → Complex logic and integrations

Avoid having multiple automation tools update the same field without a
clear reason.

---

## Technologies Used

- Salesforce
- Record-Triggered Flow
- Validation Rules
- Apex Triggers
- Apex
- SOQL
- Git
- GitHub

---

## Learning Outcomes

By completing Day 3, I learned:

- The difference between Validation Rules, Flows and Apex Triggers.
- How to select the appropriate automation tool for a requirement.
- How Record-Triggered Flows work.
- How Validation Rules enforce data quality.
- When declarative automation is preferable to Apex.
- How multiple automation mechanisms can conflict.

---

## Evidence

The `Screenshots/` folder contains the evidence requested by the
assignment:

- Flow Canvas
- Start Element
- Assignment Element
- Email Action
- Successful execution
