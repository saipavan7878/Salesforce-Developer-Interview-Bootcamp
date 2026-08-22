# Day 8 Reflection

Today I learned that asynchronous Apex is not simply about making code
run in the background. It is about choosing the correct execution model
for the business workload.

The Queueable Apex implementation helped me understand how secondary
work can be separated from the main transaction. I also learned how
Queueable jobs can be chained when two background activities need to
happen in a controlled sequence.

The Batch Apex implementation showed me how large datasets can be
processed in manageable scopes using start, execute, and finish methods.
I also understood that the bulkification principles from the previous
sprint are still important when working with asynchronous Apex.

The Scheduled Apex implementation helped me understand the difference
between deciding when a process should start and deciding how many
records should be processed.

One of the most useful lessons was debugging asynchronous code. I
encountered issues involving Queueable chaining, SOQL field selection,
Batch test scope size, and scheduled test execution. Solving these
problems improved my understanding of how Salesforce actually executes
background jobs.

I also learned that asynchronous processing introduces additional
concerns such as failures, retries, duplicate execution, ordering, and
monitoring.

The main lesson I take from Day 8 is:

> Professional developers do not only ask how code should execute.
> They also ask when it should execute and what should happen if it
> fails.

This changed the way I think about Apex architecture. Instead of
choosing Queueable, Batch, or Scheduled Apex simply because the feature
exists, I should first understand the business workload and then choose
the execution model that fits it.
