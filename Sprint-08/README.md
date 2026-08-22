# Day 8 – Asynchronous Apex

## Overview

Day 8 focused on designing Salesforce applications that can decide when
work should happen.

The main asynchronous mechanisms covered were:

- Future Methods
- Queueable Apex
- Queueable Chaining
- Batch Apex
- Scheduled Apex

The key engineering question was:

> Should this work happen now, later, in batches, or at a scheduled time?

---

## Objectives

During Day 8, I implemented and tested:

- Queueable Apex for background processing
- Queueable chaining
- Batch Apex for large-volume processing
- Scheduled Apex
- Async job monitoring
- Bulk-safe asynchronous processing

---

## Queueable Apex

Implemented:

```text
OfferPostProcessingJob
