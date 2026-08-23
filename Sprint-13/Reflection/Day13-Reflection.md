
# Day 13 Reflection

Sprint 13 changed the way I think about Salesforce security.

Before this sprint, I mainly associated security with Profiles and
Permission Sets. I now understand that Salesforce security is a layered
architecture.

The most important distinction I learned was between object, field and
record access.

A user may have permission to access an object but still be unable to
access a particular record. Likewise, a user may have access to the
record while sensitive fields remain hidden.

The OWD changes made this concept practical.

The Placement Management System originally had broad record visibility
for several placement objects. The security baseline was redesigned to
start more restrictively:

```text
Application      → Private
Student          → Private
Offer Letter     → Private
Job              → Public Read Only
Department       → Public Read Only
Student Course   → Controlled by Parent
