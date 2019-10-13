({
	DoInit : function(component, event, helper) {
        console.log("Community Bulky Dates DoInit being called");
        console.log("Assisted", component.get("v.Assisted"));
        console.log("selectedAssisted", component.get("v.selectedAssisted"));
        console.log("--------------");
        var action = component.get("c.GetBulkyDateOptions");
        
        // do call back to server
        action.setCallback(this,function(a) {
            console.log("returned from call back");
            var retDates = a.getReturnValue();
            console.log(" Returned :",retDates);
            if (retDates != null)
                {
                    console.log(retDates);
                    component.set("v.bulkyDates",retDates);
                }
            });
        console.log('Queuing the action');
        $A.enqueueAction(action);
    },		
	
   handleClick : function(component, event, helper) {
        var selectedDateId = event.getSource().get("v.name");
        console.log(selectedDateId);

       component.set("v.selectedBulkyDate", selectedDateId);
      	var navigate = component.get("v.navigateFlow");
      	navigate("NEXT");
   },
        
    
})