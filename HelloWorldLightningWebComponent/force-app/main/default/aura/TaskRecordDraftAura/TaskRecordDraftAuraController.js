({		
    doInit : function(component, event, helper)
    {
        component.find("Subject").set("v.value",helper.draftSubject);
            component.find("Priority").set("v.value",helper.draftPriority);
            component.find("Status").set("v.value",helper.draftStatus);
    },
    
	clickCall : function(component, event, helper){
            component.set("v.callpopup",true);
        window.setInterval(
            $A.getCallback(function() {
                helper.saveOnTimer(component,event,helper);
            }), 10000
        );
        
	},
    clickMeeting : function(component, event, helper){
		component.set("v.meetingpopup",true);
        
	},
    clickCancelCall : function(component, event, helper){
        component.set("v.callpopup",false);
        clearInterval(myinterval);
    },
    clickCancelMeeting : function(component, event, helper){
        component.set("v.meetingpopup",false);
    },
    
    dosubject :
        
        function (component, event, helper)
        {
            if(component.find("stat").get("v.value"))
            {
            helper.draftSubject = component.find("subj").get("v.value");
            console.log("value : ==>  "+helper.draftSubject);
            }
   
        },
    
    dopriority :
        
        function (component, event, helper)
        {
            if(component.find("stat").get("v.value"))
            {
            helper.draftPriority = component.find("pri").get("v.value");
            console.log("value : ==>  "+helper.draftPriority);
            }
        },
    
    dostatus :
        
        function (component, event, helper)
        {
            if(component.find("stat").get("v.value"))
            {
            helper.draftStatus = component.find("stat").get("v.value");
            console.log("value : ==>  "+helper.draftStatus);
        	}
        },
    
    doSave : function (component, event, helper)
        {
			let inputobject = {
            	Subject : component.find("subj").get("v.value"),
            	Priority : component.find("pri").get("v.value"),
            	Status : component.find("stat").get("v.value"),
            	accountrecordId : component.get('v.recordId')
        	};
        var action = component.get("c.getObject");
        
            action.setParams({obj : JSON.stringify(inputobject)});
            
        action.setCallback(this,function(response){
            var state = response.getState();
            
            if(state === "SUCCESS")
            {
                var tst = $A.get("e.force:showToast");
                tst.setParams({
                     message : 'Task Record Inserted',
                    type : 'SUCCESS',
                    Duration : 5000,
                    mode : 'dismissible'
                });
                tst.fire();
            }
            else
            {
                var tst = $A.get("e.force:showToast");
                tst.setParams({
                    message : 'Error :Record Not Inserted',
                    type : 'ERROR',
                    Duration : 5000,
                    mode : 'dismissible'
                });
                tst.fire();
            }
        })
        $A.enqueueAction(action);
      }
   
        
        //var myinterval = setInterval(insertTaskRecord(),10000);
              
})