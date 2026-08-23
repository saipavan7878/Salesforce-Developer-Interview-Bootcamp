# Day 12 – Git, Salesforce CLI, Metadata, Sandboxes and Deployment

## Objective

Day 12 focused on moving the Placement Management System from a
developer-only project toward a professional, source-controlled,
repeatable deployment workflow.

The main topics were:

- Git
- Branches
- Commits
- Pull Requests
- Salesforce metadata
- Salesforce CLI
- Org authentication
- Metadata retrieval
- Metadata deployment
- Sandboxes
- Scratch Orgs
- Changesets
- Metadata API
- Deployment dependencies
- Testing before deployment
- Deployment verification

---

## Why Git Matters

A Salesforce org is an environment, not the only copy of the application.

The repository provides:

- Source history
- Collaboration
- Change tracking
- Reproducibility
- Reviewability
- Recovery

The engineering model is:

```text
Git Repository
    ↓
Source of Development
    ↓
Deployment
    ↓
Salesforce Org
