public class AccountHandler 
{
    public static Account insertNewAccount(String acname) 
    {
        try 
        {
            Account acrecord = new Account(Name = acname);
            INSERT acrecord;
            return acrecord;
        } 
        catch (Exception e) 
        {
            return null;
        }
    }
}