import { LightningElement } from 'lwc';
import getAccounts from '@salesforce/apex/GetAgencyCostController.getAccounts';
import getAgenciesHigherCost from '@salesforce/apex/GetAgencyCostController.getAgenciesWithHigherCost';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class GetAgencyCost extends LightningElement {

    options = [];
    accountId = '';  

    columns = [        
        { label: 'Agência', fieldName: 'Name', type: 'text' },
        { label: 'Custo', fieldName: 'MonthlyCost__c', type: 'number'}
    ]; 
    agencyList;

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

    handleChangeCombobox(event) {
        this.accountId= event.detail.value;
      } 

    handleClick() {
        getAgenciesHigherCost({accountId:this.accountId}).then(result => {
            this.agencyList = result;
        })
        .catch(error =>{
            this.error = error.message;

        });
    }

}