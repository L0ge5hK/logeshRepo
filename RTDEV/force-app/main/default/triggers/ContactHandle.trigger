trigger ContactHandle on Contact (after insert, after delete, after update, after undelete) 
{
  
        if(trigger.isAfter && trigger.isDelete)
        {
            System.debug('isafter and is delete runningg');
            toDeleteandCount.deleteContacts(trigger.old);
        }
        if(trigger.isAfter && (trigger.isUndelete || trigger.isInsert || trigger.isUpdate /*|| trigger.isDelete*/))  
        {
            toCountAccContacts.countContacts(trigger.new);
        }
        
}