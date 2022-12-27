public with sharing class DraftHandler 
{
    @AuraEnabled
    public static string onRefreshPage()
    {
        List<Draft__c> checkrecordlist = [SELECT Id,Name,draftval__c 
                                        FROM Draft__c
                                        WHERE Name = 'TaskDraftValues'
                                        LIMIT 1];
        if (checkrecordlist.isEmpty()) 
        {
            return 'No Draft Record created (should create later)';
        }
        else 
        {
            Draft__c checkrecord = checkrecordlist.remove(0);
            System.debug(' check rec draft val-->>'+checkrecord.draftval__c);
            return ''+checkrecord.draftval__c;
        } 
    }

    //Deletion of all Drafts
    @AuraEnabled
    public static string deleteAllDrafts()
    {
        System.debug('Deleting the records ...');
        List<Draft__c> del = [SELECT Id FROM Draft__c];
        DELETE del;
        System.debug('Deleted Successfully !');
        return null;
    }
        
    @AuraEnabled
    public static String saveDraft(String draftobject)
    {
        List<Draft__c> checkrecordlist = [SELECT Id,Name FROM Draft__c WHERE Name = 'TaskDraftValues'];
        if(checkrecordlist.isEmpty())
        {
            System.debug(' If part runs');
            Draft__c checkrecord = new Draft__c(Name = 'TaskDraftValues', draftval__c = draftobject);
            System.debug('checkrec ->> '+checkrecord);
            INSERT checkrecord;
            return ''+checkrecord.draftval__c;
        }
        else
        {
            
            System.debug('Else part runs');
            Draft__c rec = checkrecordlist.remove(0);
            rec.draftval__c = draftobject;
            UPDATE rec; 
            return ''+rec.draftval__c;
        }
    }

    @AuraEnabled
    public static string onSavingInputs(String saveobj)
    {
        System.debug('Saving .... '+saveobj);
        SaveValuesWrapper wrap = (SaveValuesWrapper)JSON.deserialize(saveobj,SaveValuesWrapper.class);
        System.debug('wrap contect ... '+wrap);
        Task taskrec = new Task();
        taskrec.Subject = wrap.Subject; //subject
        taskrec.ActivityDate = wrap.ActivityDate; //date
        taskrec.Description = wrap.Comments.stripHtmlTags(); //comments
        
        INSERT taskrec;
        return ''+taskrec;
    }

    //wrapperclass
    public class SaveValuesWrapper
    {
        public String Subject {get;set;}
        public String Comments {get;set;}
        public Date ActivityDate {get;set;}
        public String NextAction {get;set;}
        public String DealPartner {get;set;}
    }
}
