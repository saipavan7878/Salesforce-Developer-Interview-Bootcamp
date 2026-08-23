import { LightningElement, api } from 'lwc';

export default class StudentProfile extends LightningElement {
    @api recordId;

    successMessage = '';
    errorMessage = '';

    handleSuccess() {
        this.errorMessage = '';
        this.successMessage = 'Profile updated successfully.';

        this.dispatchEvent(
            new CustomEvent('profilesaved', {
                detail: {
                    studentId: this.recordId
                }
            })
        );
    }

    handleError(event) {
        this.successMessage = '';
        this.errorMessage =
            'We could not update your profile.';

        console.error(
            'Profile update error:',
            event.detail
        );
    }
}
