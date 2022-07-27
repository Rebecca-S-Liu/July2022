--is null
SELECT Region
FROM Employees
WHERE Region is not null

--SELECT: retrieve
--WHERE: filter
--ORDER BY: sort
--JOIN: work on multiple tables in one query

--Aggregation functions: perform a calculation on a set of values and return a singled aggregated value
--1. COUNT():return the number of rows
SELECT COUNT(OrderID) as TotalNumOfOrders
FROM Orders 

SELECT COUNT(*)
FROM Orders

--COUNT(*) vs. COUNT(colName): 
--COUNT(*) will include null values, but COUNT(colName) will not
SELECT COUNT(Region), COUNT(*)
FROM Employees


--use w/ GROUP BY: group rows that have the same values into summary rows
--find total number of orders placed by each customers
SELECT c.CustomerID, c.ContactName, c.Country, COUNT(o.OrderID) as NumOfOrders
FROM Orders o INNER JOIN Customers c ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.ContactName, c.Country
ORDER BY NumOfOrders DESC

--a more complex template: 
--only retreive total order numbers where customers located in USA or Canada, and order number should be greater than or equal to 10
SELECT c.CustomerID, c.ContactName, c.Country, COUNT(o.OrderID) as NumOfOrders
FROM Orders o INNER JOIN Customers c ON c.CustomerID = o.CustomerID
WHERE c.Country IN ('USA', 'Canada')
GROUP BY c.CustomerID, c.ContactName, c.Country 
HAVING COUNT(o.OrderID) >= 10
ORDER BY NumOfOrders DESC

--SELECT fields, aggregate(field)
--FROM table JOIN table2 ON ...
--WHERE criteria -- optional 
--GROUP BY fields
--HAVING criteria --optional
--ORDER BY fileds DESC --optional


--WHERE vs. HAVING
--1. both are used as filters, HAVING will apply only to groups as a whole, and only filters on aggregation functions, but WHERE applies to individual rows
--2. WHERE goes before aggregation, but HAVING goes after aggregations
    --execution order
    --FROM/JOIN -> WHERE -> GROUP BY -> HAVING -> SELECT -> DISTINCT -> ORDER BY
    --             |__________________________|
    --              cannot use alias in SELECT

SELECT c.CustomerID, c.ContactName, c.Country AS Cty, COUNT(o.OrderID) as NumOfOrders
FROM Orders o INNER JOIN Customers c ON c.CustomerID = o.CustomerID
WHERE Cty IN ('USA', 'Canada')
GROUP BY c.CustomerID, c.ContactName, Cty
HAVING NumOfOrders >= 10
ORDER BY NumOfOrders DESC
--3. WHERE can be used with SELECT, UPDATE and DELETE, but HAVING can be used only in SELECT
SELECT *
FROM Products

UPDATE Products
SET UnitPrice = 20
WHERE ProductID = 1

--COUNT DISTINCT: only count unique values
SELECT City
FROM Customers

SELECT COUNT(City), COUNT(DISTINCT City)
FROM  Customers

--2. AVG(): return the average value of a numeric column
--list average revenue for each customer
SELECT c.CustomerID, c.ContactName, AVG(od.UnitPrice * od.Quantity) AS AvgRevenue
FROM [Order Details] od JOIN Orders o on o.OrderID = od.OrderID JOIN Customers c on c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.ContactName

--3. SUM(): 
--list sum of revenue for each customer
SELECT c.CustomerID, c.ContactName, SUM(od.UnitPrice * od.Quantity) AS SumRevenue
FROM [Order Details] od JOIN Orders o on o.OrderID = od.OrderID JOIN Customers c on c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.ContactName

--4. MAX(): 
--list maxinum revenue from each customer
SELECT c.CustomerID, c.ContactName, MAX(od.UnitPrice * od.Quantity) AS MaxRevenue
FROM [Order Details] od JOIN Orders o on o.OrderID = od.OrderID JOIN Customers c on c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.ContactName

--5.MIN(): 
--list the cheapeast product bought by each customer
SELECT c.CustomerID, c.ContactName, MIN(od.UnitPrice) AS CheapestProduct
FROM [Order Details] od JOIN Orders o ON od.OrderID = o.OrderID JOIN Customers c ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.ContactName

--TOP predicate: SELECT a spefic number or a certain percentage of records
--retrieve top 5 most expensive products
SELECT ProductName, UnitPrice
FROM Products
ORDER BY UnitPrice DESC

SELECT Top 5 ProductName, UnitPrice
FROM Products
ORDER BY UnitPrice DESC

--retrieve top 10 percent most expensive products
SELECT Top 10 PERCENT ProductName, UnitPrice
FROM Products
ORDER BY UnitPrice DESC

