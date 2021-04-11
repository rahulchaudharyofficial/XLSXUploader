public with sharing class RandomContactFactory {
    public static List<Contact> generateRandomContacts(Integer total ,String lastName) {
        List<Contact> contacts = new List<Contact>();
        if(total!=null && total>0 & !String.isBlank(lastName)) {
            for(Integer count =0; count<total; count++) {
                contacts.add(new Contact(firstname='Test '+ (count+1),lastname=lastName));
            }
        }
        return contacts;
    }
}