# Sprint 11 – Salesforce APIs, REST Integration and External Systems

## Overview

Sprint 11 extends the Placement Management System beyond the Salesforce
platform by introducing an external recruitment integration.

The goal is to allow a selected student candidate to be synchronized with
an external recruitment platform while keeping Salesforce business
transactions independent from external-system availability.

---

## Business Problem

The Placement Management System already supports:

- Student profiles
- Eligible jobs
- Applications
- Application status
- Selection processing

The next requirement is to send selected candidates to an external
company recruitment platform.

The integration must therefore connect:

```text
Salesforce
    ↕
External Recruitment System
