({
    doInit : function(component, event, helper) {
        let action = component.get("c.getItems");
        action.setCallback(this, function(response) {
            if(response.getState()==="SUCCESS") {
                const result =  JSON.stringify(response.getReturnValue());
                console.log(JSON.stringify(result));
                component.set("v.items", JSON.parse(result));
            }
        });
        $A.enqueueAction(action);
    },
    handleAddItem : function(component, event, helper) {
        const item = event.getParam("item");
        //helper.createItem(component, event, updatedExp);
        const action = component.get("c.saveItem");
        action.setParams({
            "itemToSave": item
        });

        action.setCallback(this,function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                const itms = component.get("v.items");
                itms.push(
                    JSON.parse(JSON.stringify(response.getReturnValue()))
                );
                component.set("v.items", itms);
            }
        });

        $A.enqueueAction(action);
    }
})