import { LightningElement, api, wire, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import returnOpenDeals from '@salesforce/apex/OpenDealsController.returnOpenDeals';
//import pushSalesManager from '@salesforce/apex/OpenDealsController.pushSalesManager';


const columns = [
    { label: 'Name', fieldName: 'Name' },
    { label: 'Car', fieldName: 'Car_Name__c' },
    { label: "Start Date", fieldName: "Start_Date__c"},
    { label: "End Date", fieldName: "End_Date__c"}
];
export default class OpenDeals extends LightningElement {
    @api recordId;
    columns = columns;

    @wire(returnOpenDeals, { salesManagerId: '$recordId' })
    deals;

    showToast() {
        const event = new ShowToastEvent({
            title: 'Warning',
            message: 'Manager Sync is not yet configured',
            variant: 'warning'
        });
        this.dispatchEvent(event);
    }

    // pushSalesManager (){
    //     pushSalesManager({
    //         salesManagerId: this.recordId
    //     })
    //     .then(result => {
    //         if(result){
    //             console.log(result);
    //             console.log('+++');
    //         }
    //     })
    //     .catch(error => {
    //         console.log('Error: ', error);
    //         console.log('------');
    //     })
    // }
}