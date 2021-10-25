public class TestPost {

    public static HttpResponse getAccountCallout(Id salesManagerId){
        Sales_Manager__c salesManager = [SELECT Name, Birth_Date__c, Email__c, Is_Synced__c
                                        FROM Sales_Manager__c WHERE Id = :salesManagerId];
    
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
        
        return response;
        }
}
