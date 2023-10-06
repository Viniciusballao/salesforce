public with sharing class CreateCooperative {
    @AuraEnabled
    public static Account createNewCooperative(Account acc){
        insert acc;
        return acc;
    }
}