import { LightningElement } from 'lwc';

export default class PlacementHome extends LightningElement {
    studentName = 'Rahul';
    rollNumber = '22B81A0501';
    department = 'CSE';

    message = '';
    status = 'Not Applied';

    todayDate = '18/08/2026';
    welcomeStudent = 'Welcome Student';
    numberOfCompanies = 25;
    numberOfJobs = 63;
    applicationsSubmitted = 5;

    showMessage() {
        this.message = 'Welcome to Salesforce Development.';
    }

    applyNow() {
        this.status = 'Applied';
    }
}