public with sharing class DailyLeadProcessor implements Schedulable {
    public void execute(SchedulableContext context) {
        List<Lead> leads = [Select Id, LeadSource from Lead where LeadSource=null Limit 200];
        List<Lead> up = new List<Lead>();
        if(leads!=null && leads.size()>0) {
            for(Lead l : leads) {
                l.LeadSource = 'Dreamforce';
                up.add(l);
            }
        }
        if(leads!=null && leads.size()>0) {
            update leads;
        }
    }
}