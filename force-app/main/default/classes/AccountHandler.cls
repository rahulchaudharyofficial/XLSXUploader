public class AccountHandler {
    public static Account insertNewAccount(String accountName) {
        Account toReturn = null;
        try {
            toReturn = new Account(name=accountName);
            Database.SaveResult result= Database.insert(toReturn);
            if(result.isSuccess()) {
                System.debug('Account Id = '+ result.id+' saved successfully');
            }
            else {
                for(Database.Error e: result.getErrors()) {
                    System.debug('Insertion failed for Account name => '+ accountName);
                }
            }
        }
        catch(DmlException ex) {
            toReturn = null;
        }
        return toReturn;
    }

    public static void insertAccount(Integer param) {
        Integer numOfAccount = 3;
        if(param!=null) {
            numOfAccount = param;
        }
        List<Account> addAccounts = new List<Account>();
        for(Integer i=0; i<numOfAccount;i++) {
            addAccounts.add(new Account(Name='Acme Inc '+i,AccountNumber='A000'+i));
        }

        insert addAccounts;
    }
}