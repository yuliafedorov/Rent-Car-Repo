public class CarTriggerHandler {
    public static void updateOpenDeal(List<Car__c> carFromTrigger){
        Set<Id> carFromTriggerIdSet = new Set<Id>();
        for(Car__c currentCar: carFromTrigger){
            if(currentCar.Is_Valid_For_Rent__c == false){
                carFromTriggerIdSet.add(currentCar.Id);
            }
        }
        List<Deal__c> relatedDeals = [SELECT Name, Car__c, Status__c FROM Deal__c
                                    WHERE Car__c IN :carFromTriggerIdSet AND Status__c = 'Open'];
        List<Deal__c> closedDeals = new List<Deal__c>();
        for(Deal__c currentDeal: relatedDeals){
            currentDeal.Status__c = 'Lost';
            closedDeals.add(currentDeal);
        }
        if(closedDeals.size()>0){
           update closedDeals;
        }
    }
 }