# Day 8 – Asynchronous Apex

## Objective

Day 8 focused on understanding when Salesforce work should happen
immediately and when it should happen in the background.

The practical work covered:

- Queueable Apex
- Queueable chaining
- Batch Apex
- Scheduled Apex
- Async job monitoring
- Bulk-safe asynchronous processing

---

## Synchronous vs Asynchronous Processing

Synchronous processing keeps the user waiting until the work finishes.

Asynchronous processing allows essential work to complete first while
secondary work continues later.

The key engineering question is:

> Does the user need the result of this work right now?

If yes, synchronous processing may be appropriate.

If no, asynchronous processing may be appropriate.

---

## Queueable Apex

Queueable Apex was used for structured background processing.

The implementation created:

```text
OfferPostProcessingJob
