global  with sharing class InactivateAccountSchedulable implements Schedulable {
    global void execute(SchedulableContext SC) {
       Database.executeBatch(new InactivateAccountBatch());
     }
}