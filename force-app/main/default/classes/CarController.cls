public with sharing class CarController {
    @AuraEnabled
    public static List<Car__c> getCars() {
        return [SELECT Name, Type__c, Model__c, Brand__c FROM Car__c WHERE Is_Valid_For_Rent__c = true];
    }
}


