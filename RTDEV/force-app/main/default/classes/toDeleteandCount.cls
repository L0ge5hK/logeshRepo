public class toDeleteandCount 
{
public static void deleteContacts(List<Contact> oldList) //delete a contact
{
    Set<ID> aid=new Set<ID>();
    if(oldList!=null)
    {
        System.debug('oldlist null cond');
        for(Contact c:oldList)
        {
                System.debug('old list getting added');
                aid.add(c.accountId);
        }
    }
    System.debug('he OL= '+oldList);
    List<Account> ac= [SELECT Id,  Total_Contacts__c,(SELECT Id from Contacts)FROM Account WHERE Id IN : aid];
    List<Account> delme=new List<Account>(); 
    for(Account a:ac)
    {
        System.debug('delme getting added');
        delme.add(a);
    }
    System.debug('delme = '+ delme);
    
    if(delme.size()>=5) // delete all if 5 or more contacts
    {
        System.debug('delme size is more than 5');
        DELETE delme;
        System.debug('Deleted bro');
    }
    for(Account a:ac)
    {
        a.Total_Contacts__c=a.contacts.size();
        System.debug('iteration for TOC'+a.Total_Contacts__c);
        
    }
    
    
    
    update ac;
    System.debug('account updated'+ac);
}//method ends

}