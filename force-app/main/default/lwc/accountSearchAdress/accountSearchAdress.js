import { LightningElement } from 'lwc';

import searchZipCode from '@salesforce/apex/AccountSearchAddressController.fetchAddress';
import updateAccount from '@salesforce/apex/AccountSearchAddressController.saveAccount';

export default class AccountSearchAddress extends LightningElement {}