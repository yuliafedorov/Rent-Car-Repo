trigger CarTrigger on Car__c(after insert, after update) {
    CarTriggerHandler.updateOpenDeal(Trigger.new, Trigger.oldMap);
}