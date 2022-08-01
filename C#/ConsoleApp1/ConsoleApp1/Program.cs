// See https://aka.ms/new-console-template for more information

// int a = 10;
// Console.WriteLine("The value for a is " + a);
//
// double b = 2.23523;
// Console.WriteLine($"The value for b is {b}");
//
// //visual studio: cw tab twice
//
// float c = 3.2352f;
// Console.WriteLine(c);
//
// decimal m = 4.2352m;
// Console.WriteLine(m);
//
// string s = "null";
// Console.WriteLine(s);
//
// bool flag = true;
// Console.WriteLine(flag);

// using System.Text;
//
// string s = "hello World";
// //s[0] = 'H';
// StringBuilder sb = new StringBuilder("hello World");
// Console.WriteLine($"before change: sb = {sb}");
// sb[0] = 'H';
// Console.WriteLine($"after change: sb = {sb}");

// int sunday = 1;
// int monday = 2;
// int tuesday = 3;
// int wednesday = 4;
// int thursday = 5;
// int friday = 6;
// int saturday = 7;
//
// int dayOfWeek = 2;
// if (dayOfWeek == 2)
// {
//     Console.WriteLine("It's Monday");
// }
//
// DayOfWeek today = DayOfWeek.Monday;
// Console.WriteLine(today);
//
// int a = 10;
// string str = a.ToString();

using ConsoleApp1;

ParamPassing demo = new ParamPassing();
// int x = 10;
// int y = 30;
// Console.WriteLine($"before calling passing by value: x = {x}, y = {y}");
// demo.PassingByValue(x, y);
// Console.WriteLine($"after calling passing by value: x = {x}, y = {y}");
//
// Console.WriteLine("-----------------");
// Console.WriteLine($"before calling passing by reference: x = {x}, y = {y}");
// demo.PassingByReference(ref x, ref y );
// Console.WriteLine($"after calling passing by reference: x = {x}, y = {y}");

// demo.AreaOfCircle(10);
// demo.AreaOfCircle(10,3);
// string str;
// Console.WriteLine(demo.IsAuthentic("rebecca", "liu", out str));
// Console.WriteLine(str);

Console.WriteLine(demo.AddNumbers(1,2,3,4));
Console.WriteLine(demo.AddNumbers(1,2));

demo.AddTwoNumbers(1,2);
