/**
 * 
 * @author V Logesh Kumar
 * @since December 15 2022
 * @description A class to fetch the parent accounts, child accounts 
 *              returning the resultant to it's respective Lightning Components
 */
public with sharing class DisplayDataInAccordion 
{
    //constructor
    public DisplayDataInAccordion() 
    {

    }

    //method called when wire runs
    @AuraEnabled (cacheable=true)
    public static List<Account> fetchrecords()
    {
        List<Account> acclist = [SELECT Id, Name, ParentId 
                                    FROM Account 
                                    WHERE ParentId=NULL ORDER BY Name ASC];
        System.debug('the ll >>> '+acclist);

        return acclist;
        //return [SELECT Id, Name, Phone FROM Account LIMIT 6];
    }

    //method runs when a section is clicked
    @AuraEnabled (cacheable=true)
    public static List<Account> getRelatedRecordList(String idfromjs)
    {
        List<Account> acclist = [SELECT Id, Name, ParentId 
                                    FROM Account 
                                    WHERE ParentId =: idfromjs ];
        return acclist;
    }
}