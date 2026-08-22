# Day 7 – Challenges

## 1. Understanding Bulkification

The main challenge was changing from thinking about one record to
thinking about a collection of records.

## 2. Avoiding SOQL Inside Loops

The solution required collecting Student and Job IDs first and querying
the related records once.

## 3. Avoiding DML Inside Loops

Records that needed changes were collected into Lists and updated with a
single DML operation outside the processing loop.

## 4. Testing at Scale

The bulk validation logic was tested with 1, 50 and 200 records.

## 5. Detecting Real Status Changes

The Selection processing compared the old and new Application Status
using Trigger.oldMap and the new records.
