
-- Part B (1.5 points)

WITH Temp AS (
SELECT DISTINCT sh.CustomerID,
       STUFF((SELECT distinct ', '+RTRIM(CAST(SalesPersonID as char))  
       FROM Sales.SalesOrderHeader
       WHERE CustomerID = sh.CustomerID
       FOR XML PATH('')) , 1, 2, '') AS SalesPersons
FROM Sales.SalesOrderHeader sh)
SELECT * FROM Temp
WHERE SalesPersons IS NOT NULL
ORDER BY CustomerID DESC;



-- Part C (1.5 points)

SELECT DISTINCT h.SalesOrderID,
STUFF((	SELECT  ', '+RTRIM(CAST(ProductID as char))  
		FROM Sales.salesOrderDetail  
       WHERE SalesOrderID = h.SalesOrderID
       ORDER BY ProductID ASC
       FOR XML PATH('')) , 1, 2, '') AS Products
FROM Sales.SalesOrderHeader h
ORDER BY SalesOrderID;

