@isTest
private class DealTriggerHandlerTest {
    @isTest 
    private static void beforeInsert_positiveTest() {
        List<Deal__c> dealsFromDataFactory = TestDataFactory.createDeals(5);

        Test.startTest();
        insert dealsFromDataFactory;
        Test.stopTest();

        List<Deal__c> dealList = [SELECT Name FROM Deal__c];
        System.assertEquals(5, dealList.size(), 'DealTriggerHandler.preventDealDuplicate is working incorrectly');
    }

    @isTest
    private static void beforeInsert_negativeTest() {

        Sales_Manager__c salesManager = new Sales_Manager__c(Name = 'TestName');
        insert salesManager;

        Car__c car = new Car__c(Name = 'TestName', Is_Valid_For_Rent__c = true);
        insert car;

        DateTime startDate = DateTime.newInstance(2021, 08, 06, 3, 3, 3);
        DateTime endDate = DateTime.newInstance(2021, 12, 09, 3, 3, 3);
        

        Deal__c deal = new Deal__c(Car__c = car.Id, Sales_Manager__c = salesManager.Id,
        Status__c = 'Open', Start_Date__c = startDate,
        End_Date__c = endDate);  
        insert deal;

        List<Deal__c> duplicateDeals = new List<Deal__c>();
        for(Integer i=0;i<100;i++){
            duplicateDeals.add(new Deal__c(Car__c = car.Id, Sales_Manager__c = salesManager.Id,
                                Status__c = 'Open', Start_Date__c = startDate,
                                End_Date__c = endDate));
        }

        Test.startTest();
        List<Database.SaveResult> result = Database.insert(duplicateDeals, false);
        DealTriggerHandler.preventDealDuplicate(deal);
        Test.stopTest();

        List<Deal__c> dealList = [SELECT Name FROM Deal__c];
        System.assertEquals(1, 
                            dealList.size(),
                            'DealTriggerHandler.preventDealDuplicate is working incorrectly');

        for (Database.SaveResult oneResult : result) {
            if(!oneResult.isSuccess()) {
                for (Database.Error oneError : oneResult.getErrors()) {
                    System.assertEquals('Duplicate Deal Error! Deal with fields such as Status, Car and Ent Time already exists. Please try again',
                                         oneError.getMessage());
                }   
            }
        }
    }
}
