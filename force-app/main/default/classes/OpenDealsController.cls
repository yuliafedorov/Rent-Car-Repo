public with sharing class OpenDealsController {
    @AuraEnabled(cacheable=true)
    public static List<Deal__c> returnOpenDeals(Id salesManagerId) {
        return [SELECT Name, Car_Name__c, Sales_Manager__c, Start_Date__c, End_Date__c
               FROM Deal__c WHERE Status__c = 'Open' AND Sales_Manager__c =: salesManagerId
               WITH SECURITY_ENFORCED];
    }
}