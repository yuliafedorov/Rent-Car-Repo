@isTest
public class TestDataFactory {
    public static List<Deal__c> createDeals(Integer numDeals){

        Sales_Manager__c salesManager = new Sales_Manager__c(Name = 'TestName');
        insert salesManager;

        Car__c car = new Car__c(Name = 'TestName', Is_Valid_For_Rent__c = true);
        insert car;

        List<Deal__c> deals = new List<Deal__c>();
        DateTime startDate = DateTime.newInstance(2021, 08, 06, 3, 3, 3);
        DateTime endDate = DateTime.newInstance(2021, 12, 09, 3, 3, 3);
        
        for(Integer i=0; i<numDeals; i++){
            deals.add(new Deal__c(Car__c = car.Id, Sales_Manager__c = salesManager.Id,
                                Status__c = 'Open', Start_Date__c = startDate.addMinutes(i+1),
                                End_Date__c = endDate.addMinutes(i+1)));
        }
        return deals;
    }
}
