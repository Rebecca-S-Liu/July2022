namespace ConsoleApp2;

public abstract class Employee
{
    public int Id { get; set; }
    public string Name { get; set; }
    public string Email { get; set; }
    public string Phone { get; set; }
    public string Address { get; set; }

    public Employee()
    {
        
    }
    public abstract void PerformWork();
    public virtual void VirtualMethodDemo()
    {
        Console.WriteLine("This is the virtual method from base class");
    }
}

public class FullTimeEmployee : Employee
{
    public decimal BiweeklyPay { get; set; }
    public string Benefits { get; set; }

    public FullTimeEmployee()
    {
        
    }
    public override void PerformWork()
    {
        //base.PerformWork();
        Console.WriteLine("Full time employees work 40 hrs per week");
    }

    public override void VirtualMethodDemo()
    {
        //base.VirtualMethodDemo();
        Console.WriteLine("This is an override from full time employee class");
    }
}

public class Manager : FullTimeEmployee
{
    public decimal ExtraBonus { get; set; }
    
    public void AttendMeeting()
    {
        Console.WriteLine("Managers must attend meetings");
    }
}

public sealed class PartTimeEmployee : Employee
{
    public decimal HourlyPay { get; set; }
    public override void PerformWork()
    {
        //base.PerformWork();
        Console.WriteLine("Part time employees work 20 hrs per week");
    }
}

// public class Test : PartTimeEmployee
// {
//     
// }