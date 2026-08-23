# Day 11 Reflection

Day 11 was an important change in how I think about Salesforce
applications.

Until now, most of the Placement Management System existed inside
Salesforce. In this sprint, I learned that a real enterprise application
may need to communicate with systems that Salesforce does not control.

The biggest lesson was understanding an API as a contract rather than
simply an HTTP request. The external recruitment system and Salesforce
must agree on endpoints, methods, request data, responses, authentication,
and error handling.

I also learned why REST methods communicate different intentions. In our
project, `POST /candidates` represents sending a selected candidate to the
external recruitment platform.

Working with Named Credentials was another important lesson. I understood
why credentials should never be hard-coded into Apex. Configuration and
authentication should remain separate from business logic.

The most valuable technical lesson came from the callout error:

```text
You have uncommitted work pending.
Please commit or rollback before calling out.
