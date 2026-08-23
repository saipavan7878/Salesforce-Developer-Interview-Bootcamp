import { LightningElement, api } from 'lwc';

export default class Placementchild extends LightningElement {
    @api studentId;

    notifyParent() {
        this.dispatchEvent(
            new CustomEvent('studentselected', {
                detail: {
                    message: 'Child sent a message to the Parent successfully!'
                }
            })
        );
    }
}