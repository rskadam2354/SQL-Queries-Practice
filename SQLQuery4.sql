SELECT * FROM Purchasing.PurchaseOrderHeader;
-- this command selects all the columns from the table 
-- the "Purchasing" denotes the schema of the database and "PurchaseOrderHeader" denotes the table name

SELECT SubTotal FROM Purchasing.PurchaseOrderHeader;
-- This command is used to get only the SubTotal Column from the "PurchaseOrderHeader" table

SELECT SubTotal 
FROM Purchasing.PurchaseOrderHeader 
WHERE SubTotal > 500; 
-- the "WHERE" denotes a condition to be satisfied for the given records 
-- So there will be only a certain number of rows which satisfy the condition where "SubTotal" is greater 
-- than 500


-- Arithematic operations in SQL are possible just for the divide we have to add a where statement 
WHERE the divisor (the denominator) should not be zero 

SELECT SubTotal,TaxAmt,SubTotal+TaxAmt AS SubTotalWithTaxAmt,SubTotal-TaxAmt AS different
-- this is called alias 
FROM Purchasing.PurchaseOrderHeader
WHERE SubTotal+TaxAmt>500;
-- There is a sequence of the clauses SQL follows for e.g : 
-- The sql first reads the FROM statement and after that the WHERE statement and after that the SELECT statement
-- that is the reason why you cannot use ALIAS named column names in WHERE statements 
-- the temporary column names created by us are not present in the database that is why it gives an error 
-- for those columns

--  STRING OPERATIONS

-- here I will use the Person table in the adventureWorks Database inside Person Schema
-- CONCATINATION IN STRING DATA TYPES 

SELECT FirstName,MiddleName,LastName , FirstName+'.'+MiddleName+'.'+LastName AS FullName
FROM Person.Person
WHERE MiddleName IS NOT NUll;
-- We can check the value is null or not by using "IS NOT NULL" and "IS NULL" statements 

-- LOGICAL OPERATORS (AND , OR)
SELECT JobTitle,Gender,MaritalStatus 
FROM HumanResources.Employee
WHERE MaritalStatus='S' AND (Gender='M' OR Gender='F');

-- 'BETWEEN' AND 'IN' Operators

SELECT *
FROM HumanResources.Employee
WHERE JobTitle IN ('Chief Executive Officer','Research and Development Engineer');
-- The IN operator is used to get all the values in the column which has the specific value inside the bracket
-- it is better than using OR operator a number of times

SELECT * 
FROM HumanResources.Employee
WHERE BusinessEntityID BETWEEN 1 AND 10;
-- The BETWEEN query gets you all the values between 1 and 10 

-- LIKE Operator

SELECT * 
FROM Person.StateProvince
WHERE Name LIKE 'r_%';
-- the LIKE operator is used in strings to get the string values from the database with the criterias required
-- 'A%o' will give all the results with state Name starting from 'a' and ending with 'a' it is not case sensitive
-- '%or%' this will give all the state names which have the string 'or' in them 
-- '_r%' this will give the results where r is in second position 
-- 'r_%' this will give the results where r is the first character and there is atleast one character 
-- after r 

-- ORDER BY CLAUS
-- If we want to get the data in a particular order then we can use the order by claus property 
SELECT City,PostalCode
FROM Person.Address
ORDER BY PostalCode ASC;

-- ORDER BY SORT TO SORT THE NAMES IN THE PERSON TABLE
SELECT FirstName,MiddleName,LastName,FirstName+' '+MiddleName+' '+LastName as Fullname 
FROM Person.Person
WHERE MiddleName is not null
order by FirstName asc,LastName desc;

-- GROUP BY CLAUS
-- THE GROUP BY CLAUS IS USED TO GET THE DATA WITH SAME ENTRY IN ONE GROUP 
SELECT SalesOrderID,UnitPrice
FROM Sales.SalesOrderDetail;

SELECT SalesOrderId,SUM(UnitPrice) AS TOTALPRICE
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID
-- the SUM is called an aggregate function in sql like avg or count,etc
-- here the orderID is grouped and all the corresponding values of unitprice of that orderID are summed up 
-- together thus we can see the totalPrice of all the individual order ID's 

SELECT FirstName,MiddleName,LastName , FirstName+'.'+MiddleName+'.'+LastName AS FullName
FROM Person.Person
WHERE MiddleName IS NOT NUll;
-- here I have used the where claus to not include the null values but because of that 
-- the first name and last name people are not getting considered that is why we will use 
-- Concat function for string this will do the work 
SELECT FirstName,MiddleName,LastName,
CONCAT(FirstName,' ',MiddleName,' ',LastName) as FULLNAME
from Person.Person;
-- you can see the difference so it is better to use concat function in while string operations if 
-- you don't want to miss out values 

-- IF I want to get the length of the string then I can use LEN() function 
SELECT FirstName,LEN(FirstName) as LengthFirstName,LEFT(FirstName,3) as LeftExtract,RIGHT(FirstName,2) as RightExtract,
SUBSTRING(FirstName,3,5) as Subsstring
from Person.Person
-- we can use LEFT and RIGHT to extract a set of characters from the left side and Right side respectively
-- we can use SUBSTRING function to extract a substring from the string 

-- DATE function 
SELECT SalesOrderID,OrderDate,MONTH(OrderDate) as MonthExtract,
DAY(OrderDate) as DayExtract,YEAR(OrderDate) as YearExtract
FROM Sales.SalesOrderHeader;
-- the individual day year and month functions will extract day year and month for that particular record
SELECT CURRENT_TIMESTAMP;
-- the timestamp will be known for current state 

