@isTest
private class CarRentServicesTest {

    @isTest 
    private static void getWonDealsTest() {
        DateTime startOfRange = DateTime.newInstance(2087, 08, 06, 3, 3, 3);
        DateTime endOfRange = DateTime.newInstance(2089, 12, 09, 3, 3, 3);
        DateTime startDate = DateTime.newInstance(2088, 08, 06, 3, 3, 6);
        DateTime endDate = DateTime.newInstance(2088, 12, 09, 3, 3, 3);

        List<Deal__c> deals = new List<Deal__c>();
        deals.add(new Deal__c(Start_Date__c = startDate, End_Date__c = endDate,
        Status__c = 'Won', Car__c = 'a010900001b4ptEAAQ', Sales_Manager__c = 'a000900000HhePvAAJ'));
        insert deals;

        Test.startTest();
        List<Deal__c> d =  CarRentServices.getWonDeals(startOfRange, endOfRange);
        Test.stopTest();
        
        System.assertEquals(startDate, deals[0].Start_Date__c, 'Start date not correct');
        System.assertEquals(endDate, deals[0].End_Date__c, 'End date not correct');
    }
}
