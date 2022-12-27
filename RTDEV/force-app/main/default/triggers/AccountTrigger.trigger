/*
*      Trigger on Account Object
* 
*      Author:   V Logesh Kumar
*      Date:     July 22, 2012
*
*/
trigger AccountTrigger on Account (after insert) 
{
    if(trigger.isAfter && trigger.isInsert)
    {
        KeyContact.onAfterInsert(trigger.new);//AccountTiggerHandler
    }

}