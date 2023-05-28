trigger AccountTrigger on Account (before insert,after insert, before update, after update) {
    AccountTriggerHandler accountTriggerHandler = new AccountTriggerHandler();
    if (Trigger.isInsert && Trigger.isBefore) {
        accountTriggerHandler.beforeInsert(Trigger.new);
    }
    if (Trigger.isInsert && Trigger.isAfter) {        
        accountTriggerHandler.afterInsert(Trigger.newMap);
    }

}