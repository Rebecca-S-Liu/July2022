// See https://aka.ms/new-console-template for more information

using ConsoleApp4;
using ConsoleApp4.Presentation;

// MathDelegate mathDelegate = new MathDelegate(ArithmeticOperations.Subtract);
// Console.WriteLine(mathDelegate(50,10));

// PredefinedDelegates predefinedDelegates = new PredefinedDelegates();
// predefinedDelegates.FuncExample();

// ManageEmployee manageEmployee = new ManageEmployee();
// manageEmployee.Print();

try
{
    Console.WriteLine("Enter first number: ");
    int num1 = Convert.ToInt32(Console.ReadLine());
    if (num1 < 0)
    {
        throw new NumberException();
    }

    Console.WriteLine("Enter second number: ");
    int num2 = Convert.ToInt32(Console.ReadLine());
    if (num2 < 0)
    {
        throw new NumberException();
    }

    Console.WriteLine("Enter operation ");
    string operation = Console.ReadLine();

    ExceptionHandlingDemo demo = new ExceptionHandlingDemo();
    Console.WriteLine(demo.Calculate(num1, num2, operation));
}
catch (DivideByZeroException ex)
{
    Console.WriteLine(ex.Message);
}
catch (ArgumentOutOfRangeException ex)
{
    Console.WriteLine(ex.Message);
}
catch (FormatException ex)
{
    Console.WriteLine(ex.Message);
}
catch (NumberException ex)
{
    Console.WriteLine(ex.Message);
}
catch (Exception ex)
{
    Console.WriteLine(ex.Message);
}
finally
{
    Console.WriteLine("Hello World");
}