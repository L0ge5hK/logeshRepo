@isTest
public with sharing class DraftHandlerTest 
{
    @TestSetup
    static void makeData()
    {
        Draft__c draftrec = new Draft__c(Name = 'TaskDraftValues', draftval__c = '{"Subjct":"this is sample","Comments":"<p>hii am testing this</p>"}');
        INSERT draftrec;
    }

    @isTest
    static void checkOnRefresh()
    {
        //checking if draft record exist (only 1)
        String result = DraftHandler.onRefreshPage();

        String draftfieldvalue = [SELECT draftval__c FROM Draft__c].draftval__c;
        System.assertEquals(draftfieldvalue,result,'Error in the result'); 
    }

    @isTest
    static void checkOnSavingDraft()
    {
        //creating JSON
        String jsonvalue = [SELECT draftval__c FROM Draft__c].draftval__c;

        //calling method and passing a jsonobject
        String result = DraftHandler.saveDraft(jsonvalue);


        //checking if equal (updating the same value into the field)
        String draftfieldvalue = [SELECT draftval__c FROM Draft__c].draftval__c;
        System.assertEquals(draftfieldvalue,result,'Error in the json result');
    }

    @isTest
    static void checkOnSavingTask()
    {
        //creating JSON 
        String jsonvalue = [SELECT draftval__c FROM Draft__c].draftval__c;

        //calling method and passing a jsonobject
        DraftHandler.onSavingInputs(jsonvalue);

        //checking if equal (updating the same value into the field)
        Integer taskrecordcount = [SELECT COUNT() FROM Task];
        System.assertEquals(1,taskrecordcount,'Error in the task result');

        //checking if the comments have no tags in value (using assertNotEquals method)
        String taskcomment = [SELECT Description FROM Task LIMIT 1].Description;
        System.assertNotEquals(jsonvalue,taskcomment,'maybe it is equal');
    }

    @isTest
    static void checkDeleteDraft()
    {
        //calling the method
        String result = DraftHandler.deleteAllDrafts();

        //checking if drafts are deleted
        List<Draft__c> draftlist = [SELECT Id FROM Draft__c];
        System.assertEquals(0,draftlist.size(),'Error is deletion');

        //checking if the method returned null
        System.assertEquals(null,result,'Null was not returned');
    }

}
