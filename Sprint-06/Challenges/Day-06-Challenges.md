# Day 6 – Challenges

## 1. Keeping Triggers Small

A common challenge was understanding that a Trigger should not contain
all the business logic.

### Learning

The Trigger should observe the event and delegate the business work to
Service classes.

## 2. Separating Responsibilities

Validation, statistics and notifications should not all be implemented
inside one Trigger.

### Learning

Specialized Service classes make the system easier to understand,
maintain and extend.

## 3. Before vs After Events

It was necessary to understand when business logic should execute before
or after a record is saved.

### Learning

Validation normally belongs before save, while notifications and
post-save statistics belong after save.

## 4. Multiple Business Processes

One business event can require several independent actions.

### Learning

A single Trigger can delegate to multiple specialized Services instead
of becoming large and difficult to maintain.
