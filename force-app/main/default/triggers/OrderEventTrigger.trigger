trigger OrderEventTrigger on Order_Event__e (after insert) {
    
    List<Task> tasks = new List<Task>();

    for(Order_Event__e ev : Trigger.new) {
        if(ev.Has_Shipped__c==true) {
            Task t = new Task();
            t.Priority='Medium';
            t.subject='Follow up on shipped order ' + ev.Order_Number__c;
            t.OwnerId = ev.createdById;
            tasks.add(t);
        }
    }

    if(tasks!=null && tasks.size()>0) {
        insert tasks;
    }
}