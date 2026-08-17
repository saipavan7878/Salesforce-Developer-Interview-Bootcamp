# Part 8 – Debugging Challenge

## 1. What problem might occur?

If a Trigger, Flow, and Workflow all update the same Status field,
they may conflict with each other. This can make the final Status
unexpected and make the automation difficult to debug.

## 2. Could automation repeatedly execute?

Yes. If one automation changes a field and that change causes another
automation to run again, the same record can pass through multiple
automation paths repeatedly.

## 3. How would you redesign this solution?

Use a single clear owner for each type of automation.

- Validation Rules → validate data
- Flow → declarative business automation
- Apex → complex logic or integrations

Avoid having Trigger, Flow, and Workflow all modify the same Status field.
