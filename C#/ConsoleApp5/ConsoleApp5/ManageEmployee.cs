namespace ConsoleApp5;

public class ManageEmployee
{
    private EmployeeRepository _employeeRepository = new EmployeeRepository();

    private Employee Demo(Employee employee)
    {
        return employee;
    }
    private void SelectDemo()
    {
        //SELECT * FROM Employees
        //query syntax
        // var result = from employee in _employeeRepository.GetEmployees()
        //                                 select employee;
        //method syntax
        //var result = _employeeRepository.GetEmployees().Select(emp => emp);
        // var result = _employeeRepository.GetEmployees().Select(Demo);
        // foreach (var employee in result)
        // {
        //     Console.WriteLine(employee.Id + "\t" + employee.FullName + "\t" + employee.Salary + "\t" + employee.Department + "\t" + employee.Age);
        // }
        
        //query syntax
        // var result = from employee in _employeeRepository.GetEmployees()
        //     select employee.FullName;
        
        //method syntax
        // var result = _employeeRepository.GetEmployees().Select(emp => emp.FullName);
        // foreach (var name in result)
        // {
        //     Console.WriteLine(name);
        // }
        
        //query syntax
        // var result = from employee in _employeeRepository.GetEmployees()
        //     select new
        //     {
        //         Id = employee.Id,
        //         FullName = employee.FullName,
        //         Department = employee.Department
        //     };
        
        //method syntax
        // var result = _employeeRepository.GetEmployees().Select(emp => new
        // {
        //     Id = emp.Id,
        //     FullName = emp.FullName,
        //     Department = emp.Department
        // });
        // foreach (var employee in result)
        // {
        //     Console.WriteLine(employee.Id + "\t" + employee.FullName + "\t" + employee.Department);
        // }

        // var result = (from employee in _employeeRepository.GetEmployees()
        //     select employee.Department).Distinct();

        // var result = _employeeRepository.GetEmployees().Select(emp => emp.Department).Distinct();
        // foreach (var dept in result)
        // {
        //     Console.WriteLine(dept);
        // }

        var result = _employeeRepository.GetEmployees().Select(x => new
        {
            Id = x.Id,
            FullName = x.FullName,
            Department = x.Department
        }).SingleOrDefault(x => x.Department == "sdgaosdug") ?? new {Id = -1, FullName = "N/A", Department = "N/A"};
        Console.WriteLine(result.Id + "\t" + result.FullName + "\t" + result.Department);

    }

    private void OrderByDemo()
    {
        //query syntax
        // var result = from employee in _employeeRepository.GetEmployees()
        //     orderby employee.Salary descending, employee.FullName  
        //     select new
        //     {
        //         Id = employee.Id,
        //         FullName = employee.FullName,
        //         Salary = employee.Salary
        //     };

        //method syntax
        var result = _employeeRepository.GetEmployees().OrderByDescending(emp => emp.Salary).ThenByDescending(emp => emp.FullName).ThenBy(x => x.Id).Select(x => new
        {
            Id = x.Id,
            FullName = x.FullName,
            Salary = x.Salary
        });
        
        foreach (var employee in result)
        {
            Console.WriteLine(employee.Id + "\t" + employee.FullName + "\t" + employee.Salary);
        }
    }

    private void WhereDemo()
    {
        //query syntax
        // var result = from employee in _employeeRepository.GetEmployees()
        //     where employee.Salary > 7000 
        //     select new
        //     {
        //         Id = employee.Id,
        //         FullName = employee.FullName,
        //         Salary = employee.Salary
        //     };
        
            //method syntax
            var result = _employeeRepository.GetEmployees().Where(emp => emp.Salary > 7000 && emp.Department == "Sales").Select(x => new
            {
                Id = x.Id,
                FullName = x.FullName,
                Salary = x.Salary
            });
        foreach (var employee in result)
        {
            Console.WriteLine(employee.Id + "\t" + employee.FullName + "\t" + employee.Salary);
        }
    }

    private void GroupByDemo()
    {
        //query syntax
        // var result = from employee in _employeeRepository.GetEmployees()
        //     group employee by employee.Department;
        //method syntax
        var result = _employeeRepository.GetEmployees().GroupBy(emp => emp.Department);
        foreach (var itemGroup in result)
        {
            Console.WriteLine($"{itemGroup.Key} Department");
            foreach (var emp in itemGroup)
            {
                Console.WriteLine($"Emplooyee: {emp.FullName}");
            }
            Console.WriteLine();
        }

    }

    
    
    private void QuantifierDemo()
    {
        var result = _employeeRepository.GetEmployees().All(x => x.Salary >= 5000);
        Console.WriteLine(result);
    }

    private void AggregationDemo()
    {
        // var result = _employeeRepository.GetEmployees().Average(x => x.Salary);
        // Console.WriteLine(result);

        var result = _employeeRepository.GetEmployees().GroupBy(x => x.Department).Select(x => new
        {
            Department = x.Key,
            TotalSalary = x.Sum(emp => emp.Salary),
            AverageSalary = Math.Round(x.Average(emp => emp.Salary), 2)
        });
        foreach (var item in result)
        {
            Console.WriteLine(item.Department + "\t" + item.TotalSalary + "\t" + item.AverageSalary);
        }
    }
    
    public void Run()
    {
        AggregationDemo();
    }
}