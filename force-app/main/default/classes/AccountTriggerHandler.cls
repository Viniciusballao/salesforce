public with sharing class AccountTriggerHandler {
    
    public void beforeInsert(List<Account> accountList){
        Utils utils = new Utils();

        for (Account account : accountList) {
            Integer accountNumberSize = account.AccountNumber?.replaceAll('[^0-9]', '')?.length();
            switch on accountNumberSize {
                when 11 {
                    utils.ValidaCPF(account.AccountNumber);
                }
                when 14 {
                    utils.ValidaCNPJ(account.AccountNumber);                    
                }
                when else {
                    account.addError('Número do cliente é inválido');
                }
            }
        }
    }

    public void afterInsert(Map<Id,Account> newMap){
        Id parceiroRecordType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Parceiro').getRecordTypeId();
        Id consumidorFinalRecordType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Consumidor final').getRecordTypeId();
        List<Opportunity> oppList = new List<Opportunity>();
        List<Task> taskList = new List<Task>();
        List<Account> parceiroList = new List<Account>();
        List<Account> consumidorList = new List<Account>();        

        for (String key : newMap.keySet()) {

            if (newMap.get(key).RecordTypeId == parceiroRecordType) {
                oppList.add(createOpportunity(newMap.get(key)));
            }
            if (newMap.get(key).RecordTypeId == consumidorFinalRecordType) {
                taskList.add(createTask(newMap.get(key)));  
            }
        }

        if (!oppList.isEmpty()) {
            Database.insert(oppList);
        }
        if (!taskList.isEmpty()) {
            Database.insert(taskList);
        }
    }

    private Opportunity createOpportunity(Account account){
        Opportunity opp = new Opportunity();
        opp.Name = account.name + ' - opp Parceiro';
        opp.CloseDate = date.today().addDays(30);
        opp.StageName = 'Qualification';
        return opp;
    }

    private task createTask(Account account){
        Task task = new Task();
        task.Subject = 'Consumidor Final';
        task.WhatId = account.Id;
        task.Status = 'Not Started';
        task.Priority = 'Normal';
        return task;
    }
}