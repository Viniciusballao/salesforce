import { LightningElement } from 'lwc';
import getAccounts from '@salesforce/apex/CreateAgencyController.getAccounts';
import createNewAgency from '@salesforce/apex/CreateAgencyController.createNewAgency';
import NAME_FIELD from '@salesforce/schema/Contact.LastName';
import ACCOUNT_FIELD from '@salesforce/schema/Contact.AccountId';
import COST_FIELD from '@salesforce/schema/Contact.MonthlyCost__c';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class CreateAgency extends LightningElement {
    fieldNames = {
        Name: NAME_FIELD.fieldApiName,
        Cost: COST_FIELD.fieldApiName,
        Account: ACCOUNT_FIELD.fieldApiName
      };

      con = {
        [NAME_FIELD.fieldApiName]: "",
        [ACCOUNT_FIELD.fieldApiName]: "",
        [COST_FIELD.fieldApiName]: ""
      };
      
      options = [];

      renderedCallback() {
        if(this.options.length == 0){
            getAccounts().then(item => {
                this.options = item.map(items => {
                    return {
                        label: items.Name,
                        value: items.Id
                    }
                })
            })
        }
    }

    handleChangeEvent(event) {
        this.con[event.target.name] = event.target.value;
      }
    
      handleChangeCombobox(event) {
        this.con[ACCOUNT_FIELD.fieldApiName] = event.detail.value;
      } 


      handleClick() {
        createNewAgency({con:this.con}).then(result => {

            const toastEvent = new ShowToastEvent({
                title:'Successo!',
                message:'Agencia foi criada com sucesso!',
                variant:'success'
            });
            this.dispatchEvent(toastEvent);
        })
        .catch(error =>{
            this.error = error.message;

        });
    }
}
