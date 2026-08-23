# Sprint 13 – Salesforce Security, Access Control and Secure Apex

## Overview

Sprint 13 focused on securing the Placement Management System using
Salesforce's layered security architecture.

The sprint covered:

- Profiles
- Permission Sets
- Roles
- Object-level security
- Field-Level Security
- Organization-Wide Defaults
- Record sharing
- Apex sharing behaviour
- CRUD and FLS
- Least privilege
- Integration security
- Security testing

---

## Security Architecture

The application follows a layered model:

```text
User
 ↓
Authentication
 ↓
Profile / Permission Set
 ↓
Object Permissions
 ↓
Field-Level Security
 ↓
OWD / Role Hierarchy / Sharing
 ↓
Apex Sharing
 ↓
Server-Side Validation
 ↓
Effective Access
