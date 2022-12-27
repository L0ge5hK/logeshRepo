({
    draftSubject : "",
    	draftPriority : "",
    	draftStatus : "",
    
    draftVariables : function()
    {
        console.log('draft variables are --> '+draftSubject+' -- '+draftPriority+' -- '+draftPriority);
    },

saveOnTimer : function(component, event, helper) 
    {
    var obj = {
            Subject : component.find("Subject").get("v.value"),
            Priority : component.find("Priority").get("v.value"),
            Status : component.find("Status").get("v.value"),
            recordId:component.get('v.recordId')
        };
        var action1 = component.get("c.getTaskRecord");
        action1.setParams({
            wr :JSON.stringify(obj)
        });
        action1.setCallback(this,function(data){
            var state=data.getState();
            if(state==="SUCCESS"){
               var tst = $A.get("e.force:showToast");
                tst.setParams({
                     message : 'Task Save Successfully',
                    type:'SUCCESS',
                    mode : 'dismissible'
                });
                tst.fire();
            }
            else
            {
                var tst = $A.get("e.force:showToast");
                tst.setParams({
                     message : 'SetInterval did not work',
                    type:'ERROR',
                    mode : 'dismissible'
                });
                tst.fire();
            }
        });
        $A.enqueueAction(action1);
      }
})