--list top 5 customers who created the most total revenue
SELECT TOP 5 c.CustomerID, c.ContactName, SUM(od.UnitPrice * od.Quantity) AS SumRevenue
FROM [Order Details] od JOIN Orders o on o.OrderID = od.OrderID JOIN Customers c on c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.ContactName
ORDER BY SumRevenue DESC

--limit 

--Subquery: a SELECT statement that is embedded in anotehr sql statement
--find the customers from the same city where Alejandra Camino lives 
SELECT ContactName, City
FROM Customers
WHERE City IN (
    SELECT City
    FROM Customers
    WHERE ContactName = 'Alejandra Camino'

)
--find customers who make any orders
--join
SELECT DISTINCT c.CustomerID, c.ContactName, c.City, C.Country
FROM Customers c INNER JOIN Orders o ON c.CustomerID = O.CustomerID

--subquery
SELECT CustomerID, ContactName, City, Country
FROM Customers
WHERE CustomerID IN (
    SELECT DISTINCT CustomerID
    FROM Orders
)

--subquery vs. join
--1) JOIN can only be used in FROM cluase, but Subquery can be used in SELECT, WHERE, HAVING ,FROM, ORDER BY
--list all the order data and the corresponding employee whose in charge of this order
--join
SELECT o.OrderDate, e.FirstName, e.LastName
FROM Orders o JOIN Employees e ON e.EmployeeID = O.EmployeeID
WHERE e.City = 'London'
ORDER BY o.OrderDate, e.FirstName, e.LastName

--subqery
SELECT o.OrderDate,
(SELECT e1.FirstName FROM Employees e1 WHERE o.EmployeeID = e1.EmployeeID) as FirstName,
(SELECT e2.LastName FROM Employees e2 WHERE o.EmployeeID = e2.EmployeeID) as LastName
FROM Orders o 
WHERE (
    SELECT e3.City
    FROM Employees e3
    WHERE e3.EmployeeID = o.EmployeeID
) IN ('London')
ORDER BY o.OrderDate, (SELECT e1.FirstName FROM Employees e1 WHERE o.EmployeeID = e1.EmployeeID), (SELECT e2.LastName FROM Employees e2 WHERE o.EmployeeID = e2.EmployeeID)

--2) subquery is easy to understand and maintain
--find customers who never placed any order
--join
SELECT c.CustomerID, c.ContactName, c.City, c.Country
FROM Customers c LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE O.OrderID IS NULL
--subquery
SELECT CustomerID, ContactName, City, Country
FROM Customers
WHERE CustomerID NOT IN (
    SELECT DISTINCT CustomerID
    FROM Orders 
)

--3) usually join has a better performance

--Correlated Subquery: inner query is dependent on the outer query
--Customer name and total number of orders by customer
--join
SELECT c.ContactName, count(o.OrderID) TotalNumOfOrders
FROM Customers c LEFT JOIN Orders o ON c.CustomerID = O.CustomerID
GROUP BY c.ContactName
ORDER BY TotalNumOfOrders DESC

--corrlated subqury
SELECT c.ContactName,
(SELECT count(o.OrderID)
FROM Orders o where C.CustomerID = O.CustomerID) as TotalNumOfOrders
FROM Customers c
ORDER BY TotalNumOfOrders DESC

SELECT o.OrderDate,
(SELECT e1.FirstName FROM Employees e1 WHERE e1.EmployeeID = o.EmployeeID) FirstName,
(SELECT e2.LastName FROM Employees e2 WHERE e2.EmployeeID = o.EmployeeID) LastName
FROM Orders o 
ORDER BY FirstName, OrderDate

SELECT o.OrderDate, e.FirstName, e.LastName
FROM Orders o JOIN Employees e ON e.EmployeeID = o.EmployeeID
ORDER BY FirstName, OrderDate

--derived table: subquery in from clause
--syntax
SELECT CustomerID, ContactName
FROM (SELECT *
FROM Customers) dt

--customers and the number of orders they made
SELECT c.ContactName, c.City, c.Country, COUNT(o.OrderID) AS TotalNumOfOrders
FROM Customers c LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.ContactName, c.City, c.Country
ORDER BY TotalNumOfOrders DESC

SELECT c.ContactName, c.City, c.Country, ISNULL(dt.NumOfOrders,0) AS NumOfOrders
FROM Customers c LEFT JOIN (SELECT CustomerID, COUNT(OrderID) NumOfOrders
FROM Orders 
GROUP BY CustomerID) dt ON c.CustomerID = dt.CustomerID
ORDER BY dt.NumOfOrders DESC

--Union vs. Union ALL: 
--common features:
--1.both are used to combine different result sets vertically
SELECT City, Country
FROM Customers

