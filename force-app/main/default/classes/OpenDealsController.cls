public with sharing class OpenDealsController {

    @AuraEnabled(cacheable=true)
    public static List<Deal__c> returnOpenDeals(Id salesManagerId) {
        return [SELECT Name, Car_Name__c, Sales_Manager__c, Start_Date__c, End_Date__c
               FROM Deal__c WHERE Status__c = 'Open' AND Sales_Manager__c =: salesManagerId];
    }

    @AuraEnabled
    public static void pushSalesManager(Id salesManagerId){

        Sales_Manager__c salesManager = [SELECT Name, Birth_Date__c, Email__c, Is_Synced__c
                                        FROM Sales_Manager__c WHERE Id = :salesManagerId LIMIT 1];
    
        Http myhttp = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://avenga-school.herokuapp.com/push-data');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json');
    
        JSONGenerator generator =JSON.createGenerator(false);
        generator.writeStartObject();
        generator.writeStringField('name', salesManager.Name);
        generator.writeDateField('birth date', salesManager.Birth_Date__c);
        generator.writeStringField('email', salesManager.Email__c);
        generator.writeBooleanField('is synced', salesManager.Is_Synced__c);
        generator.writeEndObject();
        request.setBody(generator.getAsString());
    
        HttpResponse response = myhttp.send(request);
        if(response.getStatusCode() == 200){
            salesManager.Is_Synced__c = true;
            update salesManager;
        }   
    }
}