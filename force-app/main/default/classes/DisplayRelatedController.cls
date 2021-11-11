public class DisplayRelatedController {
    //Below method will return list of brands [COPYRIGHTS : SalesforceKid (www.salesforcekid.com)]
     @AuraEnabled
     public static List<Brand__c> getBrand(){
         List<Brand__c> proplist = [Select Id, Name FROM Brand__c];
         return proplist;   
     }
     //Below method will retun list of models [COPYRIGHTS : SalesforceKid (www.salesforcekid.com)]   
    @AuraEnabled
     public static List<Car__c> getModel(String propId)
     {
      List<Car__c> unitList =[Select Id, Name,Brand__c FROM Car__c where Brand__c =: propId];
         return unitList;
     }
     //Below method will return pictures based on Objects [COPYRIGHTS : SalesforceKid (www.salesforcekid.com)]
     @AuraEnabled
     public static List<ContentVersion> getContents(string brandId, string ObjectName) {
         Set<Id> contentIds = new Set<Id>();
         if(ObjectName == 'Brand__c')
         {
             //SOQL query to get pictures from Brand object [COPYRIGHTS : SalesforceKid (www.salesforcekid.com)]
             for (ContentDocumentLink cont :[SELECT ContentDocumentId, LinkedEntityId FROM ContentDocumentLink where LinkedEntityId in ( SELECT Id FROM Brand__c where Id =: brandId) and LinkedEntity.Type=:ObjectName]) {
                 contentIds.add(cont.ContentDocumentId);
             }
         }
          else
         {
             //SOQL query to get pictures from Model Object [COPYRIGHTS : SalesforceKid (www.salesforcekid.com)]
  for (ContentDocumentLink cont :[SELECT ContentDocumentId, LinkedEntityId FROM ContentDocumentLink where LinkedEntityId in ( SELECT Id FROM Car__c where Id =: brandId) and LinkedEntity.Type=:ObjectName]) 
             {
                 contentIds.add(cont.ContentDocumentId);   
             }
         }
         //Below Query will return the latest image Id uploaded in files [COPYRIGHTS : SalesforceKid (www.salesforcekid.com)]
 return [SELECT Id,Title FROM ContentVersion WHERE ContentDocumentId IN :contentIds LIMIT 1];
     }
 }