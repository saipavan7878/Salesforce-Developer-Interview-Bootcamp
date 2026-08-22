# Day 7 – Bulk Processing and Governor Limits

## Objective

The objective of Day 7 was to design Apex that works safely with
multiple records and remains within Salesforce Governor Limits.

The Placement Management System was tested and enhanced using
bulk-safe SOQL, Sets, Maps and bulk DML.

---

## Engineering Principle

> Code that works for one record is a demonstration.
> Code that works safely for thousands is engineering.

The main goal was to move from thinking about individual records to
thinking about collections of records.

---

## Governor Limits

Salesforce is a multi-tenant platform and therefore places limits on
resources consumed by a transaction.

Important limits discussed during Day 7 include:

- SOQL Queries
- Records Retrieved by SOQL
- DML Statements
- Records Processed by DML
- CPU Time
- Heap Size

The most important lesson was to understand how inefficient code can
reach these limits.

---

## Bulkification

Bulkification means designing Apex so that the same logic works
correctly whether Salesforce processes one record or many records.

The bulk-processing pattern used was:

```text
Receive all records
        ↓
Collect required IDs
        ↓
Query related records once
        ↓
Store results in Maps
        ↓
Process records in memory
        ↓
Collect records to update
        ↓
Perform DML outside loops
