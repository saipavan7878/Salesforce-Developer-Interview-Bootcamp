# Day 9 Reflection

Day 9 was the point where the Placement Management System moved from
backend logic to a user-facing experience.

I learned that an LWC should not be created simply because the
technology is being taught. It should exist because a user needs to
accomplish a specific task. The Eligible Jobs component gave this idea
a practical meaning.

Building the component incrementally was especially useful. I first
made the component render, then added a hard-coded job, moved the values
into JavaScript, displayed multiple jobs, connected real Salesforce
data, and finally connected the component to the eligibility logic.

One of the most important lessons was keeping business rules outside
the UI. The LWC handles presentation and user interaction, while the
Apex controller and service layer handle the server-side capability and
eligibility rules.

I also learned how the component receives the current Student record
Id and uses it to retrieve the appropriate eligible jobs.

The View Details interaction helped me understand how user events turn a
static component into an interactive application.

Another important lesson was that a successful screen is not enough.
The component also needs to consider loading, empty and error states.
This changed the way I think about UI development because users will
eventually experience situations where data is unavailable or something
fails.

The main lesson I take from Day 9 is:

> A good UI hides technical complexity while making the business
> capability obvious to the user.

The backend architecture developed in earlier sprints now connects
directly to the user's experience through LWC.
