public class KeyContactBatch implements Database.Batchable<sObject>,Schedulable
{
    //Declaring Instance variable that has he 3 records types of account
    public List<String> keytype = new List<String>{'Prospect','Ignite','Sales'};
        
    ////Declaring Instance variable to store Emails of Key Contacts    
    public List<String> keyemail = new List<String>();
    
    
    //start() returns the keycontacts
    public Database.QueryLocator start(Database.BatchableContext BC)
    { 
        //Fetching and Returning All Key Contacts 
        return Database.getQueryLocator([SELECT Type__c, Notification__c, Email__c
                                         FROM Key_Contact__c
                                        WHERE Type__c IN : keytype]);
    }
    
    
    //execute() updates the changes in Key Contacts
    public void execute(Database.BatchableContext BC, List<Key_Contact__c> keycontactlist)
    {
        for(Key_Contact__c i : keycontactlist)
        {
            if(i.Notification__c == false) // if Notification is unchecked the below if-block runs
            {
                keyemail.add(i.Email__c);
                Messaging.SingleEmailMessage mail= new Messaging.SingleEmailMessage();
        		mail.setToAddresses(keyemail);
        		mail.setSubject('Batch Completed');
       			mail.setPlainTextBody(' The Job is started and Completed Successfully! ');
        		Messaging.SendEmailResult[] result = Messaging.sendEmail(new Messaging.SingleEmailMessage[]{mail});
                //if(result.isSuccess())
                if(!result.isEmpty())
                {
                    i.Notification__c = true; 
                }
                keyemail.clear();
                
            }
        }
        
        UPDATE keycontactlist; // update the Key Contacts
        
        /*//Below code is to send emails to the email ids stored into the list "keyemail"
        Messaging.SingleEmailMessage mail= new Messaging.SingleEmailMessage();
        mail.setToAddresses(keyemail);
        mail.setSubject('Batch Completed');
        mail.setPlainTextBody(' The Job is started and completed successfully! ');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{mail});*/
    }
    
    public void finish(Database.BatchableContext BC)
    {
        //The following code sends a mail to all the key contacts 

   /*===================================================================================================   
     |
     |  /*keyemail = [SELECT Email__c,AccoutId__c 
     |               FROM Key_Contact__c 
     |               WHERE Type__c IN : keytype];
     |   
     |   /*for(String e:keyemail)
     |   {
     |       String [] toAddress= new String[]{e.Email__c};
     |       mail.setToAddresses(toAddress) ;
     |       mail.setSubject('Batch Completed');
     |       mail.setPlainTextBody(e.AccoutId__c+' The Job is started and completed successfully! '+toAddress);
     |       Messaging.sendEmail(new Messaging.SingleEmailMessage[]{mail});
     |   }*
     |=====================================================================================================*/  
    }
    
    
    //execute(SchedulableContext) to run the batch class everyday at 10AM 
    public void execute(SchedulableContext sc)
    {	
       KeyContactBatch batchable = new KeyContactBatch();
       Database.executeBatch(batchable);
    }

} //End of Batch Class