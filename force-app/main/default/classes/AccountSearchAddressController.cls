public with sharing class AccountSearchAddressController {
    @AuraEnabled
    public static ZipCodeAddress fetchAddress(String cep) {
        String calloutJSON = callViaCep(cep);
        system.debug('DEBUGLOG ' + calloutJSON);
        Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(calloutJSON);
        ZipCodeAddress zipCode = new ZipCodeAddress(); 
        zipCode.logradouro = string.valueOf(results.get('logradouro'));
        zipCode.bairro = string.valueOf(results.get('bairro'));
        zipCode.uf = string.valueOf(results.get('uf'));
        zipCode.localidade = string.valueOf(results.get('localidade'));
        return zipCode; 
    }


    @AuraEnabled
    public static void saveAccount() {}

    public static String callViaCep(String cep){

        Http callout = new Http();
        HttpRequest req = new HttpRequest();
        req.setMethod('GET');
        req.setEndpoint('https://viacep.com.br/ws/'+ cep + '/json/');
        
        HttpResponse res = callout.send(req);
        return res.getBody();
    }
}