SELECT DaysToManufacture, AVG(StandardCost) AS AverageCost
FROM Production.Product
GROUP BY DaysToManufacture
ORDER BY DaysToManufacture;

-- Pivot table with one row and five columns

SELECT 'AverageCost' AS Cost_Stored_By_Production_Days, [0], [1], [2], [3], [4]
FROM
(SELECT DaysToManufacture, StandardCost
 FROM Production.Product) AS SourceTable
PIVOT
(
AVG(StandardCost)
FOR DaysToManufacture IN ([0], [1], [2], [3], [4])
) AS PivotTable;


SELECT EmployeeID, VendorID, COUNT(PurchaseOrderID) AS [Order Count]
FROM Purchasing.PurchaseOrderHeader
WHERE EmployeeID IN (250, 251, 256, 257, 260)
GROUP BY EmployeeID, VendorID
ORDER BY EmployeeID, VendorID;

SELECT VendorID, [250] AS Emp1, [251] AS Emp2, [256] AS Emp3, [257] AS Emp4, [260] AS Emp5
FROM
(SELECT PurchaseOrderID, EmployeeID, VendorID
 FROM Purchasing.PurchaseOrderHeader) AS SourceTable
PIVOT
(
COUNT(PurchaseOrderID)
FOR EmployeeID IN ([250], [251], [256], [257], [260])
) AS PivotTable
ORDER BY PivotTable.VendorID;