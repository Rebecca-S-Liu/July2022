use Northwind
GO
--SELECT statement: identify which columns we want to retrieve
--1. SELECT all columns and rows
SELECT *
FROM Employees

--2. SELECT a list of columns
SELECT EmployeeID, FirstName, LastName, Title, ReportsTo
FROM Employees

SELECT e.EmployeeID, e.FirstName, e.LastName, e.Title, e.ReportsTo
FROM Employees e

--avoid using SELECT *
--1. unnecessary data
--2.name conflicts
SELECT *
FROM Customers

SELECT *
FROM Employees

SELECT *
FROM Employees e JOIN Orders o ON e.EmployeeID = o.EmployeeID JOIN Customers c ON o.CustomerID = c.CustomerID

--3. SELECT DISTINCT Value: list all the cities that employees located at
SELECT City
FROM Employees

SELECT DISTINCT City
FROM Employees

--4. SELECT combined with plain text: retrieve the full name of employees
SELECT FirstName + ' ' + LastName FullName
FROM Employees

--identifiers: names we give to db, tables, columns, sp.
--1) regular identifier
    --a.first char: a-z, A-Z, @, #
    --use @ for declaring a local variable
    DECLARE @num INT
    SELECT @num = 1
    PRINT @num

    PRINT @num
    --use # for creating temp tables
    --b.subsequent char: a-z, 0-9, @, $, #, _
    --c.identifier must not be a sql reserved word, both uppercase and lowercase
    SELECT MAX, AVG
    FROM TABLE
    --d.embedded space are not allowed
--2) delimited identifier: [] ""
SELECT FirstName + ' ' + LastName "Full Name"
FROM Employees

SELECT *
FROM [Order Details]


--WHERE statement: filter records
--1. equal =
--Customers who are from Germany
SELECT ContactName, Country
FROM Customers
WHERE Country = 'Germany'
--Product which price is $18
SELECT ProductName, UnitPrice
FROM [Products]
WHERE UnitPrice = 18
--2. Customers who are not from UK
SELECT ContactName, Country
FROM Customers
WHERE Country != 'UK'

SELECT ContactName, Country
FROM Customers
WHERE Country <> 'UK'

--IN Operator:retrieve among a list of values
--E.g: Orders that ship to USA AND Canada
SELECT OrderID, CustomerID, ShipCountry
FROM Orders
WHERE ShipCountry = 'USA' OR ShipCountry = 'Canada'

SELECT OrderID, CustomerID, ShipCountry
FROM Orders
WHERE ShipCountry IN ('USA', 'Canada')

--BETWEEN Operator: retreive in a consecutive range, inclusive
--1. retreive products whose price is between 20 and 30.
SELECT ProductName, UnitPrice
FROM Products
WHERE UnitPrice >= 20 AND UnitPrice <= 30

SELECT ProductName, UnitPrice
FROM Products
WHERE UnitPrice BETWEEN 20 AND 30

--NOT Operator: display a record if the condition is NOT TRUE
-- list orders that does not ship to USA or Canada
SELECT OrderID, CustomerID, ShipCountry
FROM Orders
WHERE ShipCountry NOT IN ('USA', 'Canada')

SELECT OrderID, CustomerID, ShipCountry
FROM Orders
WHERE NOT ShipCountry IN ('USA', 'Canada')

SELECT ProductName, UnitPrice
FROM Products
WHERE UnitPrice NOT BETWEEN 20 AND 30

SELECT ProductName, UnitPrice
FROM Products
WHERE NOT UnitPrice BETWEEN 20 AND 30

--NULL Value: a field with no value
--check which employees' region information is empty
SELECT EmployeeID, FirstName, LastName, Region
FROM Employees
WHERE Region is null

--exclude the employees whose region is null
SELECT EmployeeID, FirstName, LastName, Region
FROM Employees
WHERE Region is not null

--Null in numerical operation
CREATE TABLE TestSalary(EId int primary key identity(1,1), Salary money, Comm money)
INSERT INTO TestSalary VALUES(2000, 500), (2000, NULL),(1500, 500),(2000, 0),(NULL, 500),(NULL,NULL)

SELECT *
FROM TestSalary

SELECT EId, Salary, Comm, ISNULL(Salary,0) + ISNULL(Comm,0) [TotalCompensation]
FROM TestSalary

--LIKE Operator: create a search expression
--1. Work with % wildcard character: % substitute to 0 or more chars
--retrieve all the employees whose last name starts with D
SELECT FirstName, LastName
FROM Employees
WHERE LastName LIKE 'D%'

--2. Work with [] and % to search in ranges: find customers whose postal code starts with number between 0 and 3
SELECT ContactName, PostalCode
FROM Customers
WHERE PostalCode LIKE '[0-3]%'

--3. Work with NOT: 
SELECT ContactName, PostalCode
FROM Customers
WHERE PostalCode NOT LIKE '[0-3]%'

