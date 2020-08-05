import { LightningElement, track, wire} from 'lwc';
import { deleteRecord } from 'lightning/uiRecordApi';

import {
    ShowToastEvent
} from 'lightning/platformShowToastEvent';

import getTransactions from '@salesforce/apex/TransactionHelper.getUserTransactions';

// impoting USER id
import USER_ID from '@salesforce/user/Id'; 

export default class TransactionsComponent extends LightningElement {
    
    @track userTransactions;
    @track error;
    userId = USER_ID;


    @wire(getTransactions, {userId: USER_ID}) transactions
    ({ error, data }) {
        console.log('Data list  :' + data);
        this.userTransactions = data;
        this.error = error;
    };

    deleteTransaction(event) {
        const recordId = event.target.dataset.recordid;
        console.log('delete transaction' + recordId);
        deleteRecord(recordId)
            .then(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Record Is  Deleted',
                        variant: 'success',
                    }),
                );
                this.userTransactions = this.userTransactions.filter(item => item.Id != recordId);
                eval("$A.get('e.force:refreshView').fire();");
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error While Deleting record',
                        message: error.message,
                        variant: 'error',
                    }),
                );
                console.log(error);
            });
    }


    get userTransactions() {
        return this.userTransactions;
    }

    get error() {
        return this.error;
    }

    
}