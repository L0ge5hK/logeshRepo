/**
 * 
 * @author V Logesh Kumar
 * @since 27-12-2022
 * @description Class used to create two contacts records under an account 
 *              if the account type is prospec or analyst
 */
public with sharing class AccountContactRecordCreator 
{
    /**
     * 
     * @param accfromtrigger - this stores an account that is passed from trigger
     * @returns - no return
     * @description - method to create two contact records under an account record  
     */
    public static void createTwoContacts(Account accfromtrigger) 
    {
            List<Contact> listName = new List<Contact>();
            //AllowContactCreation__c err = new AllowContactCreation__c();
            System.debug('==<><>== '+ AllowContactCreation__c.getInstance().CheckboxField__c);
        if(AllowContactCreation__c.getInstance().CheckboxField__c == true)
        {
            for (Integer i = 0; i < 2; i++) 
            {
                System.debug('inside if');
                Contact c = new Contact(LastName = accfromtrigger.Name,
                                            Email = accfromtrigger.Account_Email__c,
                                            AccountId = accfromtrigger.Id,
                                            Phone = accfromtrigger.Phone);

                listName.add(c);
            }
        } 
        else
        {
            throw new AuraHandledException('Sorry!! Something went wrong in creating Contacts: ');
        }
        INSERT listname;
         
    }
}
