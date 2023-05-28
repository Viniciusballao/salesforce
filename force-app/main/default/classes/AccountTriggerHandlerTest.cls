@isTest
public with sharing class AccountTriggerHandlerTest {

    @IsTest
    static void testErrorInsert(){
        
        List<Account> accList = createErrorAccount(1);
        Test.startTest();
        try {
            insert(accList);            
        } catch (Exception ex) {
            Assert.areEqual(true, ex.getMessage().contains('Número do cliente é inválido'));
        }    
        Test.stopTest();
    }

    @isTest
    static void testParceiro(){
        
        List<Account> accList = createAccount(200, 'Parceiro');
        Test.startTest();
        insert accList;
        Test.stopTest();
    }

    @isTest
    static void testConsumidor(){
        
        List<Account> accList = createAccount(200, 'Consumidor final');
        Test.startTest();
        insert accList;
        Test.stopTest();

    }

    private static List<Account> createErrorAccount(Integer howMany){
        List<Account> accList = new List<Account>();
        for (Integer i = 0; i < howMany; i++) {
            Account acc = new Account();
            acc.Name = 'Test error number ' + i;
            accList.add(acc);
        }
        return accList;
    }
    
    private static List<Account> createAccount(Integer howMany, String type){
        List<Account> accList = new List<Account>();
        Id recordType = type == 'Parceiro'? Schema.SObjectType.Account.getRecordTypeInfosByName().get('Parceiro').getRecordTypeId() : Schema.SObjectType.Account.getRecordTypeInfosByName().get('Consumidor final').getRecordTypeId();

        for (Integer i = 0; i < howMany; i++) {
            Account acc = new Account();
            acc.Name = 'Test parceiro number ' + i;
            acc.AccountNumber = type == 'Parceiro' ? '91.889.918/0001-99' : '884.877.961-17';
            acc.RecordTypeId = recordType;
            accList.add(acc);
        }
        return accList;
    }
}