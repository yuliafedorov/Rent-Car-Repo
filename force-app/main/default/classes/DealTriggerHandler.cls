public  class DealTriggerHandler {
    

    public static void preventDealDuplicate(List<Deal__c> dealFromTrigger) {
        Set<Id> carFromTriggerIdSet = new Set<Id>();
        for(Deal__c currentDeal: dealFromTrigger){
            carFromTriggerIdSet.add(currentDeal.Car__c);
        }
        List<Deal__c> dealList = [SELECT Name, Car__c, Status__c, End_Date__c, Start_Date__c 
                                FROM Deal__c WHERE (Status__c = 'Open' OR Status__c = 'Won')
                                AND  Car__c IN :carFromTriggerIdSet];
        for(Deal__c currentDeal: dealFromTrigger) {
            for(Integer i = 0; i < dealList.size(); i++){
                if (currentDeal.Car__c == dealList[i].Car__c
                && currentDeal.Status__c == dealList[i].Status__c 
                && currentDeal.Start_Date__c == dealList[i].End_Date__c
                && currentDeal.End_Date__c == dealList[i].Start_Date__c){
                    currentDeal.addError(Label.DuplicateDealError);
                }
            }
        }
    }

}