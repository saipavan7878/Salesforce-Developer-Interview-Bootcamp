# Day 10 – Challenges

## 1. Parent–Child Communication

The first challenge was understanding how separate LWC components should
communicate without directly modifying each other's state.

The final pattern was:

```text
Parent → Child
       @api

Child → Parent
       Custom Event
