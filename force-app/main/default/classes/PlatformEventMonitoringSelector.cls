public with sharing class PlatformEventMonitoringSelector implements IPlatformEventMonitoringSelector {
    private final Integer MAX_EVENT_LIFE = 24; //In Hours from the time of publish
    private final String baseQuery='';
    public List<Platform_Event_Monitoring__c> getByReplayId(String eventTypeName, String replayId) {
        List<Platform_Event_Monitoring__c> toReturn = null;
        try {
            toReturn = [select event_payload__c, IsFailure__c, IsSuccess__c, Last_Success_Replay_Id__c, Platform_Event_Name__c, ReplayId__c from Platform_Event_Monitoring__c where Platform_Event_Name__c=:eventTypeName and ReplayId__c=:replayId];
        }
        catch(DmlException ex) {
            System.debug(LoggingLevel.ERROR,'Failed to read platform event monitoring record for eventTypeName = '+ eventTypeName +' and ReplayId__c='+replayId);
            throw new PlatformEventMonitoringException('Failed to read platform event monitoring record for eventTypeName = '+ eventTypeName +' and ReplayId__c='+replayId);
        }

        return toReturn;
    }
    public List<Platform_Event_Monitoring__c> getByEventTypeName(String eventTypeName) {
        List<Platform_Event_Monitoring__c> toReturn = null;
        try {
            toReturn = [select event_payload__c, IsFailure__c, IsSuccess__c, Last_Success_Replay_Id__c, Platform_Event_Name__c, ReplayId__c from Platform_Event_Monitoring__c where Platform_Event_Name__c=:eventTypeName];
        }
        catch(DmlException ex) {
            System.debug(LoggingLevel.ERROR,'Failed to read platform event monitoring record for eventTypeName = '+ eventTypeName);
            throw new PlatformEventMonitoringException('Failed to read platform event monitoring record for eventTypeName = '+ eventTypeName);
        }

        return toReturn;
    }

    public List<Platform_Event_Monitoring__c> getByEventTypeNameAndReplyIds(String eventTypeName,List<String> replayIds) {
        List<Platform_Event_Monitoring__c> toReturn = null;
        try {
            toReturn = [select event_payload__c, IsFailure__c, IsSuccess__c, Last_Success_Replay_Id__c, Platform_Event_Name__c, ReplayId__c from Platform_Event_Monitoring__c where Platform_Event_Name__c=:eventTypeName and ReplayId__c in :replayIds];
        }
        catch(DmlException ex) {
            System.debug(LoggingLevel.ERROR,'Failed to read platform event monitoring record for eventTypeName = '+ eventTypeName + 'and replayids ='+ replayIds);
            throw new PlatformEventMonitoringException('Failed to read platform event monitoring record for eventTypeName = '+ eventTypeName+ 'and replayids ='+ replayIds);
        }
        return toReturn;
    }

    public List<Platform_Event_Monitoring__c> updateRecords(List<Platform_Event_Monitoring__c> records) {
        try {
            Database.update(records);
        }
        catch(DmlException ex) {
            System.debug(LoggingLevel.ERROR,'Failed to update platform event monitoring records');
            throw new PlatformEventMonitoringException('Failed to update platform event monitoring records');
        }
        return records;
    }

    public interface IPlatformEventMonitoringSelector {
        List<Platform_Event_Monitoring__c> getByReplayId(String eventTypeName, String replayId);
        List<Platform_Event_Monitoring__c> getByEventTypeName(String eventTypeName);
        List<Platform_Event_Monitoring__c> getByEventTypeNameAndReplyIds(String eventTypeName,List<String> replayIds);
        List<Platform_Event_Monitoring__c> updateRecords(List<Platform_Event_Monitoring__c> records);
    }


    public class PlatformEventMonitoringException extends Exception {}
}