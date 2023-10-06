public with sharing class CreateAgencyController {
    @AuraEnabled(cacheable=false)
    public static list<Account> getAccounts(){
            list<account> accountList =[SELECT Id,Name from Account]; 
            return accountList;
    }

    @AuraEnabled
    public static Contact createNewAgency(Contact con){
        con.FirstName = 'Agência';
        insert con;
        return con;
    }
}