# Day 6 Reflection

Today I learned how Apex Triggers allow Salesforce applications to
respond automatically to important business events.

I learned that a Trigger should observe an event and delegate the
business work to appropriate Service classes instead of containing all
the business logic itself.

I implemented Trigger-based processing for Application events and
separated responsibilities into PlacementService, StatisticsService,
and NotificationService.

I also learned the importance of Before and After timing and how clean
Trigger architecture makes future business enhancements easier to
implement and maintain.

The main lesson I learned today is that a Trigger is the beginning of a
business process, not the entire business process.
