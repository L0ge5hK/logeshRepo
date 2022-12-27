/*
*      Trigger on Account Object
* 
*      Author:   V Logesh Kumar
*      Date:     July 22, 2022
*
*/
trigger AccountTriggerHandler on Account (after insert) 
{
    if(trigger.isAfter && trigger.isInsert)
    {
        AccountHandler.onAfterInsert(trigger.new);//AccountTiggerHandler
    }

}