--4. Work with ^: any characters not in the brackets
SELECT ContactName, PostalCode
FROM Customers
WHERE PostalCode LIKE '[^0-3]%'

--Custermer name starting from letter A but not followed by l-n
SELECT ContactName, City
FROM Customers
WHERE ContactName LIKE 'A[^l-n]%'

--ORDER BY statement: sort the result set in ascending or descending order
--1. retrieve all customers except those in Boston and sort by Name
SELECT ContactName, City
FROM Customers
WHERE City != 'Boston'
ORDER BY ContactName 


--2. retrieve product name and unit price, and sort by unit price in descending order
SELECT ProductName, UnitPrice
FROM Products
ORDER BY UnitPrice DESC

--3. Order by multiple columns
SELECT ProductName, UnitPrice
FROM Products
ORDER BY UnitPrice DESC, ProductName DESC

SELECT ProductName, UnitPrice
FROM Products
ORDER BY 2 DESC, 1 DESC

--JOIN: combine rows from two or more tables, based on a related column between them
--1. INNER JOIN: will return the records that have matching values in both tables
--find employees who have deal with any orders
SELECT e.EmployeeID, e.FirstName + ' ' + e.LastName as [Full Name], o.OrderDate
FROM Employees AS e INNER JOIN Orders AS o ON e.EmployeeID = o.EmployeeID

SELECT e.EmployeeID, e.FirstName + ' ' + e.LastName as [Full Name], o.OrderDate
FROM Employees AS e JOIN Orders AS o ON e.EmployeeID = o.EmployeeID

SELECT e.EmployeeID, e.FirstName + ' ' + e.LastName as [Full Name], o.OrderDate
FROM Employees AS e, Orders AS o
WHERE e.EmployeeID = o.EmployeeID
--get cusotmers information and corresponding order date
SELECT c.ContactName, c.City, c.Country, o.OrderDate
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID

--join multiple tables:
--get customer name, the corresponding employee who is responsible for this order, and the order date
SELECT c.ContactName as Customer, e.FirstName + ' ' + e.LastName as Employee, o.OrderDate
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID INNER JOIN Employees e ON e.EmployeeID = o.EmployeeID

--add detailed information about quantity and price, join Order details
SELECT c.ContactName as Customer, e.FirstName + ' ' + e.LastName as Employee, o.OrderDate, od.Quantity, od.UnitPrice
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID INNER JOIN Employees e ON e.EmployeeID = o.EmployeeID INNER JOIN [Order Details] od ON od.OrderID = o.OrderID

--2. OUTER JOIN
--1) LEFT OUTER JOIN: return all records from the left table, and matching records from the right table, for the non-matched records in the right table, null will be returned
--list all customers whether they have made any purchase or not
SELECT c.ContactName, o.OrderID
FROM Customers AS c LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
ORDER BY o.OrderID

SELECT c.ContactName, o.OrderID
FROM Customers AS c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
ORDER BY o.OrderID

--JOIN with WHERE: find out customers who have never placed any order
SELECT c.ContactName, o.OrderID
FROM Customers AS c LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL

--2) RIGHT OUTER JOIN: return all records from the right table, and matching records from the left table. If not matching, return null
SELECT c.ContactName, o.OrderID
FROM Orders o RIGHT JOIN Customers c ON c.CustomerID = o.CustomerID
ORDER BY o.OrderID

--3) FULL OUTER JOIN: return all rows from both left and right table with null values if the condition didnt meet
--Match all customers and suppliers by country.
SELECT c.ContactName AS Customer, c.Country AS CustomerCountry, s.Country AS SupplierCountry, s.ContactName AS Supplier
FROM Customers c FULL JOIN Suppliers s ON c.Country = s.Country
ORDER BY CustomerCountry, SupplierCountry

--3. CROSS JOIN: create the cartesian product of two tables
--table1: 10 rows, table2: 20 rows --> 200 rows
SELECT * 
FROM Customers c CROSS JOIN Orders o 

SELECT *
FROM Customers

SELECT *
FROM Orders

--* SELF JOIN： Join a table with itself -> choose either inner join or left join
SELECT EmployeeID, FirstName, LastName, ReportsTo
FROM Employees

--CEO: Andrew
--Manager: Nancy, Janet, Margaret, Steven, Laura
--Employee: Michael, Robert, Anne

--find emloyees with the their manager name
SELECT e.FirstName + ' ' + e.LastName AS Employee, m.FirstName + ' ' + m.LastName AS Manager
FROM Employees AS e INNER JOIN Employees AS m ON e.ReportsTo = m.EmployeeID

SELECT e.FirstName + ' ' + e.LastName AS Employee, ISNULL(m.FirstName + ' ' + m.LastName,'N/A') AS Manager
FROM Employees AS e LEFT JOIN Employees AS m ON e.ReportsTo = m.EmployeeID

--Batch Directives
CREATE DATABASE JulyBatch
GO
USE JulyBatch
GO
CREATE TABLE Employee(id int, EName varchar(20), Salary money)

SELECT *
FROM Employee