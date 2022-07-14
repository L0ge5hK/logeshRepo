public class StringArrayTest {
    public static String[] generateStringArray(Integer size)
    {
        //List<String> sl=new List<String>();
        String[] sl=new String[size];
        for(Integer s=0;s<size;s++)
        {
            sl[s]=('Test'+s);
        }

        return sl;
    }
}