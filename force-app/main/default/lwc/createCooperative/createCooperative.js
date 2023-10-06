import { LightningElement, track } from 'lwc';
import createAccount from '@salesforce/apex/CreateCooperativeController.createNewCooperative';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import STREET_FIELD from '@salesforce/schema/Account.BillingStreet';
import PHONE_FIELD from '@salesforce/schema/Account.Phone';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class CreateCooperative extends LightningElement {

    fieldNames = {
        Name: NAME_FIELD.fieldApiName,
        Phone: PHONE_FIELD.fieldApiName,
        Street: STREET_FIELD.fieldApiName
      };

      acc = {
        [NAME_FIELD.fieldApiName]: "",
        [STREET_FIELD.fieldApiName]: "",
        [PHONE_FIELD.fieldApiName]: ""
      };

    handleChangeEvent(event) {
        this.acc[event.target.name] = event.target.value;
      }

      handleClick() {
        createAccount({acc:this.acc}).then(result => {
            this.acc = {};
            const toastEvent = new ShowToastEvent({
                title:'Successo!',
                message:'Cooperativa foi criada com sucesso!',
                variant:'success'
            });
            this.dispatchEvent(toastEvent);
        })
        .catch(error =>{
            this.error = error.message;

        });
    }
    
}