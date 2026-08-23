# Day 11 – Salesforce APIs, REST Integration and External Systems

## Objective

Day 11 focused on connecting the Placement Management System with an
external recruitment platform.

The main lesson was that a Salesforce application does not exist in
isolation. It must understand what belongs inside Salesforce, what belongs
outside Salesforce, and how the two systems communicate safely.

---

## APIs as Contracts

An API is a contract between two software systems.

The systems do not need to know each other's internal implementation.
They only need to agree on:

- How requests are sent
- What data is exchanged
- How systems identify themselves
- What responses mean
- How failures are represented

The integration follows:

```text
Salesforce
    ↓ Request
External API
    ↓ Response
Salesforce
