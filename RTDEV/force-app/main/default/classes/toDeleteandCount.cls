public class toDeleteandCount 
{
    //-----------------------Create Account List------------------------------------------------------------
    public static List<Account> createList(List<Contact> Li)
    {
        Set<ID> aid=new Set<ID>();
        if(Li!=null)
        {
            for(Contact c:Li)
            {
                aid.add(c.accountId);
            }
        }
        List<Account> ac= [SELECT Id,  Total_Contacts__c,(SELECT Id from Contacts)FROM Account WHERE Id IN : aid];
        return ac;
    }
    //-------------------------------------------------------------------------------------------------------------------------
public static void deleteContacts(List<Contact> oldList) 
{
    List<Contact> delme=new List<Contact>(); 
    /*if(delme.size()==5) // delete if 5  contacts
    {
        DELETE delme;
        System.debug('Should be empty now  '+delme);
    }*/
    List<Account> ac= createList(oldList);
    for(Account a:ac)
    {
        a.Total_Contacts__c=a.contacts.size();
        System.debug('iteration for TOC  '+a.Total_Contacts__c);
        if(a.Total_Contacts__c>=3)
        {
            delme.addAll(a.Contacts);
        }
        
    }
    if(!delme.isEmpty())
    {
        DELETE delme;
        System.debug('Should be empty now  '+delme);
    }
    update ac;
    System.debug('account updated  '+ac);
}//method ends

}