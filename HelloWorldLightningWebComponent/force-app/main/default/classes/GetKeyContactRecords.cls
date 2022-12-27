public with sharing class GetKeyContactRecords 
{
    @AuraEnabled(cacheable=true)
    public static List<Key_Contact__c> getRecords(String recordId)
    {
        return [SELECT Name, Mobile__c, Email__c, Type__c
                FROM Key_Contact__c
                WHERE AccoutId__c =: recordId];
    }

}
