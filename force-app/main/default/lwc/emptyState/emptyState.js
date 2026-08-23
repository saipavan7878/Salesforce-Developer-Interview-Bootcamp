import { LightningElement, api } from 'lwc';

export default class EmptyState extends LightningElement {
    @api title = 'No Records';
    @api message = 'There is nothing to display.';
    @api actionLabel;

    get hasAction() {
        return !!this.actionLabel;
    }

    handleAction() {
        this.dispatchEvent(
            new CustomEvent('action')
        );
    }
}