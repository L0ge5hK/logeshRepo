public with sharing class ContactAndLeadSearch 
{
    public static List<List< sObject>> searchContactsAndLeads(String s) 
    {
        List<List< sObject>> searchist = [FIND: s IN NAME FIELDS RETURNING Contact, Lead];  
        return searchist;   
    }
}
