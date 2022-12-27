import { LightningElement, api, track, wire } from 'lwc';
import fetchAccountNames from '@salesforce/apex/getPCAccounts.fetchAccountNames';
const DELAY = 300;
export default class ParentComponent extends LightningElement 
{
    accountName = '';
    @track errorcheck;
    @track accountList =[];
    @track keycontactsfromchild = [];
    @track selectedaccname;
    @track selectedaccid;
    @track dropdown = false;
    @wire(fetchAccountNames,{searchname:'$accountName'}) 
    retrieveAccouts({error,data})
    {
        console.log('accountNAme == ',this.accountName);
        if(data)
        {
            this.accountList = data;
        }
        else if(error)
        {
            console.log('Error !! Check Again Please.. (data not passed)');
        }
    }
    
    handleKeyChange(event)
    {
        this.dropdown = true;
        const searchString= event.target.value;
        //console.log('searchString >-> '+event.target.value);
        //iperative method to call apex class
        /*fetchAccountNames({ searchname : this.accountName })
		.then(result => {
            console.log('accountlist in .then method -->> '+this.accountList+'-- the result is >->-> '+result);
			this.accountList = result;
			this.errorcheck = undefined;
		})
		.catch(error => {
            console.log('the ****in error -->'+ error);
			this.errorcheck = error;
			this.accountList = undefined;
		})*/
        // --- iperative method ends here ---

        window.clearTimeout(this.delayTimeout);
        this.delayTimeout = setTimeout(() => {
            this.accountName = searchString;
        },DELAY);
    }

    @api getAccName(event)
    {
        this.selectedaccname = event.currentTarget.dataset.value;
        this.selectedaccid = event.currentTarget.dataset.id;
        this.dropdown = false;
        console.log('--> '+this.selectedaccname+' --theEvent-->     '+event.currentTarget.dataset.value);
    }

    handleKeyContact(event)
    {
        this.keycontactsfromchild = event.detail;
        console.log('the keycontactlist in parent --> '+this.keycontactsfromchild);
    }
}