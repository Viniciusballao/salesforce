import { LightningElement,track} from 'lwc';
import { CloseActionScreenEvent } from 'lightning/actions';

import searchZipCode from '@salesforce/apex/AccountSearchAddressController.fetchAddress';
import updateAccount from '@salesforce/apex/AccountSearchAddressController.saveAccount';

export default class AccountSearchAddress extends LightningElement {
    @track cep;
    @track logradouro;
    @track bairro;
    @track cidade;
    @track uf;

    handleInputChange(event) {
        this.cep = event.detail.value.replace(/\D/g,"");
        console.log(this.cep.length);
        if(this.cep.replace(/\D/g,"").length == 8){
            console.log('TAMO JUNTO TIME');
            searchZipCode({cep:this.cep}).then(response => {
                console.log(response);
                console.log('New');

                this.bairro = response.bairro;
                this.logradouro = response.logradouro;
                this.cidade = response.localidade;
                this.uf = response.uf;                
            }).catch(error => {
                console.log('Error' + error.body.message);
            })
        }else{
            this.logradouro = '';
        }
    }

}