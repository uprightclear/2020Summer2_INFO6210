

-- Question 1

SELECT FullName, [2005], [2006], [2007], [2008]
FROM 
(select (p.LastName + ', ' + p.FirstName) FullName, year(sh.OrderDate) OrderYear, SalesOrderID
from Sales.SalesOrderHeader sh
join Sales.Customer c
on sh.CustomerID = c.CustomerID
join Person.Person p
on c.PersonID = p.BusinessEntityID
where sh.CustomerID between 30000 and 30005) AS SourceTable
PIVOT
(
count(SalesOrderID)
FOR OrderYear IN
( [2005], [2006], [2007], [2008] )
) AS PivotTable
ORDER BY FullName;



-- Question 2

with temp as
(select sh.TerritoryID, (p.FirstName + ' ' + p.LastName + ' ') FullName, EmailAddress,
	   rank() over (partition by sh.TerritoryID order by sum(sh.TotalDue) desc) Position
from Sales.SalesOrderHeader sh
join Person.Person p
on sh.SalesPersonID = p.BusinessEntityID
join Person.EmailAddress e
on sh.SalesPersonID = e.BusinessEntityID
group by sh.TerritoryID, p.LastName, p.FirstName, EmailAddress)

select distinct TerritoryID,

STUFF((SELECT  ', ' + FullName + EmailAddress  
       FROM temp t1
       WHERE t1.TerritoryID = t2.TerritoryID and Position <=2
       FOR XML PATH('')) , 1, 2, '') AS Top2Salespersons

from temp t2
order by TerritoryID;



-- Question 3

CREATE TRIGGER utrSalaryAudit 
ON Employee  
AFTER UPDATE
AS  
BEGIN
	IF UPDATE(Salary)
	begin
	   declare @ct smallint, @emp int;

	   select @emp = employeeid from inserted;

	   select @ct = count(employeeid)
	   from SalaryAudit
	   where year(changetime) = year(getdate())
	     and employeeid = @emp;

	   IF @ct >= 2

	       ROLLBACK Transaction

	   ELSE
	      INSERT INTO SalaryAudit (EmployeeID, OldSalary, NewSalary) 
		   SELECT i.EmployeeID, d.Salary, i.Salary
		   FROM inserted i
		   JOIN deleted d
		   ON i.EmployeeID = d.EmployeeID;	  
    end
END





