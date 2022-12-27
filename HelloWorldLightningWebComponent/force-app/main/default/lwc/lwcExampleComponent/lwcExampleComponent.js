import {LightningElement, api, wire, track} from 'lwc';
import addToRecentItems from '@salesforce/apex/GetAccountRecords.setObjectToRecentItems';
export default class LwcExampleComponent extends LightningElement 
{
    @api name;
    @api variant = "label-hidden";
    @api fieldLabel;
    @api childObjectApiName;
    @api targetFieldApiName;
    @api value;
    @api required = false;
    @api addToRecent = false;

    handleChange(event) 
    {
        let selectedEvent = new CustomEvent('valueselected', {detail: event.detail.value});
        this.dispatchEvent(selectedEvent);
        console.log('Selected -->  '+selectedEvent);

        if (this.addToRecent) {
            if (event.detail.value.length > 0 && event.detail.value[0].length > 0) 
            {
                addToRecentItems({
                    recordId: event.detail.value[0]
                })
                    .catch(error => {
                        console.log(error);
                    });
            }
        }
    }

    @api reportValidity() 
    {
        if(this.required) 
        {
            this.template.querySelector('lightning-input-field').reportValidity();
        }
    }

}