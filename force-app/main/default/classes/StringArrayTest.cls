public class StringArrayTest {
    public static String[] generateStringArray(Integer inputParam) {
        String[] toReturn = null;
        if(inputParam!=null && inputParam>0) {
            toReturn = new String[inputParam];
            for(Integer i =0;i<inputParam;i++) {
                toReturn[i] = 'Test '+i;
            }
        }
        return toReturn;
    }

    public static void upsertTest() {
        SObject jane = new Contact(FirstName='Jane',
                         LastName='Smith',
                         Email='jane.smith@example.com',
                         Description='Contact of the day');
        insert jane;
        
        Contact jane2 = new Contact(FirstName='Jane',
                         LastName='Smith',  
                         Email='jane.smith@example.com',
                         Description='Prefers to be contacted by email.');

        upsert jane2 Contact.fields.Email;

        System.assertEquals('Prefers to be contacted by email.', [SELECT Description FROM Contact WHERE Id=:jane.Id].Description);
    }
}