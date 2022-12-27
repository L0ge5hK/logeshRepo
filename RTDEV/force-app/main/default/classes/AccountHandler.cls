public with sharing class AccountHandler 
{
    //-----------------------------------onAfterInsert----------------------------------
    public static void onAfterInsert(List<Account> newaccountlist) 
    {
        //Creating List of key contact
        List<Key_Contact__c> keycontactlist = new List<Key_Contact__c>();
        
        for(Account a:[SELECT Id, Name, RecordType.Name, Phone, Account_Email__c
                       FROM Account 
                       WHERE Id IN : newaccountlist])
        { 
            // Adding the Record Type into the Key Contact with respect to the Record Type of the Account
            if(a.RecordType.Name == 'Prospect_Company')
            {
                // creating a Key Contact of type Prospect
                keycontactlist.add(new Key_Contact__c(AccoutId__c = a.Id, 
                                                        Name = a.Name+'-key',
                                                        Type__c = 'Prospect',
                                                        Email__c =a.Account_Email__c,
                                                        Mobile__c = a.Phone)); 
            }
            
            else if(a.RecordType.Name == 'Ignite_Company')
            {
                // creating a Key Contact of type Ignite
                keycontactlist.add(new Key_Contact__c(AccoutId__c = a.Id, 
                                                        Name = a.Name+'-key',
                                                        Type__c = 'Ignite',
                                                        Email__c =a.Account_Email__c,
                                                        Mobile__c = a.Phone)); 
            }
            
            else
            {
                // creating a Key Contact of type Sales
                keycontactlist.add(new Key_Contact__c(AccoutId__c = a.Id, 
                                                        Name = a.Name+'-key',
                                                        Type__c = 'Sales',
                                                        Email__c =a.Account_Email__c,
                                                        Mobile__c = a.Phone)); 
            }
            
        }
        INSERT keycontactlist;
        
    }
}