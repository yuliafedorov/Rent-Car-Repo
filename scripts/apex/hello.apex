// Use .apex files to store anonymous Apex.
// You can execute anonymous Apex in VS Code by selecting the
//     apex text and running the command:
//     SFDX: Execute Anonymous Apex with Currently Selected Text
// You can also execute the entire file by running the command:
//     SFDX: Execute Anonymous Apex with Editor Contents
////SOQL
// //1
// DateTime startDate = DateTime.newInstance(2021, 08, 06, 3, 3, 3);
// DateTime endDate = DateTime.newInstance(2021, 12, 09, 3, 3, 3);
// System.debug(CarRentServices.getWonDeals(startDate, endDate));
// //2
// Set<Id> salesManagerIds = new Set<Id>{'a000900000Hh1ffAAB', 'a000900000HhZhGAAV'};
// System.debug(CarRentServices.getWonDealsBySalesManagerIds(salesManagerIds));
// //3
// Date rentStart = Date.newInstance(2021, 08, 06);
// Date rentEnd = Date.newInstance(2021, 12, 09);
// System.debug(CarRentServices.getCarsAvailableForRent(rentStart, rentEnd));
// //4
// System.debug(CarRentServices.getCarRentStatistic());
// //5
// System.debug(CarRentServices.getTopRatedSalesRepOfYear(5555));
//////////////////////////////DML
// //1
// Date birthDate = Date.newInstance(2021, 08, 06);
// CarRentServices.createSalesManager('Vlad', birthDate);
// //2
// DateTime startDate = DateTime.newInstance(2021, 08, 06, 3, 3, 3);
// DateTime endDate = DateTime.newInstance(2021, 12, 09, 3, 3, 3);
// CarRentServices.createNewDeal(startDate, endDate, 'a000900000HhaHaAAJ', 'a010900001YQLpLAAX' );
//  //3
// Map<String, Object> fieldNameToValue = new Map<String, Object>();
// fieldNameToValue.put('Status__c', 'Won');
// DateTime endDate = DateTime.newInstance(3033, 12, 09, 3, 3, 3);
// fieldNameToValue.put('End_Date__c', endDate);
// CarRentServices.updateDeal('a0209000009rkT9AAI', fieldNameToValue);
// //4
// Id carId = 'a010900001WlXSKAA3';
// CarRentServices.deactivateCar(carId);

// List<Deal__c> deals = [SELECT Sales_Manager__c FROM Deal__c WHERE Status__c = 'Won' ];
//         Map<String,Id> dealMap = new  Map<String,Id>();
//         for(Deal__c currentDeal: deals){
//             dealMap.put(currentDeal.Sales_Manager__c, currentDeal.Id);
//         }
//         System.debug(dealMap);

// List<Sales_Manager__c> oldestSalesManagerList = [SELECT Name FROM Sales_Manager__c
//                                                      ORDER BY Birth_Date__c ASC LIMIT 2];
// System.debug(oldestSalesManagerList);

