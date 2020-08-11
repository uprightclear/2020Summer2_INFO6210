--Lab2
--Jiqing Sun

USE AdventureWorks2008R2;

--2-1
SELECT CustomerID, SalesOrderID, CAST(OrderDate AS DATE) [Order Date], ROUND(TotalDue, 2) [Total Due]
FROM Sales.SalesOrderHeader
WHERE OrderDate > '2008-05-01' AND TotalDue > 50000
ORDER BY CustomerID, OrderDate;

--2-2
SELECT CustomerID, AccountNumber, CAST(MAX(OrderDate) AS DATE) [Latest Order Date], COUNT(SalesOrderID) [Total Number of Orders]
FROM Sales.SalesOrderHeader
GROUP BY CustomerID, AccountNumber
ORDER BY CustomerID;

--2-3
SELECT ProductID, Name, ROUND(ListPrice, 2) [ListPrice]
FROM Production.Product 
WHERE ListPrice > (SELECT ListPrice FROM Production.Product WHERE ProductID = 912)
ORDER BY ListPrice DESC;

--2-4
SELECT p.ProductID, p.Name, COUNT(s.SalesOrderID)[Product Sold]
FROM Production.Product p 
INNER JOIN Sales.SalesOrderDetail s
ON p.ProductID = s.ProductID
GROUP BY p.ProductID, p.Name
HAVING COUNT(s.SalesOrderID) > 5
ORDER BY [Product Sold] DESC, p.ProductID;

--2-5
SELECT DISTINCT CustomerID, AccountNumber
FROM Sales.SalesOrderHeader
WHERE CustomerID NOT IN (SELECT CustomerID FROM Sales.SalesOrderHeader WHERE OrderDate > '2008-01-01')
ORDER BY CustomerID;

--2-6
SELECT sc.CustomerID, pp.FirstName, pp.LastName, pe.EmailAddress
FROM Sales.Customer sc
INNER JOIN Person.Person pp
ON sc.PersonID = pp.BusinessEntityID
INNER JOIN Person.EmailAddress pe
ON pp.BusinessEntityID = pe.BusinessEntityID
ORDER BY sc.CustomerID;