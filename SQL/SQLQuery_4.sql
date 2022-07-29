--basic query: select, where, order by, join, aggregation functions + group by, having 
--subquery, cte, window function, pagination
--temp tables, table varialbes, sp, user defined functions 

SELECT *
FROM Employee

create table Employee(
    ID int PRIMARY KEY,
    EName varchar(20),
    Age int
)

INSERT INTO Employee VALUES(1, 'Sam', 34)
INSERT INTO Employee VALUES(2, 'Monster', 3000)
INSERT INTO Employee VALUES(3, 'Weird', -3000)

--check constraint
DELETE Employee

ALTER TABLE Employee
ADD Constraint Chk_Age_Employee CHECK(Age BETWEEN 18 and 60)


--identity property
CREATE TABLE Product(
    Id int primary key IDENTITY(1,1),
    ProductName varchar(20),
    UnitPrice money
)

INSERT INTO Product VALUES('Green Tea', 2)
INSERT INTO Product VALUES('Latte', 3)
INSERT INTO Product VALUES('Cold Brew', 4)

SELECT *
FROM Product

--truncate vs. delete
--1.delete is a DML statement, it will not reset the propery value; TRUNCATE is a DDL statement, so it will affect the table structure and reset the property value
TRUNCATE TABLE Product
--2. DELETE can be used with WHERE, but TRUNCATE will not
DELETE Product
WHERE ID = 1

--referential integrity via foreign key
DROP TABLE Employee

CREATE TABLE Department(Id int primary key, DName varchar(20), Loc varchar(20))
CREATE TABLE Employee(
    Id int PRIMARY KEY,
    EName varchar(20) NOT NULL,
    Age INT CHECK(Age BETWEEN 18 AND 60),
    DeptId int FOREIGN KEY REFERENCES Department(Id)
)
SELECT * FROM Department
SELECT * FROM Employee

INSERT INTO Department VALUES(1, 'IT', 'Chicago')
INSERT INTO Department VALUES(2, 'HR', 'Sterling')
INSERT INTO Department VALUES(3, 'QA', 'Paris')

INSERT INTO Employee VALUES(1, 'Fred', 34, 1)
INSERT INTO Employee VALUES(2, 'Fiona', 45, 3)

DELETE FROM Department
WHERE ID = 2

--Transaction: a group of logically related DML statements that will either succeed together or fail together
--3 modes
--Autocommit transatcion: default
--implicit transaction
--explicit transaction
CREATE TABLE PRODUCT
(ID int primary key,
ProductName varchar(20) not null,
UnitPrice money,
Quantity int)

INSERT INTO Product VALUES(1, 'Green Tea', 2, 100)
INSERT INTO Product VALUES(2, 'Latte', 3, 100)
INSERT INTO Product VALUES(3, 'Cold Brew', 4, 100)

SELECT *
FROM Product

BEGIN TRAN
INSERT INTO Product VALUES(4, 'Flat White', 4, 100)

SELECT * FROM Product
commit

BEGIN TRAN
INSERT INTO Product VALUES(5, 'Earl Gray', 4, 100)

SELECT * FROM Product
ROLLBACK

--properties 
--ACID
--A: Atomicity -- work is atomic
--C: Consistency -- whatever happens in the middle of a transaction, this property will never leave our db in half-completed state
--I: Isolation -- two transactions will be isolated from each other by locking the resource
--D: Durability --once the transaction is completed, the the changes it has made to the db will be permanent

--concurrency problems
--dirty reads:if t1 allows t2 to read uncommitted data, and then t1 rolled back
    --caused by isolation level read uncommitted
    --solved by isolation level read committed
--lost update: when t1 and t2 read and update the same data but t2 finish its work earlier than t1, then t2 will lose their update
    --caused by isolation level read committed
    --solved by isolation level repeatble read
--non-repeatable read: t1 read the same data twice while t2 is updating the data
    --caused by isolation level read committed
    --solved by isolation level repeatble read
--phantom read: t1 reads the same data twice while t2 is inserting records
    --caused by isolation level repeatable read
    --solved by isolation level serializable

--ATS
--candidate table
--1. Update Candidate table
--2. Insert into Employee table
--3. Insert into TimeSheet Table

--index: an on-disk sturcture associated with a table that increases the retrieval spped of rows from the table -- SELECT
--clustered index: physically sort the record, only one in one table, will be creaetd by pk

--non-clustered index: will not sort the data, sotred seperately

CREATE TABLE Customer(Id int, FullName varchar(20), City varchar(20), Country varchar(20))
SELECT * FROM Customer

CREATE CLUSTERED INDEX Cluster_IX_Customer_ID ON Customer(Id)

INSERT INTO CUSTOMER VALUES(2, 'David','Chicago', 'USA')
INSERT INTO CUSTOMER VALUES(1, 'Fred','Jersey City', 'USA')

DROP TABLE Customer

CREATE TABLE Customer(Id int primary key, FullName varchar(20), City varchar(20), Country varchar(20))

CREATE INDEX Noncluster_IX_Customer_City ON Customer(City)

--clustered index: always necessary, created by pk
--non-clustered index: JOIN, WHERE, Aggregated 

--Pros: index will help us improve retriving spped --select
--Cons: extra space, slow down UPDATE/INSERT/DELETE 

--Performance tuning:
--execution plan
--1. use index wisely
--2. avoid unnecessary joins
    --Student: sId, sName
    --Course: cId, cName
    --studentCourse: sId, cId
    --sName and num of course
--3.avoid select *
--4.derived table to avoid grouping of lots of non-aggregated field
--5. use join to replace subquery