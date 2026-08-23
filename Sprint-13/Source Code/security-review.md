# Apex Security Review

## Reviewed Classes

| Class | Sharing Intent |
|---|---|
| ApplicationController | with sharing |
| ApplicationService | with sharing |
| CandidateSyncQueueable | with sharing |
| EligibleJobsController | with sharing |
| ExternalPlacementSyncJob | with sharing |
| MyApplicationsController | with sharing |
| NotificationService | with sharing |
| PlacementService | with sharing |
| DeploymentCheck | with sharing |

## Security Decision

Application service classes use explicit `with sharing` where the
operation should respect Salesforce record-sharing rules.

No class was changed to `without sharing` without a business requirement
for elevated record access.

## Important Limitation

`with sharing` controls the record-sharing layer. It does not by itself
guarantee CRUD or Field-Level Security enforcement.

CRUD/FLS must be considered separately when designing secure Apex.

## Review Principle

For every service class, ask:

- Should sharing be respected?
- Is elevated access genuinely required?
- Are object permissions respected?
- Are field permissions respected?
- Can the client bypass the intended security?
