public with sharing class CarController {
    @AuraEnabled
    public static List<Car__c> getCars() {
        List<Car__c> cars =
                [SELECT Name, Type__c, Model__c FROM Car__c WHERE Is_Valid_For_Rent__c = true];
        return cars;
    }
}
