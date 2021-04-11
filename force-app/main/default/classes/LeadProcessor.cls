public with sharing class LeadProcessor  implements Database.Batchable<SObject>{
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('Select Id, LeadSource from Lead');
    }

    public void execute(Database.BatchableContext bc,List<SObject> scope) {
        if(scope!=null && scope.size()>0) {
            List<Lead> result = new List<Lead>();

            for(SObject s : scope) {
                Lead temp = (Lead) s;
                temp.LeadSource = 'Dreamforce';
                result.add(temp);
            }

            if(result.size()>0) {
                update result;
            }
        }
    }

    public void finish(Database.BatchableContext bc) {

    }
}