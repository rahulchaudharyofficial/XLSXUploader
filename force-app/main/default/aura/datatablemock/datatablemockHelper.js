({
    initHandler : function(component, event) {
        const action = component.get("c.getResponse");
        action.setCallback(this, function(response) {
            if(response!==null) {
                const state = response.getState();
                let messages = [];
                if(state ==="SUCCESS") {
                    const responseDTO = response.getReturnValue();
                    // component.set("v.hasRecords",true);
                    console.log('Response => '+JSON.stringify(responseDTO));
                    component.set("v.responseDTO", responseDTO);
                }
                else if(state === "INCOMPLETE") {
                   // messages.push("Incomplete State Received");
                }
                else if(state === "ERROR") {
                   /* component.set("v.isError", true);
                    const errors = response.getError();
                    if (errors) {
                        if (errors[0] && errors[0].message) {
                            messages.push(errors[0].message);
                        }
                    } 
                    else {
                            messages.push("Unknown error occured");
                    }
                    component.set("errors",messages); */
                }
                else { //Default State
                    console.log("Unknkown State");
                }
            }
        });
        $A.enqueueAction(action);
    },
    handleRowAction: function(component, event) {
        //action gives which action performed
        var action = event.getParam('action');
        //row gives complete row information
        var row = event.getParam('row');
        console.log('*****row:'+JSON.stringify(row));
        console.log(JSON.stringify(action));
        alert('You have selected View Action for '+row.Name+'(id='+row.CommandId+')');
    }
});