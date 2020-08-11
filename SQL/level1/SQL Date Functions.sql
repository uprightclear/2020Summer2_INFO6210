SELECT SalesOrderID, OrderDate
FROM AdventureWorks2008R2.Sales.SalesOrderHeader
ORDER BY OrderDate DESC,SalesOrderID DESC;

/*Useful Date Functions */
SELECT TOP 10 SalesOrderID, OrderDate [Date and Time]
FROM Sales.SalesOrderHeader
ORDER BY TotalDue DESC;

/*Get Order Date Only*/
SELECT TOP 10 SalesOrderID, 
			  CAST(OrderDate as DATE) [Date Only]
FROM Sales.SalesOrderHeader
ORDER BY TotalDue DESC;

/*Caculate Different Between Dates*/
SELECT TOP 10 SalesOrderID, CAST(OrderDate as DATE) [Date],
			  DATEDIFF(dd, OrderDate, GETDATE())[days],
			  DATEDIFF(mm, OrderDate, GETDATE())[months],
			  DATEDIFF(yy, OrderDate, GETDATE())[years]
FROM Sales.SalesOrderHeader
ORDER BY TotalDue DESC;

/*Get Year , Quarter and Months Numbers of dates*/
SELECT TOP 10 SalesOrderID, 
			  CAST(OrderDate as DATE) [Date],
			  DATEPART(yy, OrderDate)[Year Number],
			  DATEPART(qq, OrderDate)[Quarter Number],
			  DATEPART(mm, OrderDate)[Month Number]
FROM Sales.SalesOrderHeader
ORDER BY TotalDue DESC;

/*Get Year and Months Numbers of dates*/
SELECT TOP 10 SalesOrderID, 
			  CAST(OrderDate as DATE) [Date],
			  YEAR(OrderDate)[Year Number],
			  MONTH(OrderDate)[Month Number]
FROM Sales.SalesOrderHeader
ORDER BY TotalDue DESC;

/*Get Months and Day names*/
SELECT TOP 10 SalesOrderID, 
			  CAST(OrderDate as DATE) [Date],
			  DATENAME(MM, OrderDate)[Month Name],
			  DATENAME(DW, OrderDate)[Day Name]
FROM Sales.SalesOrderHeader
ORDER BY TotalDue DESC;