using ConsoleApp4.DataModel;
using ConsoleApp4.Repository;

namespace ConsoleApp4.Presentation;

public class ManageEmployee
{
    private EmployeeRepository _employeeRepository = new EmployeeRepository();

    public void Print()
    {
        List<Employee> employees = _employeeRepository.Search(emp => emp.Department == "IT" && emp.City == "Chicago");
        foreach (var employee in employees)
        {
            Console.WriteLine(employee.FullName + "\t" + employee.City + "\t" + employee.Department);
        }
    }
}