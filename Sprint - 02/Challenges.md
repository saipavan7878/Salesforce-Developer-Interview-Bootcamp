# Day 2 Challenges

## 1. Governor Limit

The bad trigger performed SOQL inside a loop and failed when 200 records were inserted.

Error:
Too many SOQL queries: 101

### Solution
Moved the SOQL query outside the loop and used a Set and Map to process records in bulk.

## 2. Bulk Testing

Testing a trigger with one record did not demonstrate the problem.

### Solution
Inserted 200 records together to reproduce the governor-limit error.

## 3. Future Method Field

The first version of the @future class referenced a field that was not available under the expected API name.

### Solution
Checked the actual Student field API name and changed the implementation to use CGPA__c.
