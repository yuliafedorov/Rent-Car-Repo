import { LightningElement, wire, api, track} from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';
import getOpenDeal from '@salesforce/apex/OpenDealsController.returnOpenDeals';
import pushSalesManager from '@salesforce/apex/OpenDealsController.pushSalesManager';


const columns = [
    { label: 'Name', fieldName: 'Name', sortable: true, },
        { label: 'Car', fieldName: 'Car_Name__c', sortable: true, },
        { label: "Start Date", fieldName: "Start_Date__c",
            type: "date",
            sortable: true,
            typeAttributes:{
                year: "numeric",
                month: "long",
                day: "2-digit",
                hour: "2-digit",
                minute: "2-digit"
            }
        }
    ];

export default class LightningDatatableExample extends LightningElement {
    @track value;
    @track error;
    @track data;
    @api recordId;
    @api sortedDirection = 'asc';
    @api sortedBy = 'Name';
    @api searchKey = '';
    result;
    
    @track page = 1; 
    @track items = []; 
    @track data = []; 
    @track columns; 
    @track startingRecord = 1;
    @track endingRecord = 0; 
    @track pageSize = 5; 
    @track totalRecountCount = 0;
    @track totalPage = 0;
  
    @wire(getOpenDeal, {searchKey: '$searchKey', sortBy: '$sortedBy', sortDirection: '$sortedDirection', salesManagerId: '$recordId' })
    wiredDeal({ error, data }) {
        if (data) {
        
            this.items = data;
            this.totalRecountCount = data.length; 
            this.totalPage = Math.ceil(this.totalRecountCount / this.pageSize); 
            
            this.data = this.items.slice(0,this.pageSize); 
            this.endingRecord = this.pageSize;
            this.columns = columns;

            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.data = undefined;
        }
    }

    //clicking on previous button this method will be called
    previousHandler() {
        if (this.page > 1) {
            this.page = this.page - 1; //decrease page by 1
            this.displayRecordPerPage(this.page);
        }
    }

    //clicking on next button this method will be called
    nextHandler() {
        if((this.page<this.totalPage) && this.page !== this.totalPage){
            this.page = this.page + 1; //increase page by 1
            this.displayRecordPerPage(this.page);            
        }             
    }

    //this method displays records page by page
    displayRecordPerPage(page){

        this.startingRecord = ((page -1) * this.pageSize) ;
        this.endingRecord = (this.pageSize * page);

        this.endingRecord = (this.endingRecord > this.totalRecountCount) 
                            ? this.totalRecountCount : this.endingRecord; 

        this.data = this.items.slice(this.startingRecord, this.endingRecord);

        this.startingRecord = this.startingRecord + 1;
    }    
    
    sortColumns( event ) {
        this.sortedBy = event.detail.fieldName;
        this.sortedDirection = event.detail.sortDirection;
        return refreshApex(this.result);
        
    }
  
    handleKeyChange( event ) {
        this.searchKey = event.target.value;
        return refreshApex(this.result);
    }

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

}