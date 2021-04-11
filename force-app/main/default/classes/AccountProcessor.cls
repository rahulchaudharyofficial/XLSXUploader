public with sharing class AccountProcessor {
    
    @future
    public static void countContacts(List<Id> accountIds) {
        if(accountIds!=null && accountIds.size()>0) {
            List<Contact> contacts = [Select Id,AccountId,Account.Number_of_Contacts__c from Contact where AccountId in :accountIds];
            if(contacts!=null && contacts.size()>0) {
                List<Account> accs= new List<Account>();
                for(Id x : accountIds) {
                    Integer count = 0;
                    for(Contact c : contacts) {
                        if(x==c.Account.Id) {
                            count++;
                        }
                    }
                    if(count>0) {
                        accs.add(new Account(Id=x,Number_of_Contacts__c=count));
                    }
                }
                if(accs.size()>0) {
                    upsert accs;
                }
            }
        }
    }
}