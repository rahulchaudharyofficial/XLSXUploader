trigger ClosedOpportunityTrigger on Opportunity (before insert, before update) {
    List<Task> tasks = new List<Task>();

    for(Opportunity op : Trigger.new) {
        if(op.StageName=='Closed Won') {
            tasks.add(new Task(Subject='Follow Up Test Task',WhatId=op.Id));
        }
    }
    if(tasks.size()>0) {
        insert tasks;
    }
}