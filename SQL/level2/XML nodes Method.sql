-- XML nodes() Method
declare @x xml;

set @x = (SELECT c.CustomerID CustID, p.FirstName PF, p.LastName PL, o.SalesOrderID OID, o.TotalDue TD
FROM Sales.Customer c
INNER JOIN Sales.SalesOrderHeader o
ON c.CustomerID = o.CustomerID
INNER JOIN Person.Person p
ON c.PersonID = p.BusinessEntityID
ORDER BY c.CustomerID, o.TotalDue DESC
FOR XML AUTO, ROOT('CustomerOrder'), ELEMENTS);

SELECT 
	b.value('CustID[1]', 'int') as CustomerID,
	b.value('(./p/PF)[1]', 'Varchar(50)') as FirstName,
	b.value('(./p/PL)[1]', 'Varchar(50)') as LastName,
	b.value('(./p/o/OID)[1]', 'int') as OrderID,
	b.value('(./p/o/TD)[1]', 'decimal(10,2)') as Amount
FROM @x.nodes('/CustomerOrder/c') AS a(b); -- a is table, b is column.