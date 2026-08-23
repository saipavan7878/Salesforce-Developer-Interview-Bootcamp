import { LightningElement, api, wire } from 'lwc';
import { refreshApex } from 'lightning/uiRecordApi';
import getEligibleJobs from '@salesforce/apex/EligibleJobsController.getEligibleJobs';
import applyForJob from '@salesforce/apex/ApplicationController.applyForJob';

export default class EligibleJobs extends LightningElement {
    @api recordId;

    jobs = [];
    selectedJob;
    error;
    loading = true;
    applying = false;
    successMessage = '';

    wiredJobsResult;

    @wire(getEligibleJobs, { studentId: '$recordId' })
    wiredJobs(result) {
        this.wiredJobsResult = result;

        const { data, error } = result;

        this.loading = false;

        if (data) {
            this.jobs = data;
            this.error = undefined;
        } else if (error) {
            this.jobs = [];
            this.error = 'Unable to load eligible jobs.';
        }
    }

    @api
    refreshJobs() {
        this.loading = true;
        return refreshApex(this.wiredJobsResult);
    }

    get hasJobs() {
        return this.jobs && this.jobs.length > 0;
    }

    get hasSelectedJob() {
        return this.selectedJob != null;
    }

    handleViewDetails(event) {
        const jobId = event.detail.jobId;

        this.selectedJob = this.jobs.find(
            job => job.Id === jobId
        );

        this.successMessage = '';
    }

    async handleApply(event) {
        const jobId = event.detail.jobId;

        this.applying = true;
        this.error = undefined;
        this.successMessage = '';

        try {
            await applyForJob({
                studentId: this.recordId,
                jobId: jobId
            });

            this.successMessage = 'Application submitted successfully.';

            await this.refreshJobs();

            this.dispatchEvent(
                new CustomEvent('applicationsubmitted', {
                    detail: {
                        jobId: jobId
                    }
                })
            );

        } catch (error) {
            this.error =
                error?.body?.message ||
                'Unable to submit application.';
        } finally {
            this.applying = false;
        }
    }
}