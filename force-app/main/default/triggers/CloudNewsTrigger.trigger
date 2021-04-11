trigger CloudNewsTrigger on Cloud_News__e (after insert) {
    // List to hold all cases to be created.
    List<Case> cases = new List<Case>();
    
    // Get queue Id for case owner
    Group queue = null;
    try {
        queue = [SELECT Id FROM Group WHERE Name='Regional Dispatch' AND Type='Queue'];
    }
    catch(Exception ex) {
        System.debug('No queue record available');
        queue=null;
    }
       
    // Iterate through each notification.
    for (Cloud_News__e event : Trigger.New) {
        if (event.Urgent__c == true) {
            // Create Case to dispatch new team.
            Case cs = new Case();
            cs.Priority = 'High';
            cs.Subject = 'News team dispatch to ' + 
                event.Location__c;
            if(queue==null) {
                cs.OwnerId = UserInfo.getUserId();
            }
            else {
                cs.OwnerId = queue.Id;
            }
            cases.add(cs);
        }
   }
    
    // Insert all cases corresponding to events received.
    insert cases;
}