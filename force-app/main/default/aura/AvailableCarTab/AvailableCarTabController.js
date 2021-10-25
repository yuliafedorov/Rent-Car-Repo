({
    init: function (cmp, event, helper) {
         cmp.set('v.columnsCar', [
             { label: 'Car', fieldName: 'Name', type: 'text'},
             { label: 'Type', fieldName: 'Type__c', type: 'text'},
             { label: 'Model', fieldName: 'Model__c', type: 'text'}
         ]);
         helper.getData(cmp);
     }
 })
 