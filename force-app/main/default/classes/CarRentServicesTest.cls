@isTest
private class CarRentServicesTest {

    @isTest 
    private static void getWonDealsTest() {

        Sales_Manager__c salesManager = new Sales_Manager__c(Name = 'TestName');
        insert salesManager;

        Car__c car = new Car__c(Name = 'TestName', Is_Valid_For_Rent__c = true);
        insert car;

        DateTime startDate = DateTime.newInstance(2021, 08, 06, 3, 3, 3);
        DateTime endDate = DateTime.newInstance(2021, 12, 09, 3, 3, 3);
        
        List<Deal__c> deals = new List<Deal__c>();
        for(Integer i=0; i<200; i++){
            deals.add(new Deal__c(Car__c = car.Id, Sales_Manager__c = salesManager.Id,
                                Status__c = 'Won', Start_Date__c = startDate.addMinutes(i),
                                End_Date__c = endDate));
        }
        insert deals;

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

        Car__c car = new Car__c(Name = 'TestName', Is_Valid_For_Rent__c = true);
        insert car;

        List<Sales_Manager__c> salesManager = new List<Sales_Manager__c>();
        salesManager.add(new Sales_Manager__c(Name = 'Sales Manager Test'));
        insert salesManager;

        Set<Id> salesManagerIds = new Set<Id>();
        salesManagerIds.add(salesManager[0].Id);

        DateTime startDate = DateTime.newInstance(2021, 08, 06, 3, 3, 3);
        DateTime endDate = DateTime.newInstance(2021, 12, 09, 3, 3, 3);

        List<Deal__c> deals = new List<Deal__c>();
            for(Integer i=0; i<200; i++){
                deals.add(new Deal__c(Car__c = car.Id, Sales_Manager__c = salesManager[0].Id,
                                    Status__c = 'Won', Start_Date__c = startDate.addMinutes(i),
                                    End_Date__c = endDate.addMinutes(i)));
            }
        insert deals;

        Test.startTest();
        Map<Id, Integer> d = CarRentServices.getWonDealsBySalesManagerIds(salesManagerIds);
        Test.stopTest();

        System.assertEquals(200,
                            d.get(salesManager[0].Id),
                            'CarRentServices.getWonDealsBySalesManagerIds is working incorrectly');
    }

    @isTest 
    private static void getCarsAvailableForRentTest() {
        List<Car__c> cars = new List<Car__c>();
        for(Integer i=0; i<10; i++){
            cars.add(new Car__c(Name = 'TestName' + i, Is_Valid_For_Rent__c = true));
        }
        insert cars;

        Sales_Manager__c salesManager = new Sales_Manager__c(Name = 'TestName');
        insert salesManager;

        DateTime startDate = DateTime.newInstance(2021, 08, 06, 3, 3, 3);
        DateTime endDate = DateTime.newInstance(2021, 12, 09, 3, 3, 3);

        Date startOfRange = Date.newInstance(2021, 08, 06);
        Date endOfRange = Date.newInstance(2021, 12, 10);

        List<Deal__c> deals = new List<Deal__c>();
        for(Car__c currentCar: cars){
            for(Integer i=0; i<3; i++){
                deals.add(new Deal__c(Car__c = currentCar.Id, Sales_Manager__c = salesManager.Id,
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
        Car__c car = new Car__c(Name = 'TestName', Is_Valid_For_Rent__c = true);
        insert car;

        Sales_Manager__c salesManager = new Sales_Manager__c(Name = 'TestName');
        insert salesManager;

        DateTime startDate = DateTime.newInstance(2021, 08, 06, 3, 3, 3);
        DateTime endDate = DateTime.newInstance(2021, 12, 09, 3, 3, 3);

        List<Deal__c> deals = new List<Deal__c>();
            for(Integer i=0; i<200; i++){
                deals.add(new Deal__c(Car__c = car.Id, Sales_Manager__c = salesManager.Id,
                                    Status__c = 'Won', Start_Date__c = startDate.addMinutes(i),
                                    End_Date__c = endDate.addMinutes(i)));
            }
        insert deals;

        Test.startTest();
        Map<Id, Integer> d = CarRentServices.getCarRentStatistic();
        Test.stopTest();

        
        System.assertEquals(200,
                            d.get(car.Id),
                            'CarRentServices.getCarRentStatistic is working incorrectly');

    }

    @isTest 
    private static void getTopRatedSalesRepOfYearTest_positiveTest() {
        Car__c car = new Car__c(Name = 'TestName', Is_Valid_For_Rent__c = true);
        insert car;

        Sales_Manager__c salesManager = new Sales_Manager__c(Name = 'TestName');
        insert salesManager;

        DateTime startDate = DateTime.newInstance(2021, 08, 06, 3, 3, 3);
        DateTime endDate = DateTime.newInstance(2021, 12, 09, 3, 3, 3);

        List<Deal__c> deals = new List<Deal__c>();
            for(Integer i=0; i<200; i++){
                deals.add(new Deal__c(Car__c = car.Id, Sales_Manager__c = salesManager.Id,
                                    Status__c = 'Won', Start_Date__c = startDate.addMinutes(i),
                                    End_Date__c = endDate.addMinutes(i)));
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
    }

    @isTest 
    private static void getTopRatedSalesRepOfYearnegativeTest() {
        Car__c car = new Car__c(Name = 'TestName', Is_Valid_For_Rent__c = true);
        insert car;

        Sales_Manager__c salesManager = new Sales_Manager__c(Name = 'TestName');
        insert salesManager;
       
        Test.startTest();
        Id topRatedSalesRepOfYear = CarRentServices.getTopRatedSalesRepOfYear(2021);
        Test.stopTest();
        List<Deal__c> wonDeals = [SELECT Name FROM Deal__c 
                                WHERE Sales_Manager__c = :topRatedSalesRepOfYear];

        System.assertEquals(true,
                            wonDeals.isEmpty(),
                            'CarRentServices.getTopRatedSalesRepOfYear is working incorrectly');
   
    }
}
