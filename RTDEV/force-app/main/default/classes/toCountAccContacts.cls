public with sharing class toCountAccContacts 
{
public static void countContacts(List<Contact> newlist)	
{
Set<id> aid=new Set<id>();
if(newlist!=null)
{
for(Contact c:newlist)
{
if(c.accountId!=null)
{
aid.add(c.accountId);
}
}
}
List<Account> accounts= [SELECT Id,  Total_Contacts__c,(SELECT Id from Contacts)FROM Account WHERE Id in : aid];
List<Contact> delLists=new List<Contact>(); 

for(Account acc:accounts)
{
acc.Total_Contacts__c=acc.Contacts.size();

if(acc.Contacts.size() >5){
    delLists.addAll(acc.Contacts);
acc.Total_Contacts__c=0;
}
}
delete delLists;
update accounts;
}
}