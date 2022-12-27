/**
 * @author V Logesh Kumar
 * @param insert 
 * @return  `trigger`
 */
trigger AccountTriggerHandlerTwo on Account (after insert) 
{
    List<Contact> relatedcontact = new List<Contact>();
	for(Account a : trigger.new)
    {
        if(a.Type == 'Analyst' || a.Type == 'Prospect')
        {
            AccountContactRecordCreator.createTwoContacts(a);
        }
        else 
        {
            a.Type.addError('Please Specify Type as Prospect or Analyst');   
        }
    }
}