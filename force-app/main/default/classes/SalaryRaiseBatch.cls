public with sharing class SalaryRaiseBatch implements Database.Batchable<sObject>, Schedulable {

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT Name, Birth_Date__c, Email__c,' +
        	'Is_Synced__c, Salary__c, LastRaiseDate__c FROM Sales_Manager__c');
    }

    public void execute(Database.BatchableContext bc, List<Sales_Manager__c> scope){

        Map<Id,Sales_Manager__c> salesManagerMap = new Map<Id,Sales_Manager__c>(scope);
        List<Deal__c> deals = [SELECT Name, Sales_Manager__c FROM Deal__c
                            WHERE Status__c = 'Won' AND Is_needed_to_handle__c = true
                            AND Sales_Manager__c IN :scope];
                            
        for(Deal__c currentDeal: deals){
            if(salesManagerMap.containsKey(currentDeal.Sales_Manager__c)){
                Sales_Manager__c currentSalesManager = salesManagerMap.get(currentDeal.Sales_Manager__c);
                if(math.abs(system.today().monthsBetween(currentSalesManager.LastRaiseDate__c)) == 6){
                    currentSalesManager.Salary__c += 10; 
                    currentDeal.Is_needed_to_handle__c = false;
                }
            }
        }
        update scope;
        update deals;
    }

    public void finish(Database.BatchableContext bc){
        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed,
                          TotalJobItems, CreatedBy.Email
                          FROM AsyncApexJob WHERE Id =
                          :BC.getJobId()];
		Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
		String[] toAddresses = new String[] {'fedorovayulia150@gmail.com'};
        mail.setToAddresses(toAddresses);
        mail.setSubject('Th Batch Apex job' + job.Status);
        mail.setPlainTextBody
        ('All Sales Manager records have been processed. The batch Apex job processed ' + job.TotalJobItems +
        ' batches with '+ job.NumberOfErrors + ' failures.');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail }); 

    }

    public void execute(SchedulableContext sc){
    	Database.executeBatch(this);
	}
}