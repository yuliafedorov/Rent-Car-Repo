import { LightningElement, api, wire, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getContactListyy from '@salesforce/apex/OpenDealsController.returnOpenDeals';


const columns = [
    { label: 'Name', fieldName: 'Name' },
    { label: 'Car', fieldName: 'Car_Name__c' },
    { label: "Start Date", fieldName: "Start_Date__c"},
    { label: "End Date", fieldName: "End_Date__c"}
];
export default class OpenDeals extends LightningElement {
    @api recordId;
    error;
    columns = columns;

     @wire(getContactListyy, { salesManagerId: '$recordId' })
    deals;

    @wire(test, { salesManagerId: '$recordId' })
    tests;

    showToast() {
        const event = new ShowToastEvent({
            title: 'Warning',
            message: 'Manager Sync is not yet configured',
            variant: 'warning'
        });
        this.dispatchEvent(event);
    }

}