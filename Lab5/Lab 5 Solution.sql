
/* Question 1 */

create function salesByMonthYear
(@month int, @year int)
returns money
As
Begin 
	Declare @sale money;
	select @sale = isnull( sum(TotalDue) , 0)
	from sales.SalesOrderHeader
	where month(orderDate) = @month AND year(OrderDate) = @year
	return @sale;
End

select dbo.salesByMonthYear(2005, 3);
drop function dbo.salesByMonthYear;


/* Question 2 */

CREATE TABLE Customer
(CustomerID INT PRIMARY KEY,
CustomerLName VARCHAR(30),
CustomerFName VARCHAR(30));

CREATE TABLE SaleOrder
(OrderID INT IDENTITY PRIMARY KEY,
CustomerID INT REFERENCES Customer(CustomerID),
OrderDate DATE,
LastModified datetime);

CREATE TABLE SaleOrderDetail
(OrderID INT REFERENCES SaleOrder(OrderID),
ProductID INT,
Quantity INT,
UnitPrice INT,
PRIMARY KEY (OrderID, ProductID));

CREATE TRIGGER dbo.utrLastModified
ON dbo.SaleOrderDetail 
AFTER INSERT, UPDATE, DELETE
AS  BEGIN
    DECLARE @oid INT;
	SET @oid = ISNULL((SELECT OrderID FROM Inserted), (SELECT OrderID FROM Deleted));
    UPDATE dbo.SaleOrder SET LastModified = GETDATE()
	WHERE OrderID = @oid
	END


