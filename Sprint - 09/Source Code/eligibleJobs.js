import { LightningElement, api, wire } from 'lwc';
import getEligibleJobs from '@salesforce/apex/EligibleJobsController.getEligibleJobs';

export default class EligibleJobs extends LightningElement {
    @api recordId;

    jobs = [];
    selectedJob;
    error;
    loading = true;

    @wire(getEligibleJobs, { studentId: '$recordId' })
    wiredJobs({ data, error }) {
        this.loading = false;

        if (data) {
            this.jobs = data;
            this.error = undefined;
        } else if (error) {
            this.jobs = [];
            this.error = 'Unable to load eligible jobs.';
        }
    }

    get hasJobs() {
        return this.jobs && this.jobs.length > 0;
    }

    get hasSelectedJob() {
        return this.selectedJob != null;
    }

    handleViewDetails(event) {
        const jobId = event.currentTarget.dataset.id;

        this.selectedJob = this.jobs.find(
            job => job.Id === jobId
        );
    }
}
