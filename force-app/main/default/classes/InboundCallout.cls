@RestResource(urlMapping = '/Sales_Manager__c/*')
global with sharing class InboundCallout {
   @HttpGet
   global static List<Sales_Manager__c> doGet(){
      return [SELECT Name FROM Sales_Manager__c ORDER BY Birth_Date__c ASC LIMIT 5];
   }
}
