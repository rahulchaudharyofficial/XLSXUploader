trigger POC1_Trigger on POC1__e (after insert) {
    POC1TriggerHandler.process(Eventbus.TriggerContext.currentContext(),Trigger.new);
}