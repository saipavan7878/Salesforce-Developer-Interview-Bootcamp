# Day 2 – Collections, Bulkification and Asynchronous Apex

## Objective

Day 2 focused on understanding Apex Collections, Salesforce Governor Limits,
Bulkification, Asynchronous Apex and Lightning Web Component communication.

## Topics Covered

- List
- Set
- Map
- Governor Limits
- Bulkification
- @future
- Queueable vs Future vs Batch
- LWC Parent-to-Child Communication
- LWC Child-to-Parent Communication

## Apex Collections

Implemented and tested:
- List<String>
- Set<Id>
- Map<Id, Student__c>

## Governor Limits and Bulkification

Created a deliberately inefficient trigger containing SOQL inside a loop.

A bulk insertion of 200 records produced:

`Too many SOQL queries: 101`

The trigger was then redesigned using Sets, Maps and a single SOQL query.

The bulkified version successfully processed 200 records.

## Asynchronous Apex

Created `PlacementAsyncService.cls` containing an `@future` method.

The method:
- Accepts a Student Id
- Queries the Student
- Updates the student's CGPA
- Runs asynchronously
- Can be verified through Apex Jobs

## LWC

The final block will contain:
- Parent-to-child communication using @api
- Child-to-parent communication using custom events

## Repository Structure

- `Apex/` – Apex source code
- `LWC/` – Lightning Web Components
- `Screenshots/` – Evidence and outputs
- `Learning-Notes.md` – Concepts learned
- `Challenges.md` – Problems and solutions
- `Reflection.md` – Day 2 reflection
