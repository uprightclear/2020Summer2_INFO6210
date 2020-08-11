USE Northwind;

-- which countries are common to both suppliers and customers?
-- Below are 3 different queries to accomplish the same result.

-- uses INTERSECT
SELECT country FROM Suppliers
INTERSECT
SELECT country FROM Customers

-- uses IN and subquery
SELECT DISTINCT country
FROM Suppliers
WHERE country IN (SELECT DISTINCT country FROM Customers);

-- uses INNER JOIN
SELECT DISTINCT Suppliers.Country
FROM Suppliers 
INNER JOIN Customers
ON Suppliers.Country = Customers.Country;