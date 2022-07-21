trigger ContactHandleTrigger on Contact (after insert, after delete, after update, after undelete, before insert) 
{

    if(trigger.isBefore && (trigger.isInsert))
    {
        ContactHandle.checkNumOfContacts(trigger.new);
    }
    if(trigger.isAfter && (trigger.isDelete || trigger.isUpdate))
    {
        ContactHandle.toDeleteContact(trigger.old);
    }
    if(trigger.isAfter && (trigger.isUndelete || trigger.isInsert || trigger.isUpdate ))  
    {
        ContactHandle.newContact(trigger.new);
    }
    
}