-- DATA functions 
-- HAVING claus
-- you cannot use where claus for aggregate function so that is why we have HAVING claus
SELECT SalesOrderID,SUM(UnitPrice) as TotalSalesPerID -- first the select statement
from Sales.SalesOrderDetail -- then from where you are selecting 
WHERE SalesOrderID>50000 -- there where conditional statement which applies on the column
GROUP BY SalesOrderID -- then the group by statement
HAVING SUM(UnitPrice)>10000 -- then having statement which is like where claus but for aggregate function
ORDER BY SalesOrderID DESC; -- then the sorting statement order by
-- I can give where claus to a column but cannot give it to a aggregate function or alias column
-- the above syntax is the order in which you have to write the code and not disturb the order or else it would
-- give an error
-- SQL will process the whole thing in a different order 
--FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY

-- SUBQUERY 
-- a query inside another query is called subquery
SELECT PurchaseOrderID,EmployeeID
FROM Purchasing.PurchaseOrderHeader
ORDER BY PurchaseOrderID ASC;

SELECT PurchaseOrderID
FROM Purchasing.PurchaseOrderHeader
WHERE PurchaseOrderID>10
ORDER BY PurchaseOrderID ASC

-- I can combine both of these statements by using subqueries 
SELECT PurchaseOrderID,EmployeeID
FROM Purchasing.PurchaseOrderHeader
WHERE PurchaseOrderID IN
(
SELECT PurchaseOrderID
FROM Purchasing.PurchaseOrderHeader
WHERE PurchaseOrderID>10
)
ORDER BY PurchaseOrderID ASC;

-- the code inside the brackets denotes all the values for PurchaseOrderID column 
-- the value from that code will be taken into consideration in the WHERE claus
-- thus the WHERE clause outside the bracket will then give all the data satisfying the inner bracket condition
-- when there is only a single entry then instead of using IN we should use =

-- UNION and UNION ALL operator
SELECT BusinessEntityID FROM HumanResources.Employee
 UNION
SELECT BUSINESSENTITYID FROM Person.Person
 UNION
SELECT CUSTOMERID FROM Sales.Customer;
-- THE UNION CLAUS WILL MAKE ALL THE COLUMNS INTO ONE COLUMN AND IT WILL REMOVE DUPLICATE RECORDS 
-- THERE SHOULD BE SAME NUMBER OF COLUMNS IN EACH STATEMENT 
-- THE DATATYPE OF EACH COLUMN SHOULD BE SAME 
SELECT BusinessEntityID FROM HumanResources.Employee
 UNION ALL
SELECT BUSINESSENTITYID FROM Person.Person
 UNION ALL
SELECT CUSTOMERID FROM Sales.Customer;
-- THE UNION ALL DOES THE SAME THING BUT EXCEPT IT WILL JUST NOT REMOVE THE DUPLICATE COLUMNS


-- INNER JOIN 
-- WHERE UNION is used to combine rows 
-- joins are used to combine columns together 
-- inner join combines columns together
SELECT pod.PURCHASEORDERID ,pod.PURCHASEORDERDETAILID,poh.OrderDate
FROM 
	Purchasing.PurchaseOrderDetail pod
	INNER JOIN
	Purchasing.PurchaseOrderHeader poh
ON 
	poh.PurchaseOrderID=pod.PurchaseOrderID
-- on is the 'on basis of what column' meaning between the joins means 
-- on what basis are these tables connected 
-- FROM statement will include two tables 
-- one tableName INNER JOIN secondTableName 
-- as alwasy the select statement will have the column names from the tables 
-- here I have used alias for the table names 


-- LEFT JOIN
SELECT * FROM Person.Person;
SELECT * FROM Person.BusinessEntityAddress;

SELECT person.BusinessEntityID,person.FirstName,person.LastName,BUSINESS.BusinessEntityID 
FROM 
Person.Person person
INNER JOIN
Person.BusinessEntityAddress BUSINESS
ON 
BUSINESS.BusinessEntityID=person.BusinessEntityID

-- NOTICE HOW THE INNER JOIN WILL GET ALL THE RESULTS WHICH ARE HAVE THE SAME BUSINESSENTITYID
-- IF WE WANT TO HAVE COMPLETE RECORDS FROM THE JOIN OF A PARTICULAR TABLE 
-- IRRESPECTIVE OF THE COMMON TABLE DATA THEN WE CAN USE LEFT OR RIGHT JOIN 
SELECT person.BusinessEntityID,person.FirstName,person.LastName,BUSINESS.BusinessEntityID 
FROM 
Person.Person person
LEFT JOIN
Person.BusinessEntityAddress BUSINESS
ON 
BUSINESS.BusinessEntityID=person.BusinessEntityID

-- RIGHT JOIN 
-- SIMILARLY THIS IS USED TO GET ALL THE DATA FROM THE RIGHT SIDE IRRESPECTIVE OF THE COMMONNESS

SELECT person.BusinessEntityID,person.FirstName,person.LastName,BUSINESS.BusinessEntityID 
FROM 
Person.Person person
RIGHT JOIN
Person.BusinessEntityAddress BUSINESS
ON 
BUSINESS.BusinessEntityID=person.BusinessEntityID
ORDER BY PERSON.BusinessEntityID ASC;

-- FULL JOIN 
-- THIS IS THE COMBINATION OF THE LEFT AND RIGHT JOIN 
SELECT person.BusinessEntityID,person.FirstName,person.LastName,BUSINESS.BusinessEntityID 
FROM 
Person.Person person
FULL JOIN
Person.BusinessEntityAddress BUSINESS
ON 
BUSINESS.BusinessEntityID=person.BusinessEntityID
ORDER BY PERSON.BusinessEntityID ASC;
-- FULL JOIN WILL GIVE ALL THE DATA FROM BOTH THE TABLES REGARDLESS THE COMMONESS

