# Day 7 – Bulk Processing and Governor Limits

## Key Engineering Goal

Apex code must work safely whether Salesforce processes 1 record or
many records.

## Bulkification Pattern

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
