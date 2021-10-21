trigger DealTrigger on Deal__c (before insert, before update){
    if(Trigger.isBefore){
        DealTriggerHandler.preventDealDuplicate(Trigger.new);
        DealTriggerHandler.changeStatusField(Trigger.new);
    }
}