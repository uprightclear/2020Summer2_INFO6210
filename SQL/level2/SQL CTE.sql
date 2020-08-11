SELECT *
FROM (SELECT ProductID, Name, ListPrice FROM Production.Product) Prod;

-- Use a CTE. Same results as above
WITH Prod AS 
	(SELECT ProductID, Name, ListPrice FROM Production.Product)
SELECT * FROM Prod;

-- Use Subqueries.

SELECT 
	Name,
	ListPrice,
	(SELECT AVG(ListPrice) FROM Production.Product) AS AvgPrice,
	(ListPrice - (SELECT AVG(ListPrice) FROM Production.Product)) AS PriceDiff
FROM Production.Product
WHERE ListPrice > (SELECT AVG(ListPrice) FROM Production.Product);

-- Use CTE

WITH AP AS
	(SELECT AVG(ListPrice) AS AvgPrice FROM Production.Product)
SELECT 
	Name,
	ListPrice,
	AP.AvgPrice,
	(ListPrice - AP.AvgPrice) AS PriceDiff
FROM Production.Product CROSS JOIN AP
WHERE ListPrice > AP.AvgPrice;

WITH OrdDet AS
	(SELECT SalesOrderID, COUNT(ProductID) [Line Item Count]
	 FROM Sales.SalesOrderDetail
	 GROUP BY SalesOrderID
	 HAVING COUNT(ProductID) > 4)
SELECT o.SalesOrderID, o.OrderDate, o.CustomerID, od.[Line Item Count]
FROM Sales.SalesOrderHeader o INNER JOIN OrdDet od
ON o.SalesOrderID = od.SalesOrderID;