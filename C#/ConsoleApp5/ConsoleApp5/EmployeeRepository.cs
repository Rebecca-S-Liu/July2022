namespace ConsoleApp5;

public class EmployeeRepository
{
    public List<Employee> GetEmployees()
    {
        return new List<Employee>
        {
            new Employee() {Id = 1, FullName = "Fred", Salary = 5000, Department = "IT", Age = 30},
            new Employee() {Id = 2, FullName = "Laura", Salary = 7000, Department = "HR", Age = 56},
            new Employee() {Id = 3, FullName = "Amy", Salary = 5500, Department = "IT", Age = 32},
            new Employee() {Id = 4, FullName = "Sam", Salary = 7000, Department = "IT", Age = 50},
            new Employee() {Id = 5, FullName = "Peter", Salary = 6000, Department = "HR", Age = 38},
            new Employee() {Id = 6, FullName = "Gary", Salary = 5700, Department = "Marketing", Age = 30},
            new Employee() {Id = 7, FullName = "Fiona", Salary = 8600, Department = "Sales", Age = 32}
        };
    }

}