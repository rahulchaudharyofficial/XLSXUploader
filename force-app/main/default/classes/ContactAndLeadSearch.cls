public with sharing class ContactAndLeadSearch {
    public static List<List<SObject>> searchContactsAndLeads(String input) {
        List<List<SObject>> toReturn = null;
        if(!String.isBlank(input)) {
            toReturn = [Find :input IN ALL FIELDS RETURNING Contact(LastName), Lead(LastName)];
        }
        return toReturn;
    }
}