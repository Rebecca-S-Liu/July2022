// See https://aka.ms/new-console-template for more information

using ConsoleApp3;
using ConsoleApp3.Presentation;

// int a = 10;
// Console.WriteLine(a.EvenOrOdd());

// Console.WriteLine(GenericsDemo.AreEqual(12,12));
// Console.WriteLine(GenericsDemo.AreEqual("sdgusd",12.234));

//Console.WriteLine(GenericsDemo<int>.AreEqual(12,2));
//Console.WriteLine(GenericsDemo<string>.AreEqual("hello","world"));

ManageCustomer manageCustomer = new ManageCustomer();
manageCustomer.Run();