import { LightningElement, api, wire, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getContactListyy from '@salesforce/apex/OpenDealsController.returnOpenDeals';
import getAccountCallout from '@salesforce/apex/OpenDealsController.getAccountCallout';


const columns = [
    { label: 'Name', fieldName: 'Name' },
    { label: 'Car', fieldName: 'Car_Name__c' },
    { label: "Start Date", fieldName: "Start_Date__c"},
    { label: "End Date", fieldName: "End_Date__c"}
];
export default class OpenDeals extends LightningElement {
    @api recordId;
    columns = columns;
    @track accounts;
    @track error;

     @wire(getContactListyy, { salesManagerId: '$recordId' })
    deals;

    //  @wire(getAccountCallout, { salesManagerId: '$recordId' })
    //  tests;

    showToast() {
        
        const event = new ShowToastEvent({
            title: 'Warning',
            message: 'hiManager Sync is not yet configured',
            variant: 'warning'
        });
        this.dispatchEvent(event);

        getAccountCallout(this.recordId)
        .then(result => {
            this.accounts = result;
        })
        .catch(error => {
            this.error = error;
        });
    }

}