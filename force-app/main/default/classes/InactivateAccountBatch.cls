public with sharing class InactivateAccountBatch implements Database.Batchable<sObject> {
    public InactivateAccountBatch() {

    }

    public Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator([
            SELECT id,Inativa__c, 
            (SELECT id from Tasks where CreatedDate = LAST_90_DAYS),
            (SELECT id FROM Opportunities WHERE (IsWon = true and CloseDate = LAST_N_DAYS:120) OR StageName = 'Negotiation/Review' )
            FROM Account where Inativa__c = false]);
   }

   public void execute(Database.BatchableContext BC, List<Account> scope){
        List<Account> accList = new List<Account>();
        for (Account acc : scope) {
            if (acc.Tasks.size() == 0 || acc.Opportunities.size() == 0) {
                acc.Inativa__c = true;
                accList.add(acc);
            }
        }
        if (!accList.isEmpty()) {
            Database.update(accList);
        }
        
    }

   public void finish(Database.BatchableContext BC){
   }
}