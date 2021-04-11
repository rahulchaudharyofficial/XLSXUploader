public class POCEventPublisher {
    public static void publish(String payload, integer count) {
		System.assert(count!=null && count>0);
		List<POC1__e> pocList = new List<POC1__e>();
		for(Integer i = 0; i<count;i++) {
			pocList.add(new POC1__e(payload__c=payload + ' : count = '+ i));
		}
		if(!pocList.isEmpty()) {
			List<Database.SaveResult> results = EventBus.publish(pocList);
			integer total=0;
			for(Database.SaveResult result : results) {
				if(result.isSuccess()) {
					//System.debug('Successfully published event.');
					++total;
					//for(Database.Error err : result.getErrors()) {
					//	   System.debug('Success Message returned: ' +err.getStatusCode() +' - ' +err.getMessage());
					//}
				}
				else {
					for(Database.Error err : result.getErrors()) {
						System.debug('Error returned: ' +err.getStatusCode() +' - ' +err.getMessage());
					}
				}
			}

			System.debug('Total '+ total+' platform events successfully published');
		}
        
    }
}