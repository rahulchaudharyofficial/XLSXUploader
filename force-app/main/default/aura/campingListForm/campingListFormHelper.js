({
    createItem : function(component, event) {
        let item =component.get("v.newItem");
        var addItemEvent  = component.getEvent("addItem");
        addItemEvent.setParams({
            "item": item
        });
        addItemEvent.fire();
        component.set("v.newItem",{
            'sObjectType':'Camping_Item__c',
            'Quantity__c': 0,
            'Price__c' : 0,
            'Packed__c': false
        })
    }
})