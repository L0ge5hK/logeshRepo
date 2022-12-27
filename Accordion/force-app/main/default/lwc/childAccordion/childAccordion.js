import { LightningElement, api, wire} from 'lwc';
import getchildrecords from "@salesforce/apex/DisplayDataInAccordion.getRelatedRecordList";

export default class ChildAccordion extends LightningElement 
{
    //public variables (to pass values)
    @api parentid;

    //other variables
    recordsfromparent = [];

    //wire method
    @wire(getchildrecords, {idfromjs : '$parentid'})
    theRecievedData({data,err})
    {
        if (data) 
        {
            this.recordsfromparent = data;
        } 
        else 
        {
            console.log('Error in the related data X---> ',err);
        }
    }
}