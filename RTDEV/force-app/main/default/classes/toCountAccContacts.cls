public with sharing class toCountAccContacts 
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
     //---------------------------------------------------Insertion and Updation-----------------------------------------------------
public static void countContacts(List<Contact> newlist)	
{
    List<Account> accounts= createList(newlist);
    List<Contact> countAcc=new List<Contact>(); 
    for(Account acc:accounts)
    {
        acc.Total_Contacts__c=acc.Contacts.size();
        countAcc.addAll(acc.Contacts);
    }
    update accounts;
    System.debug('Updated Acc=  '+countAcc);
}
//---------------------------------------------------------Deletion----------------------------------------------------------------
public static void toDelete(List<Contact> newlist)	
{
    List<Account> accounts= createList(newlist);
    List<Account> updtAcc=new List<Account>(); 
    System.debug('Acc=  '+accounts);
    for(Account acc:accounts)
    {
        updtAcc.add(acc);
        acc.Total_Contacts__c=acc.Contacts.size();
    }
    update updtAcc;
}
//-------------------------------------------------------------Deletion if more than 3--------------------------------------------------
public static void forUpdateContacts(List<Contact> newlist)	
{
    List<Account> accounts= createList(newlist);
    List<Contact> delAcc=new List<Contact>(); 
    //System.debug('Acc=  '+accounts);
    for(Account acc:accounts)
    {
        if(acc.Total_Contacts__c>=3)
        {
            delAcc.addAll(acc.Contacts);
        }
        delete delAcc;
    }
}
//----------------------------------------------------------------------------------------------------------------------
} // end of class