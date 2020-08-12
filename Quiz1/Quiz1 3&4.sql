--Quiz 1
--NUID: 001563027
--Name: Jiqing Sun

USE AdventureWorks2008R2;

--3
SELECT CAST(SH.OrderDate AS DATE)[Date], SUM(SD.OrderQty)[Total Product Quantity Sold for the Date]
FROM Sales.SalesOrderHeader SH
INNER JOIN Sales.SalesOrderDetail SD
ON SH.SalesOrderID = SD.SalesOrderID
INNER JOIN Production.Product PP
ON SD.ProductID = PP.ProductID
GROUP BY SH.OrderDate
HAVING SUM(SD.OrderQty) > 0 AND CAST(SH.OrderDate AS DATE) NOT IN
(
	SELECT CAST(SH.OrderDate AS DATE)
	FROM Sales.SalesOrderHeader SH
	INNER JOIN Sales.SalesOrderDetail SD
	ON SH.SalesOrderID = SD.SalesOrderID
	INNER JOIN Production.Product PP
	ON SD.ProductID = PP.ProductID
	WHERE PP.Color = 'Red'
)
ORDER BY [Total Product Quantity Sold for the Date] DESC;

--4
SELECT T.Year, T.Color, T.[Total Product Quantity Sold]
FROM
(SELECT DATEPART(year, SH.OrderDate) [Year], PP.Color, SUM(SD.OrderQty)[Total Product Quantity Sold],
	    RANK() OVER(PARTITION BY DATEPART(year, SH.OrderDate) ORDER BY SUM(SD.OrderQty)) [Rank]
 FROM Sales.SalesOrderHeader SH
 INNER JOIN Sales.SalesOrderDetail SD
 ON SH.SalesOrderID = SD.SalesOrderID
 INNER JOIN Production.Product PP
 ON SD.ProductID = PP.ProductID
 WHERE PP.Color IS NOT NULL
 GROUP BY DATEPART(year, SH.OrderDate), PP.Color) T
WHERE T.Rank = 1
ORDER BY T.Year;