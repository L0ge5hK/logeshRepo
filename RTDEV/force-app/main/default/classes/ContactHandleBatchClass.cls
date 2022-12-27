public with sharing class ContactHandleBatchClass implements Database.Batchable<SObject>
{
    public Database.QueryLocator start(Database.BatchableContext BC)
    {
        return Database.getQueryLocator(query);
    }
  
     public void execute(Database.BatchableContext BC, 
                         List<sObject> scope)
    {
        for(Sobject s : scope)
        {
            s.put(Field,Value); 
        }
        update scope;
    }
  
    public void finish(Database.BatchableContext BC)
    {
        
    }
    
}
