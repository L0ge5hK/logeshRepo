public with sharing class InsertTaskRecord 
{
    //wrapped value
    static DraftWrapper wrapval = new DraftWrapper();

    @AuraEnabled
    public static string subjectDraftValue(String subval)
    {
       wrapval.draftsubject = subval;
       return wrapval.draftsubject;
    }

    @AuraEnabled
    public static string priorityDraftValue(String prival)
    {
        wrapval.draftpriority = prival;
        return wrapval.draftpriority;
    }

    @AuraEnabled
    public static string statusDraftValue(String statval)
    {
        wrapval.draftstatus = statval;
        return wrapval.draftstatus;
    }

    @AuraEnabled
    public static string sublue()
    {
       return '';
    }

    //wrapper class
    public class DraftWrapper 
    {
        public String draftsubject {get;set;}
        public String draftpriority {get;set;}
        public String draftstatus {get;set;}
    }
}
    
