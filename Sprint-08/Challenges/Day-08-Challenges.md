# Day 8 – Challenges

## 1. Choosing the Right Execution Model

The first challenge was deciding whether business work should happen
synchronously or asynchronously.

The decision depended on whether the user needed the result immediately.

## 2. Queueable Chaining

Designing the Queueable chain required keeping responsibilities
separate:

ExternalPlacementSyncJob → PlacementNotificationJob

The important part was ensuring the chain remained controlled and did
not create recursive execution.

## 3. Testing Asynchronous Apex

Testing Queueable and Batch Apex required using Test.startTest() and
Test.stopTest() so the asynchronous execution could be tested.

## 4. Batch Testing

The Batch test initially failed because multiple executeBatch
invocations occurred inside the test context. The batch size was
adjusted so the test records were processed in a single scope.

## 5. Debugging SOQL Field Selection

The Batch implementation initially failed because Status__c was used
inside execute() without being included in the start() query.

Adding the required field to the SOQL query resolved the issue.

## 6. Scheduled Apex Testing

The Scheduled Apex test initially required correction before Salesforce
could detect and execute the test method successfully.

## 7. Async Job Observability

The Apex Jobs page initially contained no records. A real Batch job was
then submitted using anonymous Apex so its Completed status could be
observed.

## Final Challenge

The biggest challenge was understanding that asynchronous Apex is not
just about moving code to the background.

It requires thinking about:

- Failure
- Duplicate execution
- Ordering
- Monitoring
- Governor Limits
- Appropriate execution models
