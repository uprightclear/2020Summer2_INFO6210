SELECT c.CustomerID, c.AccountNumber, SalesOrderID, OrderDate
FROM Sales.Customer c
INNER JOIN Sales.SalesOrderHeader oh
ON c.CustomerID = oh.CustomerID;

/*
	LEFT OUTER JOIN returns all rows from the left table,
	but only the matching rows from the right table.
*/
SELECT c.CustomerID, c.AccountNumber, SalesOrderID, OrderDate
FROM Sales.Customer c
LEFT OUTER JOIN Sales.SalesOrderHeader oh
ON c.CustomerID = oh.CustomerID;

/*
	RIGHT OUTER JOIN returns all rows from the right table,
	but only the matching rows from the left table.
*/
SELECT c.CustomerID, c.AccountNumber, SalesOrderID, OrderDate
FROM Sales.Customer c
RIGHT OUTER JOIN Sales.SalesOrderHeader oh
ON c.CustomerID = oh.CustomerID;

-------------
SELECT c.CustomerID, 
	   PersonID, 
	   COUNT(SalesOrderID) AS "Total Order"
FROM Sales.Customer c
INNER JOIN Sales.SalesOrderHeader oh
ON c.CustomerID = oh.CustomerID
GROUP BY c.CustomerID, PersonID
ORDER BY "Total Order" DESC;

------------
SELECT c.CustomerID, 
	   PersonID, 
	   COUNT(SalesOrderID) AS "Total Order"
FROM Sales.Customer c
INNER JOIN Sales.SalesOrderHeader oh
ON c.CustomerID = oh.CustomerID
GROUP BY c.CustomerID, PersonID
HAVING COUNT(SalesOrderID) > 20
ORDER BY "Total Order" DESC;


-- IN OPERATOR
-- Can be used with any data type
SELECT ProductID, Name, Color, ListPrice, SellStartDate
FROM Production.Product
WHERE Color IN ('Red', 'Blue', 'White') --character comparison
ORDER BY Color, Name;

SELECT ProductID, Name, Color, ListPrice, SellStartDate
FROM Production.Product
WHERE ListPrice IN (337.22, 594.83, 63.50, 8.99) --numeric comparison
ORDER BY ListPrice;

--LIKE operator
SELECT FirstName, MiddleName, LastName
FROM Person.Person
WHERE LastName LIKE 'a%' --begin with a
ORDER BY LastName;

SELECT FirstName, MiddleName, LastName
FROM Person.Person
WHERE LastName LIKE '[ace]%' --begin with a/c/e
ORDER BY LastName;

--Subquries are queries that are embedded in another query.
SELECT Name [Product],
	ListPrice,
	(SELECT MAX(ListPrice) FROM Production.Product)
			AS [Max Price],
	(ListPrice / (SELECT MAX(ListPrice) FROM Production.Product)) * 100
			AS [Percent of Max]
FROM Production.Product
WHERE ListPrice > 0
ORDER BY ListPrice DESC;