trigger ContactHandle on Contact (after insert, after delete, after update, after undelete, before insert) 
{

    if(trigger.isBefore && (trigger.isInsert))
    {
        toCountAccContacts.forUpdateContacts(trigger.new);
    }
    if(trigger.isAfter && (trigger.isDelete || trigger.isUpdate))
    {
        toCountAccContacts.toDelete(trigger.old);
    }
    if(trigger.isAfter && (trigger.isUndelete || trigger.isInsert || trigger.isUpdate ))  
    {
        toCountAccContacts.countContacts(trigger.new);
    }
    
}