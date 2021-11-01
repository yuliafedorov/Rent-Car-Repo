import { LightningElement, api, wire, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import returnOpenDeals from '@salesforce/apex/OpenDealsController.returnOpenDeals';
import pushSalesManager from '@salesforce/apex/OpenDealsController.pushSalesManager';


const columns = [
    { label: 'Name', fieldName: 'Name' },
    { label: 'Car', fieldName: 'Car_Name__c' },
    { label: "Start Date", fieldName: "Start_Date__c",
        type: "date",
        typeAttributes:{
            year: "numeric",
            month: "long",
            day: "2-digit",
            hour: "2-digit",
            minute: "2-digit"
        }
    },
    { label: "End Date", fieldName: "End_Date__c",
        type: "date",
        typeAttributes:{
            year: "numeric",
            month: "long",
            day: "2-digit",
            hour: "2-digit",
            minute: "2-digit"
        }
    }
];
export default class OpenDeals extends LightningElement {
    @api recordId;
    columns = columns;

    @wire(returnOpenDeals, { salesManagerId: '$recordId' })
    deals;

    pushSalesManager (){
        pushSalesManager({
            salesManagerId: this.recordId
        })
        .then(result => {
            const event = new ShowToastEvent({
                title: "Sucess!",
                message: "System manager is synchronized.",
                variant: "success",
                mode: "pester",
                });
                this.dispatchEvent(event);
        })
        .catch(error => {
            const event = new ShowToastEvent({
                title: "Error!",
                message: "System manager is not synchronized.",
                variant: "error",
                mode: "pester",
                });
                this.dispatchEvent(event);
        })
    }

    // showToast() {
    //     const event = new ShowToastEvent({
    //         title: 'Warning',
    //         message: 'Manager Sync is not yet configured',
    //         variant: 'warning'
    //     });
    //     this.dispatchEvent(event);
    // }
}