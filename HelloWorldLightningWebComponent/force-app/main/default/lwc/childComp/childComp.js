import { LightningElement, api, track, } from 'lwc';
import getRecords from '@salesforce/apex/GetKeyContactRecords.getRecords'
export default class ChildComp extends LightningElement 
{
    @api pillvalue;
    @api selectedAccountId;
    @track keycontactlist = [];
     cover = true;


    /*@wire(getRecords,{recordId:'$selectedAccountId'}) 
    retrieveAccouts({error,data})
    { 
        if(data)
        {
            this.keycontactlist = data;
            console.log('keycontactlist is -->     '+this.keycontactlist);

            //create event and despatch it
            let selectedEvent = new CustomEvent('keycontactlist', {detail: this.keycontactlist});
            console.log('the selectedEVENT -->> '+selectedEvent);
            this.dispatchEvent(selectedEvent);
        }
        else if(error)
        {
            console.log('Error !! Check Again Please..');
        }
    }*/

    showKeyContacts()
    {
        getRecords({ recordId : this.selectedAccountId })
		.then(result => {
            console.log('keycontact in .then method -->> '+this.keycontactlist+'-- the result is >->-> '+JSON.stringify(result));
			this.keycontactlist = result;
			this.errorcheck = undefined;
            //create event and despatch it to parent
            let selectedEvent = new CustomEvent('keycontactlist', {detail: this.keycontactlist});
            this.dispatchEvent(selectedEvent);
		})
		.catch(error => {
            console.log('the ****in error -->'+ error);
			this.errorcheck = error;
			this.keycontactlist = undefined;
        })
    }

    handleRemove()
    {
        console.log('pill value is -->  '+this.pillvalue+' -- accId from parent -->'+this.selectedAccountId);
    }
}