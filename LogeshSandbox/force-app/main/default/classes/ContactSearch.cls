public with sharing class ContactSearch 
{
    public static List<Contact> searchForContacts(String a, String b) 
    {
        List<Contact> conlist = [ SELECT Id, Name 
                                    FROM Contact 
                                    WHERE (LastName =: a) AND (MailingPostalCode =:b)];

        return conlist;
    }
}
