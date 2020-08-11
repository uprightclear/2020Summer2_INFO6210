USE Northwind;

SELECT country FROM suppliers
INTERSECT
SELECT country FROM customers;

USE AdventureWorks2008R2;

SELECT ProductID FROM Production.Product
EXCEPT
SELECT ProductID FROM Sales.SalesOrderDetail;