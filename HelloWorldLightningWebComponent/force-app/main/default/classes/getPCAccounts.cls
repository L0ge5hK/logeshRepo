public with sharing class getPCAccounts 
{
    @AuraEnabled(cacheable=true)
    public static List<Account>  fetchAccountNames(String searchname)
    {
            String searchkey = '%'+searchname+'%';
            return [SELECT Id,Name FROM Account WHERE Name LIKE : searchkey ];
    }
}
