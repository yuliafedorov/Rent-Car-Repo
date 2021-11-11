({
    doInit : function(component, event, helper) {
//Call Server Side Controller method c.getBrand [COPYRIGHTS : SalesforceKid (www.salesforcekid.com)]
        var action = component.get("c.getBrand");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var finalBrandList = response.getReturnValue();  
//set the total brands available and set to brandList [COPYRIGHTS : SalesforceKid (www.salesforcekid.com)]
                component.set("v.brandList",finalBrandList);  
            }
        });
        $A.enqueueAction(action);  
    },

    onPictureClick: function(component, event, helper) {
//get the user onclick event and the selected record id [COPYRIGHTS : SalesforceKid (www.salesforcekid.com)]
        var createRecordEvent = $A.get("e.force:onPictureClick");
        var selectedRecord = event.currentTarget;
        var propId =  selectedRecord.getAttribute("title");
        var action = component.get("c.getModel");
//Set the selected Id and pass to server side controller as a parameter [COPYRIGHTS : SalesforceKid (www.salesforcekid.com)]
        action.setParams({
            propId : propId
        })
         action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var finalModelList = response.getReturnValue();
                component.set("v.modelList", finalModelList); 
//set first screen false and second screen on to display related moodels on second screen [COPYRIGHTS : SalesforceKid (www.salesforcekid.com)]
                 component.set("v.isFirst", false); 
                 component.set("v.isSecond", true);
            }
        });
        $A.enqueueAction(action);
    },
    
    backClick : function(component, event, helper) {
        component.set("v.isFirst", true); 
        component.set("v.isSecond", false);
    }
})