public class POC1TriggerHandler {
    private static final String SUCCESS='SUCCESS';
    private static final String FAILURE='FAILURE';
    //private static Map<String,String> failedReplayId = new Map<String,String>();
    PlatformEventMonitoringSelector.IPlatformEventMonitoringSelector selector = new PlatformEventMonitoringSelector();
    public static void process(Eventbus.TriggerContext context ,List<POC1__e> newRecords) {
        final Integer MAX_TRIGGER_BATCH_SIZE=200;
        if(context!=null && newRecords!=null && !newRecords.isEmpty()) {
            System.debug('retries => '+ context.retries);
            System.debug('lastError => '+ context.lastError);
            Integer loopCounter = -1;
            if(newRecords.size()<MAX_TRIGGER_BATCH_SIZE) {
                loopCounter = newRecords.size();
            }
            else {
                loopCounter = MAX_TRIGGER_BATCH_SIZE;
            }
            
            List<Platform_Event_Monitoring__c> plevents = new List<Platform_Event_Monitoring__c>();
            String lastSuccess = '';
            for(Integer count = 0; count<loopCounter; count++) {
                POC1__e ev = newRecords.get(count);
                String replayId = ev.ReplayId;
                
                /*
                if(failedReplayId.keySet().contains(replayId) && failedReplayId.get(replayId).equalsIgnoreCase(FAILURE)) {
                    //Let it process
                }
                */
            	Platform_Event_Monitoring__c temp = new Platform_Event_Monitoring__c(event_payload__c=ev.payload__c,ReplayId__c=ev.ReplayId,
                Platform_Event_Name__c='POC1__e' );    
                
                if(Math.mod((count+1), 3)!=0) {
                    temp.IsFailure__c=false;
                    temp.IsSuccess__c=true;
                    lastSuccess=ev.ReplayId;
                    System.debug('Successfully processed event for replayId '+ replayId);
                    //failedReplayId.put(replayId, SUCCESS);           
                }
                else {
                    //failedReplayId.put(replayId, FAILURE);
                    System.debug('Failed to process event for replayId '+ replayId);
                    temp.IsFailure__c=true;
                    temp.IsSuccess__c=false;
                }
                temp.Last_Success_Replay_Id__c=lastSuccess;
                plevents.add(temp);
            }
            insert plevents;
            for(Platform_Event_Monitoring__c e : plevents) {
                if(e.isFailure__c) {
                    context.setResumeCheckpoint(e.Last_Success_Replay_Id__c);
                    break;
                }
            }
        }
    }
}