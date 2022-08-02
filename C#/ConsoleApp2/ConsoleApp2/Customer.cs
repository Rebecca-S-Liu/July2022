namespace ConsoleApp2;

public class Customer
{
    //full version of property: private data field + get and set methods
    private string name;
    
    public string Name
    {
        get
        {
            return name;
        }
        set
        {
            name = value;
        }
    }

    private int id;

    public int Id
    {
        get
        {
            return id;
        }
        private set
        {
            id = value;
        }
    }
    
    //private int id;
    //public int id;
    

    //public string name;
    //auto-generated properties
    //public string Name { get; set; }

    public string Email { get; set; }
    public string Phone { get; set; }

    public Customer(int id, string name, string email)
    {
        Id = id;
        Name = name;
        Email = email;
    }

    public Customer(int id, string name, string email, string phone)
    {
        Id = id;
        Name = name;
        Email = email;
        Phone = phone;
    }
    
}