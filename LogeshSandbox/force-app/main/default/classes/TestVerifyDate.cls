@isTest
public with sharing class TestVerifyDate 
{
    @isTest
    static void test1() 
    {
        Date d1 = VerifyDate.CheckDates(date.newInstance(2022, 10, 12),date.newInstance(2022, 09, 28));
        System.debug(d1);
        System.assertEquals(d1,date.newInstance(2022, 10, 12),'not working');
    }

    @isTest
    static void test2() 
    {
        
    }
    
    @isTest
    static void test3() 
    {
        
    }
}
