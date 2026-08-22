# Day 6 – Apex Triggers and Event-Driven Automation

## Objective

The objective of Day 6 was to understand how Salesforce applications
respond automatically to important business events using Apex Triggers.

The focus was on designing Trigger architecture that is clean,
maintainable, reusable and separated from business logic.

---

## Engineering Principle

> A Trigger should observe, not decide.

The Trigger identifies what happened and delegates the business work to
appropriate Service classes.

The Service classes contain the actual business logic.

---

## Event-Driven Automation

Enterprise software should respond automatically when important business
events occur.

Examples include:

- A new Application is created.
- An Application becomes Selected.
- An Application is Rejected.
- An Interview is Scheduled.
- An Offer is Accepted.

The general architecture is:

```text
Business Event
      ↓
Trigger
      ↓
Trigger Handler
      ↓
Service Class
      ↓
Business Action
