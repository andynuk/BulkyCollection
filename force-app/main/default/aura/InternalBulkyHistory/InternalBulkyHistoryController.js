({
	DoInit : function(component, event, helper) {
        console.log("Community Bulky History being called");
        console.log("--------------");
        console.log(component.get("v.AddressId"));
        var action = component.get("c.GetBulkyHistory");
        action.setParams({ "AddressId" : component.get("v.AddressId") })
        
        // do call back to server
        action.setCallback(this,function(a) {
            console.log("returned from call back");
            var retDates = a.getReturnValue();
            console.log(" Returned :",retDates);
            component.set("v.bulkyDates",retDates);
            });
        console.log('Queuing the action');
        $A.enqueueAction(action);
    },		
})