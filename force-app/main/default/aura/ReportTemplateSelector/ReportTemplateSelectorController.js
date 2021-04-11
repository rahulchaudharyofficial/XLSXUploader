({
    init : function(component, event, helper) {
        console.log('Record Id => '+ component.get("v.recordId"));
        var action = component.get("c.getRecordTemplatesBySObjectType");
        action.setParams({ 
            recordId : component.get("v.recordId") 
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                const res = response.getReturnValue();
                console.log(JSON.stringify(res));
                component.set("v.templates", res);
            }
        });
        $A.enqueueAction(action);
    }
})