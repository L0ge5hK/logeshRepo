import { LightningElement } from 'lwc';

export default class ToastSuccessFlowsLWC extends LightningElement 
{
    connectedCallBack()
    {
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Success',
                type : 'Success',
                message: 'New Contact Created',
                variant: 'success',
            }),
        );
    }
}