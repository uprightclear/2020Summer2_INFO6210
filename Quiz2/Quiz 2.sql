USE AdventureWorks2008R2

-- SECOND LAST DIGIT OF NUID: 7 or 9

-- Your Name:SUN JIQING
-- Your NUID:001563027

-- Question 1 (3 points)

/* Rewrite the following query to present the same data in a horizontal format,
   as listed below, using the SQL PIVOT command. */

select (p.LastName + ', ' + p.FirstName) FullName, year(sh.OrderDate) OrderYear, count(SalesOrderID) TotalOrder
from Sales.SalesOrderHeader sh
join Sales.Customer c
on sh.CustomerID = c.CustomerID
join Person.Person p
on c.PersonID = p.BusinessEntityID
where sh.CustomerID between 30000 and 30005
group by p.LastName + ', ' + p.FirstName, year(sh.OrderDate)
order by FullName;


/*
FullName				2005	2006	2007	2008
McCoy, James			0		2		4		2
McDonald, Christinia	0		0		1		1
McGuel, Alejandro		0		0		2		2
McKay, Yvonne			1		1		2		0
McLin, Nkenge			2		2		2		1
McPhearson, Nancy		0		0		2		2
*/
SELECT FullName, [2005], [2006], [2007], [2008]
FROM 
(
	select (p.LastName + ', ' + p.FirstName) FullName, year(sh.OrderDate) OrderYear, SalesOrderID
	from Sales.SalesOrderHeader sh
	join Sales.Customer c
	on sh.CustomerID = c.CustomerID
	join Person.Person p
	on c.PersonID = p.BusinessEntityID
	where sh.CustomerID between 30000 and 30005
) AS SourceTable
PIVOT
(
	count(SalesOrderID) FOR OrderYear IN ([2005], [2006], [2007], [2008])
) AS PivotTable;





-- Question 2 (6 points)

/* Write a query to retrieve the top two salespersons of each territory.
   Use the sum of TotalDue in SalesOrderHeader to determine the total sale amounts.
   The top 2 salespersons have the two highest total sale amounts. Your solution
   should retrieve a tie if there is any. The report should have the following format.

   The name is the full name of a salesperson. The email address is a salesperson's
   email address. Sort the report by the territory id.

TerritoryID	Top2Salespersons
	1		David Campbell david8@adventure-works.com, Pamela Ansman-Wolfe pamela0@adventure-works.com
	2		Jillian Carson jillian0@adventure-works.com, Michael Blythe michael9@adventure-works.com
	3		Jillian Carson jillian0@adventure-works.com, Michael Blythe michael9@adventure-works.com
	4		Linda Mitchell linda3@adventure-works.com, Shu Ito shu0@adventure-works.com
	5		Tsvi Reiter tsvi0@adventure-works.com, Michael Blythe michael9@adventure-works.com
	6		Jae Pak jae0@adventure-works.com, Garrett Vargas garrett1@adventure-works.com
	7		Ranjit Varkey Chudukatil ranjit0@adventure-works.com, Amy Alberts amy0@adventure-works.com
	8		Rachel Valdez rachel0@adventure-works.com, Amy Alberts amy0@adventure-works.com
	9		Lynn Tsoflias lynn0@adventure-works.com, Syed Abbas syed0@adventure-works.com
	10		Jos?Saraiva jos?@adventure-works.com, Amy Alberts amy0@adventure-works.com  
*/

WITH TEMP AS 
(
	SELECT DISTINCT SalesPersonID, TerritoryID, LastName, FirstName, EmailAddress, SUM(TotalDue) AS [TOTAL],
	       RANK() OVER(PARTITION BY TerritoryID ORDER BY SUM(TotalDue) DESC) AS [RANK]
	FROM Sales.SalesOrderHeader SH
	INNER JOIN Person.Person PP
	ON SH.SalesPersonID = PP.BusinessEntityID
	INNER JOIN Person.EmailAddress PE
	ON PP.BusinessEntityID = PE.BusinessEntityID
	WHERE SalesPersonID IS NOT NULL
	GROUP BY TerritoryID, SalesPersonID, LastName, FirstName, EmailAddress
)
SELECT DISTINCT TerritoryID,
STUFF
(
(SELECT  ', '+ FirstName + ' ' + LastName + ' ' + EmailAddress
 FROM  TEMP T2
 WHERE T2.TerritoryID = T1.TerritoryID AND [RANK] <= 2
 FOR XML PATH('')), 1, 2, ''
)AS Top2Salespersons
FROM TEMP T1
ORDER BY T1.TerritoryID





-- Question 3 (6 points)
USE [SUN_JIQING_TEST]
/* Given five tables as defined below */

CREATE TABLE Department
 (DepartmentID INT PRIMARY KEY,
  Name VARCHAR(50));

CREATE TABLE Employee
(EmployeeID INT PRIMARY KEY,
 LastName VARCHAR(50),
 FirsName VARCHAR(50),
 Salary DECIMAL(10,2),
 DepartmentID INT REFERENCES Department(DepartmentID),
 TerminateDate DATE);

CREATE TABLE Project
(ProjectID INT PRIMARY KEY,
 Name VARCHAR(50));

CREATE TABLE Assignment
(EmployeeID INT REFERENCES Employee(EmployeeID),
 ProjectID INT REFERENCES Project(ProjectID),
 StartDate DATE,
 EndDate DATE
 PRIMARY KEY (EmployeeID, ProjectID, StartDate));

CREATE TABLE SalaryAudit
(LogID INT IDENTITY,
 EmployeeID INT,
 OldSalary DECIMAL(10,2),
 NewSalary DECIMAL(10,2),
 ChangedBy VARCHAR(50) DEFAULT original_login(),
 ChangeTime DATETIME DEFAULT GETDATE(),
 Perc decimal (3,2));


/* There is a business rule an employee cannot have more than
   two salary adjustments in the current year and any salary adjustment
   must be logged in the SalaryAudit table.
   Please write a trigger to implement the rule. Assume only one update
   takes place at a time. */

CREATE TRIGGER utrSalaryAudit ON Employee  
AFTER UPDATE
AS  
BEGIN
 
	IF UPDATE(Salary)
	BEGIN

	   DECLARE @COUNT INT
	   SELECT @COUNT = COUNT(LogID)
	   FROM SalaryAudit S
	   FULL JOIN inserted AS i 
	   ON S.EmployeeID = i.EmployeeID
	   FULL JOIN deleted d
	   ON i.EmployeeID = d.EmployeeID
	   WHERE S.EmployeeID = i.EmployeeID;

	   IF @COUNT > 2

	       ROLLBACK Transaction

	   ELSE
	      INSERT INTO SalaryAudit (EmployeeID, OldSalary, NewSalary) 
		  (SELECT isnull(i.EmployeeID, d.EmployeeID), d.Salary, i.Salary
		   FROM inserted AS i 
		   FULL JOIN deleted d
		   ON i.EmployeeID = d.EmployeeID);	  
    END
END



