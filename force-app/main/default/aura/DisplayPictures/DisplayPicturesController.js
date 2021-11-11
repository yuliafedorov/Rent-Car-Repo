({
    doInit : function(cmp){
 //Below line will call getContents method from controller [COPYRIGHTS : SalesforceKid (www.salesforcekid.com)]
        var action = cmp.get("c.getContents");
          //Below v.pictureList is list recieved from first component [COPYRIGHTS : SalesforceKid (www.salesforcekid.com)]
          var picId = cmp.get("v.pictureList");
          var sObjectName = cmp.get("v.sObjectName");
 //Below line will set the brandId and SObject name to pass as a parameter to the method [COPYRIGHTS : SalesforceKid (www.salesforcekid.com)]
          action.setParams({
              brandId : picId.Id,
              ObjectName : sObjectName
          })  
        action.setCallback(this, function(response) {
            var state = response.getState();
            if(cmp.isValid() && state === 'SUCCESS') {
 //If the response is success then below line will set that list to "v.contents" list [COPYRIGHTS : SalesforceKid (www.salesforcekid.com)]
                cmp.set("v.contents", response.getReturnValue()); 
            }
        });
         $A.enqueueAction(action);
     },
     
 
 })