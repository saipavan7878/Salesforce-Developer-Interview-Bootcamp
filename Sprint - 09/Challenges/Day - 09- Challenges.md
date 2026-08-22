# Day 9 – Challenges

## 1. Understanding LWC Structure

The first challenge was understanding the separate responsibilities of
HTML, JavaScript and metadata instead of treating the component as one
file.

## 2. Building Incrementally

The Eligible Jobs component was built step by step:

- Initial component
- Hard-coded job card
- JavaScript data binding
- Multiple jobs
- Real Salesforce data
- Eligibility logic
- View Details interaction

This helped isolate problems instead of implementing everything at once.

## 3. Connecting LWC to Apex

The component initially used local data. Connecting it to Salesforce
required an Apex controller and a wire-based data retrieval approach.

## 4. Keeping Business Logic Outside the UI

Eligibility rules were kept in the service layer instead of duplicating
them inside JavaScript.

This keeps the logic reusable for other entry points.

## 5. Using the Student Record Id

The component needed the current Student record Id to determine which
jobs the student is eligible for.

The LWC receives the record Id and passes it to the Apex controller.

## 6. Handling User Interaction

The View Details button required an event handler that identifies the
selected Job and displays its details.

## 7. Handling Non-Happy Paths

The component was tested for:

- Successful data retrieval
- No eligible jobs
- Apex/data retrieval errors
- Loading behavior

## Final Challenge

The biggest lesson was that building a UI is not only about displaying
data.

A professional component must also consider:

- What the user can accomplish
- Where the data comes from
- Where business rules belong
- What happens while loading
- What happens when there is no data
- What happens when something fails
