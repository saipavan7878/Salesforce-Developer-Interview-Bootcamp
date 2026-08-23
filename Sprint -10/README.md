# Day 10 – Component Communication, Forms, LDS and Reusable LWC Architecture

## Overview

Day 10 extended the Student Placement Portal from a collection of
individual Lightning Web Components into a coordinated application.

The sprint focused on:

- Parent-child communication
- Custom events
- Lightning base components
- Lightning Data Service
- Reactive data and refresh
- Reusable components
- Application submission
- Duplicate application handling
- My Applications refresh
- Final end-to-end integration

---

## Architecture

The final Student Portal structure is:

```text
StudentPortal
├── StudentProfile
├── EligibleJobs
│   ├── JobCard
│   └── EmptyState
└── MyApplications
