public class CarTriggerHandler {
    public static void updateOpenDeal(List<Car__c> newCarFromTrigger, Map<Id, Car__c> oldCarMapFromTrigger){
        Set<Id> carFromTriggerIdSet = new Set<Id>();
        for(Car__c currentCar: newCarFromTrigger){
            if(!currentCar.Is_Valid_For_Rent__c 
            && currentCar.Is_Valid_For_Rent__c != oldCarMapFromTrigger.get(currentCar.Id).Is_Valid_For_Rent__c){
                carFromTriggerIdSet.add(currentCar.Id);
            }
        }
        List<Deal__c> relatedDeals = [SELECT Name, Car__c, Status__c FROM Deal__c
                                    WHERE Car__c IN :carFromTriggerIdSet AND Status__c = 'Open'];
        for(Deal__c currentDeal: relatedDeals){

            currentDeal.Status__c = 'Lost';
        }
           update relatedDeals;
    }
 }