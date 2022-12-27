import { LightningElement, api, wire, track } from 'lwc';
import getRecords from '@salesforce/apex/GetKeyContactRecords.getRecords';


// Creating constant called "columns" whici is an array [ of objects {}]
const columns = [
    { label: 'Name', fieldName: 'Name' },
    { label: 'Phone', fieldName: 'Mobile__c' },
    { label: 'Email', fieldName: 'Email__c' },
    { label: 'Type', fieldName: 'Type__c' },
];
export default class AccountKeyContactRecords extends LightningElement 
{
    @api recordId;
    @track columns = columns;
    data = [];
    @wire(getRecords, { recordId : '$recordId' })
    wiredContacts({ error, data }) {
        if (data) {
            this.data = data;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            console.log("error occured");
        }
    }

}