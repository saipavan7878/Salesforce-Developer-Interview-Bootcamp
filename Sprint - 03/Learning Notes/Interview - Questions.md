# Interview Questions

## 1. What is the difference between Workflow, Process Builder, and Flow?

Workflow Rules and Process Builder are older declarative automation tools.
Flow is the more powerful and flexible automation platform used for
modern Salesforce automation.

## 2. Why is Flow replacing Workflow Rules?

Flow provides broader automation capabilities and can handle more
complex business processes than Workflow Rules.

## 3. What is a Record-Triggered Flow?

A Record-Triggered Flow automatically runs when a Salesforce record is
created, updated, or deleted according to its configured conditions.

## 4. What are Before-Save and After-Save Flows?

A Before-Save Flow is mainly used to update fields on the record being
saved.

An After-Save Flow is used for actions that occur after the record is
saved, such as creating related records or sending notifications.

## 5. When should Apex be preferred over Flow?

Apex should be preferred when the requirement involves complex business
logic, complex calculations, external integrations, or processing that
is difficult to implement effectively in Flow.

## 6. Can Flow call Apex?

Yes. Flow can call Apex through an Invocable Apex method.

## 7. What are the advantages of declarative automation?

Declarative automation reduces the amount of code required, is easier
to maintain, and allows standard business automation to be built without
custom Apex.

## 8. Explain one Flow that you built.

I built a Record-Triggered Flow on Application__c. When a new
Application is created, the Flow automatically handles the Application
Date and sends a confirmation email to the Placement Officer.

## 9. Explain one Validation Rule that you created.

I created a Validation Rule that prevents an application when the
Student's CGPA is below the Job's Minimum CGPA.

I also created a Validation Rule that prevents an application when the
Application Date is after the Job Closing Date.

## 10. If given the choice, why did you use Flow instead of Apex?

I used Flow when the requirement could be solved with simple
declarative automation. This avoids unnecessary Apex code and makes
the solution easier to maintain.
