({
	DoInit : function(component, event, helper) {
        console.log("Internal Bulky Reminder being called");
        console.log("--------------");
        console.log(component.get("v.BulkyId"));
        var action = component.get("c.GetBulkyReminder");
        action.setParams({ "BulkyId" : component.get("v.BulkyId") })
        
        // do call back to server
        action.setCallback(this,function(a) {
            console.log("returned from call back");
            var ret = a.getReturnValue();
            console.log(" Returned :",ret);
            component.set("v.bulkyInfo",ret);
            });
        console.log('Queuing the action');
        $A.enqueueAction(action);
    },	

    handleClick : function(component,event,helper) {

        console.log("sendBulkyReminder being called");
        console.log("--------------");
        var action = component.get("c.sendBulkyReminder");
        action.setParams({ "BulkyId" : component.get("v.BulkyId") })
        
        // do call back to server
        action.setCallback(this,function(a) {
            console.log("returned from call back");
            var ret = a.getReturnValue();
            console.log(" Returned :",ret);
            });
        console.log('Queuing the action');
        $A.enqueueAction(action);
        
        
        
      var navigate = component.get('v.navigateFlow')
      navigate('NEXT');       
    }, 
    
    handleSkipClick : function(component,event,helper) {
      var navigate = component.get('v.navigateFlow')
      navigate('NEXT');       
    },  
})