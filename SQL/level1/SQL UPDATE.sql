UPDATE Person.vStateProvinceCountryRegion 
SET CountryRegionName = 'United States'
WHERE CountryRegionName = 'United States of America';


UPDATE Production.Product
SET ListPrice = ListPrice * 2;


UPDATE Sales.SalesPerson
SET Bonus = 6000, CommissionPct = .05, SalesQuota = NULL;


UPDATE Sales.SalesPerson
SET SalesYTD = SalesYTD + so.SubTotal
FROM Sales.SalesPerson sp
JOIN Sales.SalesOrderHeader so
ON sp.BusinessEntityID = so.SalesPersonID
AND so.OrderDate = (SELECT MAX(OrderDate)
					FROM Sales.SalesOrderHeader
					WHERE SalesPersonID = sp.BusinessEntityID); 