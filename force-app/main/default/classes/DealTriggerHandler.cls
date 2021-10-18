public  class DealTriggerHandler {

    public static void preventDealDuplicate(List<Deal__c> dealFromTrigger) {
        List<Deal__c> dealList = [SELECT Name, Car__c, Status__c, End_Date__c, Start_Date__c 
                                FROM Deal__c WHERE Status__c = 'Open'
                                OR Status__c = 'Won'];
        for(Deal__c currentDeal: dealFromTrigger) {
            for(Integer i = 0; i < dealList.size(); i++){
                if (currentDeal.Car__c == dealList[i].Car__c 
                && currentDeal.Status__c == dealList[i].Status__c 
                && currentDeal.Start_Date__c == dealList[i].Start_Date__c
                && currentDeal.End_Date__c == dealList[i].End_Date__c){
                    currentDeal.addError(Label.DuplicateDealError);
                }
            }
        }
    }

    public static void chengeStatusField(List<Deal__c> dealFromTrigger){
        Set<Id> dealIdSet = new Set<Id>();
        for(Deal__c currentDeal: dealFromTrigger){ 
            dealIdSet.add(currentDeal.Car__c);
        }
        List<Car__c> carList = [SELECT Name FROM Car__c WHERE Id IN :dealIdSet
                                AND Is_Valid_For_Rent__c = false];
        Map<Id,Car__c> carMap = new Map<Id,Car__c>(carList);
        for(Deal__c currentDeal: dealFromTrigger){
            if(carMap.containsKey(currentDeal.Car__c)){
                currentDeal.Status__c = 'Lost';
            }
        }
    }
}