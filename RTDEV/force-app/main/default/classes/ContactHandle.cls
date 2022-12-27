public with sharing class ContactHandle 
{
        //-----------------------Method to Create Account List------------------------------------------
        public static List<Account> createList(List<Contact> contactlist)
        {
            Set<ID> AccId=new Set<ID>(); //creating a set of ID named "AccId"
            if(!contactlist.isEmpty())
            {
                for(Contact c:contactlist)
                {
                AccId.add(c.accountId); //Adding accountId into Set AccId
                }
            }
            List<Account> ac= [SELECT Id,  Total_Contacts__c,(SELECT Id from Contacts)
                                FROM Account 
                                WHERE 
                                Id IN : AccId]; //Creating List of Account
            return ac; //returning the created account list
        }
        //--------------------------Method for Insertion and Updation-------------------------------------
public static void newContact(List<Contact> newlist)	
{
    List<Account> accounts= createList(newlist); //calling method "createList" to create a list of accounts
    List<Contact> countAcc=new List<Contact>(); //creating list of contacts named "countAcc"
    for(Account acc:accounts)
    {
        acc.Total_Contacts__c=acc.Contacts.size(); //updating the number of contacts
        countAcc.addAll(acc.Contacts); // storing all the contacts
    }
    update accounts; //update the list
}
//-------------------------------------------Method for Deletion---------------------------------------------------
public static void toDeleteContact(List<Contact> oldlist)	
{
    List<Account> accounts= createList(oldlist); //calling method "createList" to create a list of accounts
    List<Account> updtAcc=new List<Account>(); //Creating another list of accounts named "updtAcc"
    for(Account acc:accounts)
    {
        updtAcc.add(acc); //Fetching from "accounts" and adding to "updtAcc"
        acc.Total_Contacts__c=acc.Contacts.size();
    }
    update updtAcc; // updating new list of contacts
}
//-----------------------------------------Method for Deletion if more than 3--------------------------------------------------
public static void checkNumOfContacts(List<Contact> newlist)	
{
    List<Account> accounts= createList(newlist); //calling method "createList" to create a list of accounts
    List<Contact> delAcc=new List<Contact>(); //creating list of contacts named "delAcc" to store contacts
    for(Account acc:accounts)
    {
        if(acc.Total_Contacts__c>=3) 
        {
            delAcc.addAll(acc.Contacts); //adding all contacts to delAcc 
        }
        delete delAcc; //deleting all elements inside delAcc
    }
}
//----------------------------------------------------------------------------------------------------------------------
}