public with sharing class ContactSearch {
    public static List<Contact> searchForContacts(String lastName, String mailingPostalCode) {
        return [select id, name from contact where lastname= :lastName and MailingPostalCode= :mailingPostalCode];
    }
}