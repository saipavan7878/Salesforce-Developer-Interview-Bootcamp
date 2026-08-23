# Day 13 – Challenges

## 1. Understanding Salesforce Security Layers

The first challenge was understanding that Salesforce security is not
controlled by a single setting.

Access must be considered at multiple levels:

```text
User
 ↓
Object Access
 ↓
Field-Level Security
 ↓
Record Sharing
 ↓
Apex Security
 ↓
Effective Access
