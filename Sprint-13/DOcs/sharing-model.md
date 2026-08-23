# Sharing Model

## Organization-Wide Defaults

| Object | Internal Access |
|---|---|
| Application | Private |
| Student | Private |
| Offer Letter | Private |
| Job | Public Read Only |
| Department | Public Read Only |
| Student Course | Controlled by Parent |

## Principle

Start with a restrictive baseline and grant additional record access only
when business requirements justify it.

## Record Access Model

```text
Private Baseline
 ↓
Role Hierarchy
 ↓
Sharing Rules
 ↓
Manual / Programmatic Sharing where required
