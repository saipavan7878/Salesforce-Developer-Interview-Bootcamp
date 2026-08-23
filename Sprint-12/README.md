# Sprint 12 – Git, Salesforce CLI and Deployment

## Overview

Sprint 12 focused on moving the Placement Management System from a
developer-org project toward a professional, source-controlled and
reproducible development workflow.

The sprint covered:

- Git and GitHub
- Branching and commits
- Pull Requests and code review
- Salesforce metadata
- Salesforce CLI
- Org verification
- Metadata retrieval
- Metadata deployment
- Apex testing
- Deployment documentation
- Reproducibility

---

## Business Goal

The Placement Management System has grown into a multi-component
Salesforce application containing:

- Custom objects
- Custom fields
- Apex
- Lightning Web Components
- Triggers
- Queueable processing
- REST integration
- Named Credentials
- Tests

At this stage, the application must be managed like a real software
project rather than existing only inside one Salesforce org.

---

## Development Model

The project follows:

```text
Git Repository
    ↓
Feature Branch
    ↓
Pull Request
    ↓
Code Review
    ↓
Merge
    ↓
Salesforce CLI
    ↓
Target Salesforce Org