SELECT City, Country
FROM Employees

SELECT City, Country
FROM Customers
UNION 
SELECT City, Country
FROM Employees
ORDER BY City

SELECT City, Country
FROM Customers
UNION ALL
SELECT City, Country
FROM Employees
ORDER BY City
--2.criteria
--number of columns must be the same
SELECT City, Country, CustomerID
FROM Customers
UNION 
SELECT City, Country
FROM Employees
ORDER BY City
--data types of each column must be identical
SELECT City, Country, Region
FROM Customers
UNION 
SELECT City, Country, EmployeeID
FROM Employees
ORDER BY City
--differences
--1. UNION will remove duplicate values, UNION ALL will not
--2. UNION: the records from the first column will be sorted ascendingly automatically
SELECT City, Country
FROM Customers
UNION 
SELECT City, Country
FROM Employees

SELECT City, Country
FROM Customers
UNION ALL
SELECT City, Country
FROM Employees
--3.UNION cannot be used in recursive cte, but UNION ALL can


--Window Function: opearte on a set of rows and return a single aggregated avlue for each row by adding extra column
--RANK(): give a rank based on certain order
--rank for product price, when there is a tie, there will be a value gap
SELECT ProductID, ProductName, UnitPrice, RANK() OVER (ORDER BY UnitPrice) RNK
FROM Products

--product with the 2nd highest price 
SELECT dt.ProductID, dt.ProductName, dt.UnitPrice, dt.RNK
FROM (SELECT ProductID, ProductName, UnitPrice, RANK() OVER (ORDER BY UnitPrice DESC) RNK
FROM Products) dt
WHERE dt.rnk = 2


--DENSE_RANK(): 
SELECT ProductID, ProductName, UnitPrice, RANK() OVER (ORDER BY UnitPrice) RNK, DENSE_RANK() OVER (ORDER BY UnitPrice) DENSErnk
FROM Products

--ROW_NUMBER(): return the row number of the sorted records starting from 1
SELECT ProductID, ProductName, UnitPrice, RANK() OVER (ORDER BY UnitPrice) RNK, DENSE_RANK() OVER (ORDER BY UnitPrice) DENSErnk, ROW_NUMBER() OVER (ORDER BY UnitPrice) RowNum
FROM Products

--partition by: divde the result set into partitions and peform calculations on each subset of partitioned data
--list customers from every country with the ranking for number of orders
SELECT c.ContactName, C.Country, count(o.OrderID) AS NumOfOrders, RANK() OVER(PARTITION BY c.Country ORDER BY count(o.OrderID) desc) RNK
FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.ContactName, C.Country

--- find top 3 customers from every country with maximum orders
SELECT dt.ContactName, DT.Country, dt.NumOfOrders, dt.RNK
FROM (SELECT c.ContactName, C.Country, count(o.OrderID) AS NumOfOrders, RANK() OVER(PARTITION BY c.Country ORDER BY count(o.OrderID) desc) RNK
FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.ContactName, C.Country) dt
WHERE dt.RNK <= 3

--cte: common table expression
SELECT c.ContactName, c.City, c.Country, ISNULL(dt.NumOfOrders,0) AS NumOfOrders
FROM Customers c LEFT JOIN (SELECT CustomerID, COUNT(OrderID) NumOfOrders
FROM Orders 
GROUP BY CustomerID) dt ON c.CustomerID = dt.CustomerID
ORDER BY dt.NumOfOrders DESC

WITH OrderCntCTE
AS
(
    SELECT CustomerID, COUNT(OrderID) NumOfOrders
    FROM Orders 
    GROUP BY CustomerID
)
SELECT c.ContactName, c.City, c.Country, cte.NumOfOrders
FROM Customers c LEFT JOIN OrderCntCTE cte ON c.CustomerID = cte.CustomerID
ORDER BY cte.NumOfOrders desc


--lifecycle: has to be created and used in the next select statement

--recursive CTE: 
--initialization: initial call to the cte which passes in some values to get things started
--recursive rule

SELECT EmployeeID, FirstName, ReportsTo
FROM Employees

-- level 1: Andrew
-- level 2: Nancy, Janet, Margaret, Steven, Laura
-- level 3: Michael, Robert, Anne

WITH empHierachyCte
AS
(
    SELECT EmployeeID, FirstName, ReportsTo, 1 lvl
    FROM Employees
    WHERE ReportsTo is null
    UNION ALL
    SELECT e.EmployeeID, e.FirstName, e.ReportsTo, cte.lvl + 1
    FROM Employees e INNER JOIN empHierachyCte cte ON e.ReportsTo = cte.EmployeeId
)
SELECT * FROM empHierachyCte