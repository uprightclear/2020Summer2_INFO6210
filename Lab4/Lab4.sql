--Lab 4 
--Jiqing Sun


--Part A
CREATE TABLE Lab4.TargetCustomers 
	(
		TargetID int IDENTITY NOT NULL PRIMARY KEY,
		FirstName varchar(40) NOT NULL,
		LastName varchar(40) NOT NULL,
		Address varchar(40) NOT NULL,
		City varchar(40) NOT NULL,
		State varchar(40) NOT NULL,
		ZipCode int NOT NULL
	);

CREATE TABLE Lab4.MailingLists 
	(
		MailingListID int IDENTITY NOT NULL PRIMARY KEY,
		MailingList varchar(40) NOT NULL
	);

CREATE TABLE Lab4.TargetMailingLists 
	(
		TargetID int NOT NULL REFERENCES LAB4.TargetCustomers(TargetID),
		MailingListID int NOT NULL REFERENCES LAB4.MailingLists(MailingListID),
		CONSTRAINT PKTargetMailingLists PRIMARY KEY CLUSTERED (TargetID, MailingListID)
	);


--Part B
USE AdventureWorks2008R2;

WITH temp AS
   (SELECT DISTINCT CustomerID, SalesPersonID
	FROM Sales.SalesOrderHeader
	WHERE CAST(SalesPersonID AS varchar(20)) <> 'NULL') 
	
SELECT DISTINCT t2.CustomerID, 
STUFF((SELECT  ', '+RTRIM(CAST(SalesPersonID as char))  
	   FROM temp t1 
	   WHERE t1.CustomerID = t2.CustomerID 
	   FOR XML PATH('')) , 1, 2, '') AS SalesPersonID
FROM temp t2
ORDER BY CustomerID DESC;

--Part C
USE AdventureWorks2008R2;

SELECT DISTINCT sh.SalesOrderID,
STUFF((SELECT  ', '+RTRIM(CAST(ProductID as char))  
	   FROM Sales.SalesOrderDetail
	   WHERE SalesOrderID = sh.SalesOrderID
	   ORDER BY ProductID
	   FOR XML PATH('')) , 1, 2, '') AS ProductID
FROM Sales.SalesOrderHeader sh
JOIN Sales.SalesOrderDetail sd
ON sh.SalesOrderID = sd.SalesOrderID
ORDER BY SalesOrderID;