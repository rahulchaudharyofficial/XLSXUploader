({
    clickCreateItem : function(component, event, helper) {

        var isFormValid = component.find("expenseform").reduce(function(currentStatus, currentInput) {
            currentInput.showHelpMessageIfInvalid();
            return currentStatus && currentInput.get("v.validity").valid;
        }, true);
        
        if(isFormValid) {
            helper.createItem(component, event);
        }
    }
})