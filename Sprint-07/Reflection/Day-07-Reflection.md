# Day 7 Reflection

Today I learned why Apex code must be designed for bulk processing from
the beginning.

I tested the Application automation with 1, 50 and 200 records and
learned how Sets and Maps help reduce unnecessary database operations.

I also implemented bulk-safe DML by collecting records and performing
the update outside the loop.

The Selected Application processing helped me understand how
Trigger.oldMap and current values can be used to detect real business
changes and process many records efficiently.

The main lesson I learned today is to always ask whether code will still
work safely when Salesforce processes many records at once.
