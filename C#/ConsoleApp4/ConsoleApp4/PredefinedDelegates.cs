namespace ConsoleApp4;

public class PredefinedDelegates
{
    //0 1 1 2 3 5 8 ..
    private void Fibonacci(int length)
    {
        int a = 0;
        int b = 1;
        int c = 0;
        for (int i = 0; i < length; i++)
        {
            Console.Write(a + " ");
            c = a + b;
            a = b;
            b = c;
        }
    }

    public void ActionExample()
    {
        //Action<int> fib = new Action<int>(Fibonacci);
        //=> lambda operator
        Action<int> fib = length =>
        {
            int a = 0;
            int b = 1;
            int c = 0;
            for (int i = 0; i < length; i++)
            {
                Console.Write(a + " ");
                c = a + b;
                a = b;
                b = c;
            }
        };
        fib(10);
    }
    
    //abba - true, abcd - false
    public void PredicateExample()
    {
        Predicate<string> palindrome = str =>
        {
            for (int i = 0, j = str.Length - 1; i < j; i++, j--)
            {
                if (str[i] != str[j])
                {
                    return false;
                }
            }
            return true;
        };
        Console.WriteLine(palindrome("LEVEL"));
    }

    public void FuncExample()
    {
        Func<int, string> factorial = number =>
        {
            int f = 1;
            for (int i = number; i > 1; i--)
            {
                f *= i;
            }
            return f.ToString();
        };
        Console.WriteLine(factorial(5));
    }
}