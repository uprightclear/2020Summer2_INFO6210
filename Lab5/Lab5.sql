--Lab 5 
--Jiqing Sun

--5-1
USE SUN_JIQING_TEST;

CREATE FUNCTION GetTotalSale
(@year INT, @month INT)
RETURNS FLOAT
AS 
BEGIN 
	DECLARE @Return FLOAT = 0;

	SELECT @Return = ROUND(SUM(TotalDue), 2)
	FROM AdventureWorks2008R2.Sales.SalesOrderHeader 
	WHERE YEAR(OrderDate) = @year and MONTH(OrderDate) = @month;

	Return ISNULL(@Return, 0);
END 


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




