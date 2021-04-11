public with sharing class AddPrimaryContact implements Queueable {
    private Contact contct;
    private String state;
    public AddPrimaryContact(Contact contct, String state) {
        this.contct = contct;
        this.state = state;
    }

    public void execute(QueueableContext context) {
        
        if(contct!=null && !String.isBlank(state)) {
            List<Contact> updates = new List<Contact>();
            List<Account> accounts = [SELECT  Id, (Select id, accountid from Contacts) from Account where BillingState= :state Limit 200];
            if(accounts!=null && accounts.size()>0) {
                for(Account a : accounts) {
                    contact c = new contact();
                    c = this.contct.clone(false,false,false,false);
                    c.accountid=a.id;
                    updates.add(c);
                }
            }
            if(updates.size()>0) {
                insert updates;
            }
        }        
    }
}