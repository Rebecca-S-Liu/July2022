using ConsoleApp3.DataModel;

namespace ConsoleApp3.Repository;

public class CustomerRepository : IRepository<Customer>
{
    private List<Customer> lstCustomer = new List<Customer>();
    
    public int Insert(Customer obj)
    {
        lstCustomer.Add(obj);
        return 1;
    }

    public int Update(Customer obj)
    {
        Customer c = GetById(obj.Id);
        if (c != null)
        {
            c.Id = obj.Id;
            c.Name = obj.Name;
            c.Email = obj.Email;
            return 1;
        }
        return 0;
    }

    public int Delete(int id)
    {
        Customer c = GetById(id);
        if (c != null)
        {
            lstCustomer.Remove(c);
            return 1;
        }
        return 0;
    }

    public List<Customer> GetAll()
    {
        return lstCustomer;
    }

    public Customer GetById(int id)
    {
        for (int i = 0; i < lstCustomer.Count; i++)
        {
            if (lstCustomer[i].Id == id)
            {
                return lstCustomer[i];
            }
        }

        return null;
    }
}