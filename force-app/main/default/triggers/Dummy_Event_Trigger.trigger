trigger Dummy_Event_Trigger on Dummy_Event__e (after insert) {
    DummyEventSubscriber.process(Trigger.new,Trigger.old,Trigger.newMap,Trigger.oldMap);
}