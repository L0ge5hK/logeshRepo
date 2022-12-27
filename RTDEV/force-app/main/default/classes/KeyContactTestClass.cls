@isTest
public with sharing class KeyContactTestClass 
{
    @TestSetup
    static void setupData()
    {
        List<Account> accdata = new List<Account>();
        for(Integer i=0;i<3;i++)
        {
            accdata.add(new Account(Name='ProspectAcc'+i,
                                    RecordTypeId=Schema.SObjectType.Account.getRecordTypeInfosByName().get('Prospect_Company').getRecordTypeId()));

            accdata.add(new Account(Name='IgniteAcc'+i,
                                    RecordTypeId=Schema.SObjectType.Account.getRecordTypeInfosByName().get('Ignite_Company').getRecordTypeId()));

            accdata.add(new Account(Name='SalesAcc'+i,
                                    RecordTypeId=Schema.SObjectType.Account.getRecordTypeInfosByName().get('Sales_Company').getRecordTypeId()));
        }
        INSERT accdata;
    }
    @isTest
    static void insertionCheck()
    {
        //Checking if Accounts are Inserted 
        Integer numberofaccount = [SELECT COUNT() 
                                    FROM Account
                                    WHERE Name LIKE '%Acc_'];

        System.assertEquals(9,numberofaccount,'Count of account is Mismatch ! '); //check accounts

        //Checking if Key Contacts are Inserted
        Integer numberofkeycontact = [SELECT COUNT() 
                                        FROM Key_Contact__c
                                        WHERE Type__c IN ('Prospect','Ignite','Sales')];
        
        System.assertEquals(9,numberofkeycontact,'Count of key contact is Mismatch !'); //check key contacts
    }
    @isTest
    static void notificationCheck()
    {
        Test.startTest();
        KeyContactBatch k = new KeyContactBatch();
        Database.executeBatch(k);
        Test.stopTest();
     
        Integer notificationcount = [SELECT COUNT() 
                                    FROM Key_Contact__c 
                                    WHERE Notification__c = true];

        System.assertEquals(9,notificationcount,'Count of notification is Mismatching !');
    	
    }

}