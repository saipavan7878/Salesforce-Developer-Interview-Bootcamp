# Day 9 – Lightning Web Components

## Objective

Day 9 focused on bringing the Placement Management System to the user
through Lightning Web Components.

The main goal was to build a small, reusable user interface that allows
students to view jobs for which they are eligible.

---

## Lightning Web Components

LWC is used to build interactive Salesforce user experiences.

A component should represent a clear user capability rather than simply
being a collection of HTML and JavaScript files.

The Eligible Jobs component represents the capability:

> A student can view suitable placement opportunities.

---

## Basic LWC Structure

The component contains three main files:

```text
eligibleJobs/
├── eligibleJobs.html
├── eligibleJobs.js
└── eligibleJobs.js-meta.xml
