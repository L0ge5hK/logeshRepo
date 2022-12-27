import { LightningElement, api, wire, track } from 'lwc';
import getTheName from '@salesforce/apex/GetAccountRecords.getTheName';
export default class LwcPCrelationshipSearch extends LightningElement 
{
    accountId;
    @track accName;
    @track checklist = [];

     handleSelectedLookup(event) 
     {
         this.accountId = event.detail;
     }

     @wire(getTheName,{accountId : '$accountId'}) 
        checkAccount({data,error})
    { 
        console.log('The Returned ->    '+data+'    <-->    '+this.accountId);
        if(data)
        {
            this.checklist = data;
            console.log('checking --    '+this.checklist);
        }
        else if(error)
        {
            console.log('Error !! Check Again Please..');
        }
    }

}