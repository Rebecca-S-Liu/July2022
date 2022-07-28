--aggregation function + group by
--subquery
--union and union all
--window function
--cte

--temporary table: are a special type of table so that we can store data temporarily
--# -> local temp table: 
CREATE TABLE #LocalTemp(
    Number int
)
DECLARE @Variable INT = 1
WHILE (@Variable <= 10)
BEGIN
INSERT INTO #LocalTemp(Number) VALUES(@Variable)
SET @Variable = @Variable  + 1
END

SELECT *
FROM #LocalTemp

select * from tempdb.sys.tables
--## -> global temp objects
CREATE TABLE ##GlobalTemp(
    Number int
)
DECLARE @Num INT = 1
WHILE (@Num <= 10)
BEGIN
INSERT INTO ##GlobalTemp(Number) VALUES(@Num)
SET @Num = @Num  + 1
END

SELECT *
FROM ##GlobalTemp


--table variable:
DECLARE @digit INT
SELECT @digit = 1
PRINT @digit

DECLARE @WeekDays Table (DayNum int, DayAbb varchar(20), WeekName varchar(20))
INSERT INTO @WeekDays
VALUES
(1,'Mon','Monday')  ,
(2,'Tue','Tuesday') ,
(3,'Wed','Wednesday') ,
(4,'Thu','Thursday'),
(5,'Fri','Friday'),
(6,'Sat','Saturday'),
(7,'Sun','Sunday')	
SELECT * FROM @WeekDays
select * from tempdb.sys.tables

--temp tables vs. table variables
--1. both are stored in tempdb
--2.scope: local/global, current batch
--3. size: > 100 rows, < 100 rows 
--4. do not use temp tables in stored procedures or user defined functions, but we can use table variables in sp, function


--view: VIRTUAL TABLE THAT CONTAINS DATA FROM ONE OR MULTIPLE TABLES
SELECT *
FROM Employee

INSERT INTO Employee
VALUES(1, 'Fred', 5000),(2, 'Laura', 7000), (3,'Amy', 6000)

GO

CREATE VIEW vwEmp
AS
SELECT Id, EName, Salary FROM Employee

GO

SELECT *
FROM vwEmp

--stored procedure: a prepared sql query that we can save in our db and reuse whenever we need
BEGIN
    print 'Hello Anynymous block'
END

GO

CREATE PROC spHello
AS
BEGIN
PRINT 'Hello Stored Procedure'
END

EXEC spHello

--sql injection: hackers inject some malicious code to our sql queries thus destroying our data
SELECT Id, UserName
FROM User
WHERE ID = 1 UNION SELECT id, Password from User 

GO

CREATE PROC spAddNumbers
@a int,
@b INT
AS
BEGIN
    PRINT @a + @b
END

EXEC spAddNumbers 10, 20

GO

CREATE PROC spGetName
@id INT,
@EName varchar(20) OUT
AS
BEGIN
    SELECT @EName = EName FROM Employee WHERE ID = @id
END

BEGIN
DECLARE @en varchar(20)
EXEC spGetName 2, @en out
PRINT @en
END

SELECT *
FROM Employee

GO

CREATE PROC spGetAllEmp
AS
BEGIN
SELECT Id,Ename,Salary
FROM Employee
END

EXEC spGetAllEmp


--Entity Framework core ORM

--TRIGGER
--DML triggers 
--DDL trigger
--logOn trigger

GO
--function
CREATE FUNCTION GetTotalRevenue(@price money, @discount real, @quantity smallint)
returns money
AS
BEGIN
    DECLARE @revenue money
    SET @revenue = @price * (1 - @discount) * @quantity
    RETURN @revenue
END

go

SELECT UnitPrice, Discount, Quantity, dbo.GetTotalRevenue(UnitPrice, Discount, Quantity) AS TotalRevenue
FROM [Order Details]

go 

CREATE FUNCTION expensiveProduct(@threshold money) 
RETURNS TABLE
AS
Return select *
        FROM Products
        WHERE UnitPrice > @threshold


GO

SELECT *
FROM dbo.expensiveProduct(10)

--sp vs. function
--usage: sp for DML, functions mainly for calculations
--how to call: sp will be  called by its name, functions must be used in sql statements
--input/ouput: sp may or may not have input/ouput. functions may or may not have input, but it has to have output
--sp can call function, but functions cannot call sp


--Pagination
--OFFSET -> skip 
--FETCH NEXT ROWS -> select 
SELECT CustomerID, ContactName, City
FROM Customers
ORDER BY CustomerID


SELECT CustomerID, ContactName, City
FROM Customers
ORDER BY CustomerID
OFFSET 10 ROWS
FETCH NEXT 10 ROWS ONLY

--2nd 
-- DECLARE @PageNum INT
-- DECLARE @RowsOfPage int 
-- SET @PageNum = 2
-- SET @RowsOfPage = 10
-- SELECT CustomerID, ContactName, City
-- FROM Customers
-- ORDER BY CustomerID
-- OFFSET (@PageNum - 1) * @RowsOfPage ROWS
-- FETCH NEXT @RowsOfPage ROWS ONLY

DECLARE @PageNum INT
DECLARE @RowsOfPage INT
DECLARE @MaxTablePage FLOAT
SET @PageNum = 1
SET @RowsOfPage = 10
SELECT @MaxTablePage = count(*) FROM Customers --91.0
SET @MaxTablePage = CEILING(@MaxTablePage / @RowsOfPage) --91.0/10 -9.1 -10
WHILE @PageNum <= @MaxTablePage
BEGIN
    SELECT CustomerID, ContactName, City
    FROM Customers
    ORDER BY CustomerID
    OFFSET (@PageNum - 1) * @RowsOfPage ROWS
    FETCH NEXT @RowsOfPage  ROWS ONLY
    SET @PageNum = @PageNum + 1
END


--constraints
drop TABLE Employee

CREATE TABLE Employee
(
    Id int,
    EName varchar(20),
    Age int
)

INSERT INTO Employee VALUES(1, 'Sam', 45)
INSERT INTO Employee VALUES(NULL, NULL, NULL)

DROP TABLE Employee

CREATE TABLE Employee
(
    Id int not null,
    EName varchar(20) not null,
    Age int
)

DROP TABLE Employee

CREATE TABLE Employee
(
    Id int UNIQUE,
    EName varchar(20) not null,
    Age int
)

INSERT INTO Employee VALUES(NULL, 'Fiona', 46)

SELECT *
FROM Employee


CREATE TABLE Employee
(
    Id int Primary Key,
    EName varchar(20) not null,
    Age int
)

--primary key vs. unique constrinat
--1. unique constraint can accept one and only one null value, but pk cannot accept any null value
--2. one table can have multiple unique keys but only one pk
--3. pk will sort the data by default, but unique key will not
--4.PK will by default create a clustered index, and unique key will create a non-clustered index
 DELETE Employee

 INSERT INTO Employee
VALUES(4, 'Fred', 45)

INSERT INTO Employee
VALUES(1, 'Laura', 34)

INSERT INTO Employee
VALUES(3, 'Peter', 19)

INSERT INTO Employee
VALUES(2, 'Stella', 24)

SELECT *
FROM Employee