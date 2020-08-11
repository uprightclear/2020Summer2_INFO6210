-- Question: Retrieve customers who have never purchased Product 716

-- Use JOIN to get customers who hava never purchased Product 716
SELECT distinct sh.CustomerID
FROM Sales.SalesOrderHeader sh
join Sales.SalesOrderDetail sd
	 ON sh.SalesOrderID = sd.SalesOrderID
WHERE sd.ProductID <> 716
ORDER BY sh.CustomerID;

-- validate result 
SELECT distinct sh.CustomerID
FROM Sales.SalesOrderHeader sh
join Sales.SalesOrderDetail sd
	 ON sh.SalesOrderID = sd.SalesOrderID
WHERE sd.ProductID = 716
ORDER BY sh.CustomerID;

/* both of the above results has the number 11144 since customer may buy different product including 716 
therefore same customerid may be appeared */

-- the following code can prove the explanation
SELECT distinct sd.ProductID
FROM Sales.SalesOrderHeader sh
join Sales.SalesOrderDetail sd
	 ON sh.SalesOrderID = sd.SalesOrderID
WHERE sh.CustomerID = 11144
ORDER BY sd.ProductID;

--Use EXCEPT to get correct data
SELECT distinct CustomerID
	FROM Sales.SalesOrderHeader
EXCEPT
SELECT distinct CustomerID
	FROM Sales.SalesOrderHeader sh
	join Sales.SalesOrderDetail sd
		 ON sh.SalesOrderID = sd.SalesOrderID
	WHERE sd.ProductID = 716;

-- Use NOT IN 
SELECT distinct CustomerID
FROM Sales.SalesOrderHeader
WHERE CustomerID NOT IN
    (SELECT distinct CustomerID
	 FROM Sales.SalesOrderHeader sh
	 join Sales.SalesOrderDetail sd
	 ON sh.SalesOrderID = sd.SalesOrderID
	 WHERE sd.ProductID = 716)
	 ORDER BY CustomerID;



--------------------------------------------------------------



-- calculate total sales for each territory

-- solution 1
SELECT oh.TerritoryID, st.Name, ROUND(SUM(oh.TotalDue),2) TotalSales
FROM Sales.SalesOrderDetail od
INNER JOIN Sales.SalesOrderHeader oh
ON oh.SalesOrderID = od.SalesOrderID
INNER JOIN Sales.SalesTerritory st
ON st.TerritoryID = oh.TerritoryID
GROUP BY oh.TerritoryID, st.Name
ORDER BY oh.TerritoryID DESC;

-- solution 2
SELECT oh.TerritoryID, st.Name, ROUND(SUM(oh.TotalDue),2) TotalSales
FROM Sales.SalesOrderHeader oh
INNER JOIN Sales.SalesTerritory st
ON st.TerritoryID = oh.TerritoryID
GROUP BY oh.TerritoryID, st.Name
ORDER BY oh.TerritoryID DESC;


-- get order values for sales territories but include SalesOrderDetail
SELECT oh.TerritoryID, st.Name, oh.SalesOrderID, oh.TotalDue
FROM Sales.SalesOrderDetail od
INNER JOIN Sales.SalesOrderHeader oh
ON oh.SalesOrderID = od.SalesOrderID
INNER JOIN Sales.SalesTerritory st
ON st.TerritoryID = oh.TerritoryID
ORDER BY oh.SalesOrderID DESC;

-- each order is duplicated for each product contained in the order
SELECT oh.SalesOrderID, COUNT(od.ProductID) ProductCount
FROM Sales.SalesOrderDetail od
INNER JOIN Sales.SalesOrderHeader oh
ON oh.SalesOrderID = od.SalesOrderID
GROUP BY oh.SalesOrderID
ORDER BY oh.SalesOrderID DESC;
