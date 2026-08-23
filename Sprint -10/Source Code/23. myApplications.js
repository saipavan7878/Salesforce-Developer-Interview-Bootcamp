import { LightningElement, api, wire } from 'lwc';
import { refreshApex } from 'lightning/uiRecordApi';

import getMyApplications
    from '@salesforce/apex/MyApplicationsController.getMyApplications';

export default class MyApplications extends LightningElement {
    @api recordId;

    applications = [];
    error;
    loading = true;

    wiredApplicationsResult;

    @wire(
        getMyApplications,
        { studentId: '$recordId' }
    )
    wiredApplications(result) {
        this.wiredApplicationsResult = result;

        const { data, error } = result;

        this.loading = false;

        if (data) {
            this.applications = data;
            this.error = undefined;
        } else if (error) {
            this.applications = [];
            this.error =
                'Unable to load your applications.';
        }
    }

    @api
    refreshApplications() {
        this.loading = true;

        return refreshApex(
            this.wiredApplicationsResult
        );
    }

    get hasApplications() {
        return this.applications &&
               this.applications.length > 0;
    }
}
