public class CarRentServices {

    //Homework for Apex
    
    public static void setEndDate(List<Deal__c> deals) {
        List<Deal__c> newDealList = new List<Deal__c>();
        for(Deal__c currentDeal: deals){
            currentDeal.End_Date__c = Date.today();
            newDealList.add(currentDeal);
        }
        update newDealList;
    }

    public static List<Deal__c> fillterFinished(List<Deal__c> deals, String status) {
        List<Deal__c> newDealList = new List<Deal__c>();
        for(Deal__c currentDeal: deals){
            if(currentDeal.Status__c == status){
                newDealList.add(currentDeal);
            }
        }
        return newDealList;
    }

    //Homework for SOQL SOSL

    public static List<Deal__c> getWonDeals(DateTime startDate, DateTime endDate){
        return [SELECT Name, Start_Date__c, End_Date__c, Status__c
            FROM Deal__c
            WHERE Status__c = 'Won'
            AND Start_Date__c > :startDate
            AND End_Date__c < :endDate];
    }

    public static Map<Id, Integer> getWonDealsBySalesManagerIds(Set<Id> salesManagerIds){
        Map<Id,Integer> resultMap = new Map<Id,Integer>();
        List<AggregateResult> groupedResults = [SELECT Sales_Manager__c, COUNT(Id)
                                                FROM Deal__c
                                                WHERE Status__c = 'Won'
                                                AND Sales_Manager__c IN :salesManagerIds
                                                GROUP BY Sales_Manager__c];
        for(AggregateResult currentAggregateResult: groupedResults){
            Id idSalesManager = (Id) currentAggregateResult.get('Sales_Manager__c');
            Integer countWonDeals = (Integer) currentAggregateResult.get('expr0');
            resultMap.put(idSalesManager, countWonDeals);
         }
        return resultMap;
    }

    public static List<Car__c> getCarsAvailableForRent(Date rentStart, Date rentEnd){
        return [SELECT Name
                FROM Car__c
                WHERE Id IN (SELECT Car__c
                            FROM  Deal__c 
                            WHERE Status__c = 'Open'
                            AND Start_Date__c > :rentStart
                            AND End_Date__c < :rentEnd)];
    }

    public static Map<Id, Integer> getCarRentStatistic(){
        Map<Id,Integer> resultMap = new Map<Id,Integer>();
        List<AggregateResult> groupedResults = [SELECT Car__c, COUNT(Id)
                                                FROM Deal__c
                                                WHERE Status__c = 'Won'
                                                GROUP BY Car__c];
        for(AggregateResult currentAggregateResult: groupedResults){
            Id carId = (Id) currentAggregateResult.get('Car__c');
            Integer countRentedCar = (Integer) currentAggregateResult.get('expr0');
            resultMap.put(carId, countRentedCar);
        }    
        return resultMap;
    }

    public static Id getTopRatedSalesRepOfYear(Integer year1){
        AggregateResult[] groupedResults = [SELECT Sales_Manager__c, COUNT(Id)
                                                FROM Deal__c 
                                                WHERE Status__c = 'Won'
                                                AND CALENDAR_YEAR(End_Date__c) = :year1
                                                GROUP BY Sales_Manager__c
                                                ORDER BY COUNT(Name) DESC
                                                LIMIT 1];
        if(groupedResults.isEmpty()){
            return null;
        }  
        return (Id) groupedResults[0].get('Sales_Manager__c');                                                                     
    }

    //Homework for DML
    
    public static Database.SaveResult createSalesManager(String name, Date birthdate){
        Sales_Manager__c newSalesManager = new Sales_Manager__c(Name = name, Birth_Date__c = birthdate);
        Database.SaveResult insertedSalesManager = Database.insert(newSalesManager, false);
        return insertedSalesManager;        
    }

    public static void createNewDeal(DateTime startDate, DateTime endDate, Id salesRepId, Id carId){
        Deal__c newDeal = new Deal__c(Car__c = carId, Sales_Manager__c = salesRepId,
        Start_Date__c = startDate, End_Date__c = endDate);
        insert newDeal;
    }

    public static Database.SaveResult updateDeal(Id dealId, Map<String, Object> fieldNameToValue){
        Deal__c dealForUpdate = [SELECT Name, Status__c FROM Deal__c WHERE Id = :dealId LIMIT 1];
        for(String key: fieldNameToValue.keySet()){
            dealForUpdate.put(key, fieldNameToValue.get(key));
        }
        Database.SaveResult updatedDeal = Database.update(dealForUpdate, false);
        return updatedDeal;
    }

    public static void deactivateCar(Id carId){
        List<Deal__c> newRelatedDealList = new List<Deal__c>();
        Car__c brokenCar = [SELECT Name, Is_Valid_For_Rent__c FROM Car__c
                            WHERE Id = :carId LIMIT 1];
        List<Deal__c> relatedDealList = [SELECT Name, Car__c, Status__c 
                                        FROM Deal__c WHERE Car__c = :carId AND Status__c = 'Open'];
        for(Deal__c currentDeal: relatedDealList){
            currentDeal.Status__c = 'Lost';
        }
        update relatedDealList;
        brokenCar.Is_Valid_For_Rent__c = false;
        update brokenCar;
    }
}