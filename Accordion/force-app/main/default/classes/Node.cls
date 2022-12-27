/**
 * Created a Node Class
 */

public with sharing class Node 
{
    //Data Members
    public Object data { get; private set; }
    public Node next;
  
    //Constructor
    public Node(Object data) 
    {
      this.data = data;
    }
  }