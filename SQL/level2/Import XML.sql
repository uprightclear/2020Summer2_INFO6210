USE Northwind;

-- create an element-centric XML document.
SELECT c.CustomerID [CustID], CompanyName [Company], o.OrderID, o.OrderDate, o.CustomerID
FROM Customers c 
INNER JOIN Orders o
ON c.CustomerID = o.CustomerID 
ORDER BY c.CustomerID
FOR XML AUTO, ROOT('CustOrdRoot'), ELEMENTS;

-- create a table for importing customer data.
IF  EXISTS(SELECT name FROM sys.tables WHERE name = 'CustomersXML')
	DROP TABLE CustomersXML;
GO
SELECT CustomerID, CompanyName
INTO CustomerXML
FROM Customers
WHERE 1=2; --make sure no data will be transferred
GO

-- required to open XML file and get contents into memory.
DECLARE @XML xml;
SELECT @XML = x.a
FROM OPENROWSET(BULK 'C:\Users\uprig\Desktop\XML.xml', SINGLE_BLOB) AS X(a);


