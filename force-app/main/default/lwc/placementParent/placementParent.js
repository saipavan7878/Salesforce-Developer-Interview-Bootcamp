import { LightningElement } from 'lwc';

export default class PlacementHome extends LightningElement {
    studentName = 'Rahul';
    rollNumber = '22B81A0501';
    department = 'CSE';

    message = '';

    showMessage() {
        this.message = 'Welcome to Salesforce Development.';
    }
}