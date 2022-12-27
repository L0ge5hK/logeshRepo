public with sharing class GetAccountRecords 
{

    public List<Account> getAllAccounts(String accname) 
    {
            String searchstring = '%'+accname+'%';
            return [SELECT Id,Name FROM Account WHERE Name LIKE : searchstring ];
    }

    /*@AuraEnabled
    public static void setObjectToRecentItems(Id recordId) 
    {
        if (!String.isBlank(recordId)) 
        {
            Schema.SObjectType sObjectType = recordId.getSobjectType();
            String queryString = String.format('SELECT Id, Name FROM {0} WHERE Id =: recordId FOR VIEW', new List<Object>{sObjectType});
            Database.query(queryString);
        }
    }

    @AuraEnabled(cacheable=true)
    public static Account getTheName(String recid)
    {
        System.debug('i got this -->    '+recid);
        String key = '%'+recid+'%';
        //List<Account> result = [SELECT Name FROM Account WHERE Id =: recid LIMIT 1];
        return [SELECT Id,Name FROM Account WHERE Id =: recid LIMIT 1];
    }*/
}