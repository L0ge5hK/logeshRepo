@isTest
private class ContactHandleTestClass 
{
    //static Account TestAcc= new Account(Name='MyTestAcc');

    @isTest
    static void insertionTesting() //checking only for Inserting contacts
    {
        Account testacc= new Account(Name='MyTestAcc'); //creating an account "TestAcc"
        INSERT testacc;

        //creatng a list of Contacts and Inserting 2 contacts
        List<Contact> contactListIns = new List<Contact>();
        for (Integer i = 0; i < 2; i++) 
        {
            contactListIns.add(new Contact(LastName = 'TestName'+i, AccountId=testacc.Id));
        }
        INSERT contactListIns;//2 contacts inserted
        
        //Checking if there are 2 contacts
        System.assertEquals(2, contactListIns.size(),'MAYBE WRONG!');
    }

    @isTest
    static void deletionTesting() //checking for deletion of 1 Contact
    {
        Account testacc= new Account(Name='MyTestAcc'); //creating an account "TestAcc"
        INSERT testacc;

        //creatng a list of Contacts and Inserting 2 contacts
        List<Contact> contactListDel =new List<Contact>(); 
        contactListDel.add(new Contact(LastName = 'TestNameDel1', AccountId=testacc.Id));
        contactListDel.add(new Contact(LastName = 'TestNameDel2', AccountId=testacc.Id));
        INSERT contactListDel; //2 Contacts Inserted

        //Fetching 1 particular contact and deleting it
        Contact delcontact=[SELECT Id from Contact WHERE LastName='TestNameDel2'];
        DELETE delcontact; //1 Contact deleted

        //Checkig the count of contacts available
        Integer contactcount=[SELECT COUNT() FROM Contact]; 
        System.assertEquals(1,contactcount,'MAYBE WRONG!');
    }

    @isTest
    static void testingCondition() //To check if 3 Contacts are deleting when you insert more than 3
    {
        Account testacc= new Account(Name='MyTestAcc'); //creating an account "TestAcc"
        INSERT testacc;
        // Inerting 5 Contacts
        Contact con1= new Contact(LastName='Contact1',AccountId=testacc.Id);
        INSERT con1;
        Contact con2= new Contact(LastName='Contact2',AccountId=testacc.Id);
        INSERT con2;
        Contact con3= new Contact(LastName='Contact3',AccountId=testacc.Id);
        INSERT con3;
        Contact con4= new Contact(LastName='Contact4',AccountId=testacc.Id);
        INSERT con4;
        Contact con5= new Contact(LastName='Contact5',AccountId=testacc.Id);
        INSERT con5;
        //Checking if 3 Contacts are deleted (by verifying if only 2 contacts are available)

        Integer contactcount=[SELECT COUNT() FROM Contact]; 
        System.assertEquals(2,contactcount,'MAYBE WRONG!');    
    }
}