--1
SELECT ProductID, Name, SellStartDate, SellEndDate, Size, Weight 
FROM Production.Product;

--2
SELECT *
FROM Sales.SalesOrderHeader
WHERE CreditCardID IS NULL;

--3
SELECT *
FROM Production.Product
WHERE Size IS NOT NULL;

--4
SELECT *
from Production.Product
WHERE SellStartDate BETWEEN '01/01/2007' AND '12/31/2007';--5SELECT *, DATEADD(DAY, 7, OrderDate) AS [Est. Delivery Date]
FROM Sales.SalesOrderHeader
WHERE DATEPART(MONTH, OrderDate) = 6 and DATEPART(YEAR, OrderDate) = 2007;--6SELECT CONVERT(CHAR(20), DATEADD(DAY, 30, GETDATE()), 101) AS [30 Days From Today];--7SELECT COUNT(SalesOrderID) [Total Orders],
       SUM(TotalDue) [Overall Total],
       AVG(TotalDue) [Order Ave.],
       MIN(TotalDue) [Smallest Total],
       MAX(TotalDue) [Largest Total]FROM Sales.SalesOrderHeaderWHERE DATEPART(MONTH, OrderDate) = 5 and DATEPART(YEAR, OrderDate) = 2008;--8SELECT CustomerID,
       COUNT(SalesOrderID) [Order Count],
       SUM(TotalDue) [Overall Total Due]
FROM Sales.SalesOrderHeader
WHERE DATEPART(YEAR, OrderDate) = 2007
GROUP BY CustomerID
HAVING COUNT(SalesOrderID) > 1
ORDER BY [Overall Total Due] DESC;

--9
SELECT DISTINCT SalesPersonID
FROM Sales.SalesOrderHeader oh
INNER JOIN Sales.SalesOrderDetail od
ON oh.SalesOrderID = od.SalesOrderID
WHERE ProductID = 777
ORDER BY SalesPersonID;--10select pdt.ProductID, pdt.Name, pdt.ListPrice, pdt.Size
from Production.Product pdt
join Production.ProductSubcategory psc
on pdt.ProductSubcategoryID = psc.ProductSubcategoryID
where psc.ProductCategoryID = 1 and psc.Name = 'Mountain Bikes';

--11
SELECT soh.SalesOrderID, crc.Name
FROM Sales.SalesOrderHeader soh
join Sales.CurrencyRate cr
ON soh.CurrencyRateID = cr.CurrencyRateID
join Sales.Currency crc
ON cr.ToCurrencyCode = crc.CurrencyCode;