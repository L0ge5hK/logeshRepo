import { LightningElement, api, wire, track } from 'lwc';
import getRecords from '@salesforce/apex/GetKeyContactRecords.getRecords';

//recs

export default class AcckeyconHTMLTABLE extends LightningElement 
{
    @api recordId;
    keyconlist = [];
    @wire (getRecords, ({recordId : '$recordId'}))
    check({data,error})
    {
        if(data)
        {
            this.keyconlist = data;
        }
        else
        {
            this.error = error;
            console.log('Error !!');
        }
    }
}