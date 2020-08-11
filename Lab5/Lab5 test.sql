--Lab 5 
--Jiqing Sun

--5-1
USE SUN_JIQING_TEST;

CREATE FUNCTION GetTotalSale
(@year SMALLINT, @month SMALLINT)
RETURNS FLOAT
AS 
BEGIN 
	DECLARE @Return FLOAT = 0;

	SELECT @Return = ROUND(SUM(TotalDue), 2)
	FROM AdventureWorks2008R2.Sales.SalesOrderHeader 
	WHERE YEAR(OrderDate) = @year and MONTH(OrderDate) = @month;

	Return ISNULL(@Return, 0);
END 

SELECT dbo.GetTotalSale(2010, 5) AS [Total Sale];

DROP FUNCTION GetTotalSale;

--5-2
CREATE TRIGGER UpdateLastModified
    ON SaleOrderDetail
    FOR INSERT, UPDATE, DELETE
AS
BEGIN
   SET NOCOUNT ON;
   UPDATE SaleOrder SET LastModified = GETDATE() 
   FROM Inserted i
   FULL JOIN Deleted d
   ON i.OrderID = d.OrderID
   WHERE SaleOrder.OrderID = ISNULL(i.OrderID, d.OrderID);
END;

DROP TRIGGER UpdateLastModified

/*
INSERT Customer
	VALUES(1, 'Sun', 'Jiqing');
set IDENTITY_INSERT SaleOrder On;
INSERT INTO SaleOrder(OrderID, OrderDate, LastModified)
	VALUES(1, CAST(GETDATE() AS DATE), CAST(GETDATE() AS DATETIME));
INSERT SaleOrderDetail
	VALUES(1, 1, 1, 1);
INSERT SaleOrderDetail
	VALUES(1, 3, 2, 1);

select * from saleorder
*/


