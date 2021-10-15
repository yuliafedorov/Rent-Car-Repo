trigger CarTrigger on Car__c(after insert, after update) {
    if(Trigger.isAfter){
       // CarTriggerHandler.updateOpenDeal(Trigger.New);
    }

}