# Day 10 Reflection

Day 10 changed the way I think about Lightning Web Components.

Earlier, I was mainly focused on making one component display information
and respond to user actions. Today I learned that a real application
requires multiple components to cooperate through clear communication
contracts.

The parent-child communication pattern was one of the most important
lessons. A parent can provide information to a child through public
properties, while a child should report actions through custom events
instead of directly changing parent state.

The JobCard implementation made this practical. The child reports View
Details and Apply actions, while the parent decides what should happen
next.

The Student Profile form also helped me understand the importance of
using Salesforce platform capabilities where they already solve the
problem. Using Lightning record-edit components reduced unnecessary
custom server-side code.

Another important lesson was the difference between client-side and
server-side validation. Browser validation makes the interface easier
to use, but business rules must remain authoritative on the server.

Reactive data and refresh behaviour were also important. A change to a
student's CGPA can affect eligible jobs, so simply saving the record is
not enough. Dependent components must be refreshed appropriately.

I also learned that reusable components should have a meaningful
purpose. JobCard, StatusBadge and EmptyState each provide a capability
that can be reused rather than duplicating the same UI logic in multiple
places.

The Apply workflow connected everything together:

```text
User Action
    ↓
Component Event
    ↓
Parent Coordination
    ↓
Apex Controller
    ↓
Service Layer
    ↓
Database
    ↓
UI Refresh
