USE Northwind;

-- update employee table to set up deeper levels of supervisors.
UPDATE Employees
SET ReportsTo = 3
WHERE EmployeeID IN (1, 4);

UPDATE Employees
SET ReportsTo = 4
WHERE EmployeeID IN (8, 9);

SELECT EmployeeID,
	   LastName,
	   FirstName,
	   Title,
	   ReportsTo
FROM Northwind.dbo.Employees;

-- using recursive to show all employees, their immediate manager's name,
-- and the level they are at within the org chart.

WITH DirectReports
AS (
		-- anchor member definition
		SELECT
			  E.ReportsTo,
			  E.EmployeeID,
			  E.LastName,
			  0 AS [Level], -- 0 is the top level
			  CONVERT(NVARCHAR(20), NULL) AS MgrName -- big boss dosen't have manager
		FROM Employees E
		WHERE E.ReportsTo IS NULL
		UNION ALL 
		-- recursive member definition
		SELECT
			  E.ReportsTo,
			  E.EmployeeID,
			  E.LastName,
			  [Level] + 1, 
			  (SELECT LastName 
			   FROM Employees Emp
			   WHERE Emp.EmployeeID = E.ReportsTo) AS MgrName
		FROM Employees E INNER JOIN DirectReports DR
		ON E.ReportsTo = DR.EmployeeID
	)
-- statement that executes the CTE
SELECT
	  ReportsTo,
	  EmployeeID,
	  LastName,
	  [Level],
	  MgrName
FROM DirectReports
ORDER BY [Level], LastName;