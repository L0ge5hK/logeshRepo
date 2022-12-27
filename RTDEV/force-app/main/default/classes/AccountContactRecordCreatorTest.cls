@isTest
public with sharing class AccountContactRecordCreatorTest 
{
     static void testingAccountTrigger() 
    {
        Account prospect_type_account = new Account(Name = 'ProspectAccount', Phone = '+91 9933994422',
                                                    Email = 'prospectacc@gmail.com', Type = 'Prospect');

        INSERT prospect_type_account;

         List<Contact> contactlist = [SELECT Id FROM Contact WHERE AccountId =: prospect_type_account.Id];
        System.assertEquals(2,contactlist.size(),'Not working');
    }
}
