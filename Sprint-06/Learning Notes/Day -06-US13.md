# US-13 – Responding to a New Application

## Business Requirement

Whenever a student submits a new Application, the software should
automatically verify that the required business rules are satisfied
before the record is saved.

## Current Architecture

```text
ApplicationTrigger
        ↓
ApplicationTriggerHandler
        ↓
Validation Logic
