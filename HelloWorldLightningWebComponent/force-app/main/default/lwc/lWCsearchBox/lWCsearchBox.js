import { LightningElement,wire,track, api } from 'lwc';
import getAccounts from '@salesforce/apex/GetAccountRecords.getAccounts';
const DELAY = 300;
export default class LWCsearchBox extends LightningElement 
{
    @api accountName='';
    @track selectedaccname ;
    @track accountList =[];
    @api dropdown = false;
    @track namecheck = false;
    @wire(getAccounts,{accname:'$accountName'}) 
    retrieveAccouts({error,data})
    { 
        if(data)
        {
            this.accountList = data;
        }
        else if(error)
        {
            alert('Error !! Check Again Please..');
        }
    }
    @api
    handleKeyChange(event)
    {
        this.dropdown = true;
        const searchString= event.target.value;
        window.clearTimeout(this.delayTimeout);
        this.delayTimeout = setTimeout(()=>{
            this.accountName =searchString;
        },DELAY);
    }
    @api getAccName(event)
    {
        this.dropdown = false;
        this.selectedaccname = event.target.value;
        alert(this.selectedaccname);
        this.namecheck = true;
    }
}