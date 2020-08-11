--Lab3
--Jiqing Sun

USE AdventureWorks2008R2;

--3-1
SELECT c.CustomerID, c.TerritoryID,
	   COUNT(o.SalesOrderid) [Total Orders],
	   CASE
			WHEN COUNT(o.SalesOrderid) = 0 THEN 'No Order'
			WHEN COUNT(o.SalesOrderid) = 1 THEN 'One Time'
			WHEN COUNT(o.SalesOrderid) >= 2 AND COUNT(o.SalesOrderid) <= 5 THEN 'Regular'
			WHEN COUNT(o.SalesOrderid) >= 6 AND COUNT(o.SalesOrderid) <= 10 THEN 'Often'
			WHEN COUNT(o.SalesOrderid) > 10 THEN 'Loyal'
	   END AS [Frequency]
FROM Sales.Customer c
LEFT OUTER JOIN Sales.SalesOrderHeader o
ON c.CustomerID = o.CustomerID
WHERE DATEPART(year, OrderDate) = 2007
GROUP BY c.TerritoryID, c.CustomerID;

--3-2
SELECT c.CustomerID, c.TerritoryID,
       COUNT(o.SalesOrderid) [Total Orders],
	   DENSE_RANK() OVER (PARTITION BY c.TerritoryID ORDER BY COUNT(o.SalesOrderid) DESC) AS [Total Orders Rank]
FROM Sales.Customer c
LEFT OUTER JOIN Sales.SalesOrderHeader o
ON c.CustomerID = o.CustomerID
WHERE DATEPART(year, OrderDate) = 2007
GROUP BY c.TerritoryID, c.CustomerID;

--3-3
SELECT T.BusinessEntityID [Salesperson ID], T.Bonus
FROM (SELECT ss.BusinessEntityID, ss.Bonus, he.Gender, st.[Group],
	  RANK() OVER (ORDER BY ss.Bonus DESC) [bonusrank]
	  FROM Sales.SalesPerson ss
	  INNER JOIN Sales.SalesTerritory st
	  ON ss.TerritoryID = st.TerritoryID
	  INNER JOIN HumanResources.Employee he
	  ON ss.BusinessEntityID = he.BusinessEntityID
	  WHERE he.Gender = 'F' AND st.[Group] = 'North America') AS T
WHERE T.bonusrank = 1;

--3-4
SELECT T.Month, T.SalesPersonID, T.Bonus, T.[Monthly Total Sales]
FROM(SELECT sh.SalesPersonID, sp.Bonus, DATEPART(month, sh.OrderDate) [Month], SUM(TotalDue) [Monthly Total Sales],
	        RANK() OVER (PARTITION BY DATEPART(month, sh.OrderDate) ORDER BY SUM(TotalDue) DESC) [salesrank]
     FROM Sales.SalesOrderHeader sh
     INNER JOIN Sales.SalesPerson sp
     ON sh.SalesPersonID = sp.BusinessEntityID
     WHERE sh.SalesPersonID IS NOT NULL AND DATEPART(year, sh.OrderDate) = 2007  
     GROUP BY sh.SalesPersonID, sp.Bonus, DATEPART(month, sh.OrderDate)) AS T
WHERE T.salesrank = 1
ORDER BY T.Month;

--3-5
WITH Temp
AS (SELECT sc.CustomerID, sh.AccountNumber, sh.OrderDate, pp.Color
    FROM Sales.Customer sc
    INNER JOIN Sales.SalesOrderHeader sh
    ON sc.CustomerID = sh.CustomerID
    INNER JOIN Sales.SalesOrderDetail sd
    ON sh.SalesOrderID = sd.SalesOrderID
    INNER JOIN Production.Product pp
    ON sd.ProductID = pp.ProductID
    WHERE sh.OrderDate > '2008-05-01')
SELECT DISTINCT t1.CustomerID, t1.AccountNumber
FROM (SELECT * FROM Temp WHERE Temp.Color = 'Red') t1
INNER JOIN (SELECT * FROM Temp WHERE Temp.Color = 'Yellow') t2
ON t1.CustomerID = t2.CustomerID
ORDER BY t1.CustomerID;