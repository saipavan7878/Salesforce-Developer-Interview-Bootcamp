# Day 10 – Component Communication, Forms, LDS and Reusable LWC Architecture

## Objective

Day 10 focused on designing multiple Lightning Web Components as one
coordinated application instead of treating each component as an isolated
screen.

The main implementation was extended around the Student Placement Portal.

---

## Component Architecture

A good LWC application is made from focused components with clear
responsibilities.

Our portal follows:

```text
StudentPortal
├── StudentProfile
├── EligibleJobs
│   ├── JobCard
│   └── EmptyState
└── MyApplications
