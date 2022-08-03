namespace ConsoleApp3;

public static class ExtensionMethodDemo
{
    public static string EvenOrOdd(this int number)
    {
        if (number % 2 == 0)
        {
            return "Even";
        }

        return "Odd";
    }
}