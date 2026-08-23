# Day 14 – Challenges

## 1. Bringing the Application Together

The main challenge was reviewing the Placement Management System as one
complete application rather than as separate Salesforce features.

The final review required considering:

- Data model
- Flow and automation
- Apex
- Triggers
- LWC
- Async Apex
- Integration
- Security
- Testing
- Git and deployment

---

## 2. Architecture Review

The application contains multiple layers:

```text
User
 ↓
Lightning UI
 ↓
Apex Services
 ↓
SOQL / DML
 ↓
Salesforce Data
 ↓
Async Processing / External Integration
