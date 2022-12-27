({
	doInit : function(component, event, helper) 
    {
		var action = component.get("c.onRefreshPage");
        action.setCallback(this,function(data){
            let draft = JSON.parse(data.getReturnValue());
            if(draft)
            {
                component.set("v.callpopup",true);
                
                component.find("input1").set("v.value",draft.Subject);
                component.find("input2").set("v.value",draft.Comments);
                component.find("input3").set("v.value",draft.ActivityDate);
                component.find("input4").set("v.value",draft.NextAction);
                component.find("input5").set("v.value",draft.DealPartner);
                
                //call clickinCall
                $A.enqueueAction(component.get("c.clickCall"));
            }
            var state = data.getState();
            if(state === "ERROR")
            {
                console.log("ERROR !! Draft --> "+data.getReturnValue());
            }
            else if(state === "SUCCESS")
            {
                console.log("SUCCESS !! Draft --> "+data.getReturnValue());
            }
            
        });
        $A.enqueueAction(action);
	},
    
    init : function(component, event, helper) {
		
	},
    
    clickCall : function(component, event, helper){
        component.set("v.callpopup",true);
        
        let intid = window.setInterval(             
            $A.getCallback(function() {
            console.log("time starts (getCallBack)");
            var draftobj = {
                Subject : component.find("input1").get("v.value"),
                Comments : component.find("input2").get("v.value"),
                ActivityDate : component.find("input3").get("v.value"),
                NextAction : component.find("input4").get("v.value"),
                DealPartner : component.find("input5").get("v.value")
            };
            
            console.log("obj subj before saving in draft--> ",draftobj.Subject);
            
            var action1 = component.get("c.saveDraft");
                if((!draftobj.Subject) && (!draftobj.Comments) && (!draftobj.ActivityDate) && (!draftobj.NextAction) && (!draftobj.DealPartner))
        {// if starts only true
            console.log("if after action runs (returns back from getCallback)");
            return;
        }
                else{
            action1.setParams({
                draftobject :JSON.stringify(draftobj)                   
            });
            action1.setCallback(this,function(data){
                var vals = JSON.parse(data.getReturnValue());
                var state=data.getState();
                if(state==="SUCCESS") // Saved and SUCCESS toast
                {
                    console.log("vdata returned --> ",data.getReturnValue());
                                     
                    // to show the message
                    component.set("v.message",true);
                    
                    //to cover the message
                    setTimeout(() => {
                        console.log(component.get("v.message"))
                        component.set("v.message",false);
                    }, 6000);
                }
                else // ERROR toast
                {
                    console.log("Error yo! (from setInterval)");
                    console.log("error returned --> ",data.getReturnValue());
                }
            });
            
            $A.enqueueAction(action1);
                }
            
        }) , 15000); //$a getCallback ends here ,  function of setinterval ends here , interval ends here
        
        component.set("v.intervalID",intid);
        console.log("id is -->> ",intid);
        
    },
    
    clickCancelCall : function(component,helper){
        console.log("clickCancelCall runs");
        component.set("v.showConfirm",true);
        
        /*console.log("call Cancelled");
            //clear vals before closing popup
        $A.enqueueAction(component.get('c.clearInputs'));
            
        component.set("v.callpopup",false);
        var action = component.get("c.deleteAllDrafts");
        $A.enqueueAction(action);
        clearInterval(component.get("v.intervalID"));
        console.log("id is in savepart --> ",component.get("v.intervalID"));*/
    },
    
    confirmYes : function(component, event, helper) {
        console.log('Confirming Yes');
        
        //confirmation dialogue closes
        component.set('v.showConfirm', false);
        
        //call closes
        console.log("call Cancelled");
            //clear vals before closing popup
        $A.enqueueAction(component.get('c.clearInputs'));
        component.set("v.callpopup",false);
        //to delete all drafts
        $A.enqueueAction(component.get("c.deleteAllDrafts"));
        clearInterval(component.get("v.intervalID"));
        console.log("id is in savepart --> ",component.get("v.intervalID"));
        
    },
     
    confirmNo : function(component, event, helper) {
        console.log('Confirming No');
        component.set('v.showConfirm', false);
    },
    
    onBlurSubject : function(component, event, helper){
        
        console.log("value 1 --> ",component.find("input1").get("v.value"));
    },
    
    onBlurComment : function(component, event, helper){
       
        console.log("value 2 --> ",component.find("input2").get("v.value"));  
    },
    
    onBlurDate : function(component, event, helper){
       
        console.log("value 3 --> ",component.find("input3").get("v.value"));
    },
    
    onBlurAction : function(component, event, helper){
        
        console.log("value 4 --> ",component.find("input4").get("v.value"));
    },
    
    onBlurDeal : function(component, event, helper){
        
        console.log("value 5 --> ",component.find("input5").get("v.value"));
    },
    
    doSave : function(component, event)
    {
            var obj = {
                Subject : component.find("input1").get("v.value"),
                Comments : component.find("input2").get("v.value"),
                ActivityDate : component.find("input3").get("v.value"),
                NextAction : component.find("input4").get("v.value"),
                DealPartner : component.find("input5").get("v.value")
            };
            var action1 = component.get("c.onSavingInputs");
            action1.setParams({
                saveobj :JSON.stringify(obj)
            });
            action1.setCallback(this,function(data){
                var state=data.getState();
                if(state==="SUCCESS")
                {
                    console.log("saved Values => ",data.getReturnValue());
                    
                    //to show toast 
                    var tst = $A.get("e.force:showToast");
                    tst.setParams({
                        message : 'Task Record Saved !!',
                        type:'SUCCESS',
                        mode : 'dismissible'
                    });
                    tst.fire();
                }
               
            });
            $A.enqueueAction(action1);
            
            //clear inputs
            $A.enqueueAction(component.get('c.clearInputs'));
            
            //delete draft 
            //var action = component.get("c.deleteAllDrafts");
            $A.enqueueAction(component.get("c.deleteAllDrafts"));
            
            component.set("v.callpopup",false);
            
            clearInterval(component.get("v.intervalID"));
            console.log("id is in savepart --> ",component.get("v.intervalID"));
       
    },
                
    clearInputs : function (component)
                {
                    //to set values to empty
                component.find("input1").set("v.value","");
                component.find("input2").set("v.value","");
                component.find("input3").set("v.value","");
                component.find("input4").set("v.value","");
                component.find("input5").set("v.value","");
                },
    
    handleChange: function (cmp, event, helper) {
        //Do something with the change handler
        alert(event.getParam('value'));
    }
})