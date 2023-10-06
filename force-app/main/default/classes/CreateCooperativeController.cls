public with sharing class CreateCooperativeController {
    @AuraEnabled
    public static Account createNewCooperative(Account acc){
        insert acc;
        return acc;
    }
}