@isTest
public with sharing class getPCAccountsTest 
{
    @TestSetup
    static void setupAccountRecords()
    {
        List<Account> accountlist = new List<Account>();
        for (Integer i=0;i<3;i++) 
        {
            accountlist.add(new Account(Name = 'Account'+i+'setFirst',
                                        Phone = '+91 0099887766',
                                        Account_Email__c = 'setFirst'+i+'account@salesf.com'));            
        }

        INSERT accountlist;
    }

    @isTest
    static void fetchAccountBySearchString()
    {
        Account accname = [SELECT Name FROM Account WHERE Name LIKE '%t2%' LIMIT 1];
        List<Account> accountnamelist = getPCAccounts.fetchAccountNames(''+accname.Name);
        System.assertEquals(1,accountnamelist.size(),'Not Matching :( ');  
    }
}