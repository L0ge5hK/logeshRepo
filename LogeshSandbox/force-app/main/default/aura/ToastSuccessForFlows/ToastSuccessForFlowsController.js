({
    showSuccessToast : function() 
    {
        console.log('the method runs !! toast ready ');
        var toastEvent = $A.get("e.force:showToast");
    toastEvent.setParams({
        "mode" : "sticky",
        "title": "Success!",
        "type" : "success",
        "duration" : "40000",
        "message": "Completed Successfully"
    });
    toastEvent.fire();
    }
})