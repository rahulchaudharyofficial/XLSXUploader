public class EmailMissionSpecialist {
    //public method
    public void sendEmail(String address,String subject,String body) {
        //Create an email message
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddress = new String[] {address};
        mail.setToAddresses(toAddress);
        mail.setSubject(subject);
        mail.setPlainTextBody(body);
        //Pass this email
        //to class
        Messaging.SendEmailResult[] results = Messaging.sendEmail(
                new Messaging.SingleEmailMessage[]{mail});
        //Call a helper method
        inspectResults(results);
    }
    //Helper method
    private static Boolean inspectResults(Messaging.SendEmailResult[] results) {
        return true;
    }
}