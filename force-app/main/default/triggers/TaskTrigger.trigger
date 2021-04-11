trigger TaskTrigger on Task (after insert) {
    if(Trigger.isInsert && Trigger.isAfter) {
        for(Task t : Trigger.new) {
            //Flow.Interview iview = Flow.Interview.createInterview('Notification', new Map<String,SObject> {'TaskRecord' => t});
            //iview.start();
            //t.OwnerId=null;
        }
    }
}