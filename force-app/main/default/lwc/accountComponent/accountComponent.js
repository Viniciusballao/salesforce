import { LightningElement, api  } from 'lwc';
import { CloseActionScreenEvent } from 'lightning/actions';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import ACCOUNTNUMBER_FIELD from '@salesforce/schema/Account.AccountNumber';
import TYPE_FIELD from '@salesforce/schema/Account.Type';

export default class AccountComponent extends LightningElement {
    @api recordId;
    @api objectApiName;

    fields = [NAME_FIELD, ACCOUNTNUMBER_FIELD, TYPE_FIELD];

    closeQuickAction() {
        this.dispatchEvent(new CloseActionScreenEvent());
    }
}