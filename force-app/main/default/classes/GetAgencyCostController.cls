public with sharing class GetAgencyCostController {
    @AuraEnabled(cacheable=false)
    public static list<Account> getAccounts(){
            list<account> accountList =[SELECT Id,Name from Account]; 
            return accountList;
    }

    @AuraEnabled(cacheable=false)
    public static list<Contact> getAgenciesWithHigherCost(String accountId){
            list<Contact> agencyList =[SELECT Name, MonthlyCost__c FROM Contact WHERE AccountId = :accountId]; 
            Decimal totalCost = 0;
            for (Contact con : agencyList) {
                if (con.MonthlyCost__c != null && con.MonthlyCost__c > 0) {
                    totalCost += con.MonthlyCost__c;
                }                
            }
            if(agencyList.size() == 0 ||totalCost == 0){
                return null;
            }
            Decimal mediumCost = (totalCost / agencyList.size()).round();
            List<Contact> higherCostAgenciesList = new list<Contact>();
            for(Contact con : agencyList){
                if (con.MonthlyCost__c != null && con.MonthlyCost__c > mediumCost) {
                    higherCostAgenciesList.add(con);
                }
            }
            return higherCostAgenciesList;
    }

}