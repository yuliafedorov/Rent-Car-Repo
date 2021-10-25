@isTest
private class CarRentServicesTest {
    @TestSetup
    static void makeData(){
        
        List<Sales_Manager__c> salesManager = new List<Sales_Manager__c>();
        salesManager.add(new Sales_Manager__c(Name = 'Sales Manager Test'));
        insert salesManager;

        List<Car__c> car = new List<Car__c>();
        for(Integer i=0; i<10; i++){
            car.add(new Car__c(Name = 'TestName' + i, Is_Valid_For_Rent__c = true));
        }
        insert car;

        DateTime startDate = DateTime.newInstance(2021, 08, 06, 3, 3, 3);
        DateTime endDate = DateTime.newInstance(2021, 12, 09, 3, 3, 3);
        
        
        List<Deal__c> deals = new List<Deal__c>();
            for(Integer i=0; i<200; i++){
                deals.add(new Deal__c(Car__c = car[0].Id, Sales_Manager__c = salesManager[0].Id,
                                    Status__c = 'Won', Start_Date__c = startDate.addMinutes(i),
                                    End_Date__c = endDate.addMinutes(i)));
            }
        insert deals;
    }

    @isTest 
    private static void getWonDealsTest() {

        DateTime startOfRange = DateTime.newInstance(2021, 08, 06, 3, 3, 2);
        DateTime endOfRange = DateTime.newInstance(2021, 12, 10, 3, 3, 3);

        Test.startTest();
        List<Deal__c> d =  CarRentServices.getWonDeals(startOfRange, endOfRange);
        Test.stopTest();

        System.assertEquals(200, 
                            d.size(),
                            'CarRentServices.getWonDeals is working incorrectly');
    }

    @isTest 
    private static void getWonDealsBySalesManagerIdsTest() {

        List<Sales_Manager__c> salesManager = [SELECT Name FROM Sales_Manager__c];

        DateTime startDate = DateTime.newInstance(2021, 08, 06, 3, 3, 3);
        DateTime endDate = DateTime.newInstance(2021, 12, 09, 3, 3, 3);

        Set<Id> salesManagerIds = new Set<Id>();
        salesManagerIds.add(salesManager[0].Id);

        Test.startTest();
        Map<Id, Integer> d = CarRentServices.getWonDealsBySalesManagerIds(salesManagerIds);
        Test.stopTest();

        System.assertEquals(200,
                            d.get(salesManager[0].Id),
                            'CarRentServices.getWonDealsBySalesManagerIds is working incorrectly');
    }

    @isTest 
    private static void getCarsAvailableForRentTest() {
        List<Car__c> cars = [SELECT Name FROM Car__c];
       
        List<Sales_Manager__c> salesManager = [SELECT Name FROM Sales_Manager__c];

        DateTime startDate = DateTime.newInstance(2021, 08, 06, 3, 3, 3);
        DateTime endDate = DateTime.newInstance(2021, 12, 09, 3, 3, 3);

        Date startOfRange = Date.newInstance(2021, 08, 06);
        Date endOfRange = Date.newInstance(2021, 12, 10);

        List<Deal__c> deals = new List<Deal__c>();
        for(Car__c currentCar: cars){
            for(Integer i=0; i<3; i++){
                deals.add(new Deal__c(Car__c = currentCar.Id, Sales_Manager__c = salesManager[0].Id,
                                Status__c = 'Open', Start_Date__c = startDate.addMinutes(i),
                                End_Date__c = endDate));
            }
        }
        insert deals;

        Test.startTest();
        List<Car__c> d =  CarRentServices.getCarsAvailableForRent(startOfRange, endOfRange);
        Test.stopTest();

        
        System.assertEquals(10,
                            d.size(),
                            'CarRentServices.getCarsAvailableForRent is working incorrectly');
    }

    @isTest 
    private static void getCarRentStatisticTest() {

        List<Car__c> car = [SELECT Name FROM Car__c];

        Test.startTest();
        Map<Id, Integer> d = CarRentServices.getCarRentStatistic();
        Test.stopTest();

        System.assertEquals(200,
                            d.get(car[0].Id),
                            'CarRentServices.getCarRentStatistic is working incorrectly');

    }

    @isTest 
    private static void getTopRatedSalesRepOfYearTest_positiveTest() {
        List<Car__c> car = [SELECT Name FROM Car__c];
        
        Sales_Manager__c loser = new Sales_Manager__c(Name = 'Loser Sales Manager Test');
        insert loser;
        Sales_Manager__c winner = new Sales_Manager__c(Name = 'Winner Sales Manager Test');
        insert winner;

        DateTime startDate = DateTime.newInstance(2021, 08, 06, 3, 3, 3);
        DateTime endDate = DateTime.newInstance(2021, 12, 09, 3, 3, 3);

        List<Deal__c> deals = new List<Deal__c>();
        for(Integer i=0; i<200; i++){
             deals.add(new Deal__c(Car__c = car[0].Id, Sales_Manager__c = winner.Id,
                                    Status__c = 'Won', Start_Date__c = startDate,
                                    End_Date__c = endDate));
            }
        insert deals;

        Test.startTest();
        Id topRatedSalesRepOfYear = CarRentServices.getTopRatedSalesRepOfYear(2021);
        Test.stopTest();

        List<Deal__c> wonDeals = [SELECT Name FROM Deal__c 
                                WHERE Sales_Manager__c = :topRatedSalesRepOfYear];

        System.assertEquals(200,
                            wonDeals.size(),
                            'CarRentServices.getTopRatedSalesRepOfYear is working incorrectly');
        System.assertEquals(winner.Id, topRatedSalesRepOfYear,
                            'CarRentServices.getTopRatedSalesRepOfYear is working incorrectly');
    }
}
