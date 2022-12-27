import { LightningElement, wire} from 'lwc';
import accountrecords from '@salesforce/apex/DisplayDataInAccordion.fetchrecords'
// import relatedcontacts from '@salesforce/apex/DisplayDataInAccordion.getRelatedContactList'

export default class AccordionToDisplatData extends LightningElement 
{
    //variables used
    activeSections = null;
    selectedaccountid ;
    accrecords = [];
    relatedcontactlist = [];

  //wire method to get records
  @wire(accountrecords)
  recievedrecords ({data,err})
  {
    if(data)
    {
      console.log('the data ->> ',data);
        this.accrecords = data;
        console.log('the records -- accordion    ',this.accrecords);
    }
    else
    {
        console.log('ERROROROROR -> ',err);
    }
  }

  //runs when an accordion section is selected
  onSelectingThisSection(event)
  {
    this.selectedaccountname = event.detail.openSections;
    console.log('the val of this section',this.selectedaccountname);
  }

}