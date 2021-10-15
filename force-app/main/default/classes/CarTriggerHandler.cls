public class CarTriggerHandler {
//     public static void updateOpenDeal(List<Car__c> carFromTrigger){
//         Set<Id> carIdSet = new Set<Id>();
//         for(Car__c currentCar: carFromTrigger){
//             if(currentCar.Is_Valid_For_Rent__c == false){
//                 carIdSet.add(currentCar.Id);
//             }
//         }
//         List<Deal__c> dealList = [SELECT Name, Car__c, Status__c FROM Deal__c WHERE Car__c IN :carIdSet];
//       //  Map<Id, Deal__c> dealMap = new Map<Id, Deal__c>(dealList);
//         List<Deal__c> newDeals = new List<Deal__c>();


//         for(Car__c currentCar: carFromTrigger){
//             for(Deal__c currentDeal: dealList){
//                 if(currentCar.Id == currentDeal.Car__c){
//                  //  Deal__c d = new Deal__c(Car__c = currentCar.Id);
//                  currentDeal.Status__c = 'Lost';
//                     newDeals.add(currentDeal);
//                 }
//             }
//             //  if(dealMap.containsKey(currentCar.Id)){
//             //     Deal__c relatedDeal = dealMap.get(currentCar.Id);
//             //         relatedDeal.Status__c = 'Lost';
//             //        newDeals.add(relatedDeal);
//             // // }
//         }
//         if(newDeals.size()>0){
//            update newDeals;
//         }
//     }
 }