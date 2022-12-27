({
    showErrorToast : function(component, event, helper) 
    {
        console.log('the method runs !! toast ready ');
        var toastEvent = $A.get("e.force:showToast");
    toastEvent.setParams({
        "mode" : "sticky",
        "title": "Error!",
        "type" : "error",
        "duration" : "40000",
        "message": "Failed to Complete .. Try again"
    });
    toastEvent.fire();
    }
})
