CREATE TABLE Product
(ProductID int, ProductName nvarchar(50), ListPrice money);

INSERT INTO Product(ProductID, ProductName, ListPrice)
SELECT ProductID, Name, ListPrice
FROM AdventureWorks2008R2.Production.Product;

INSERT INTO Product(ProductID, ProductName, ListPrice)
OUTPUT inserted.ProductID, inserted.ProductName, inserted.ListPrice
VALUES (11111, 'Super Glue', 10);

UPDATE Product
SET ListPrice = (ListPrice + 1.1)
OUTPUT
deleted.ProductID, deleted.ProductName, deleted.ListPrice AS OldPrice, inserted.ListPrice AS NewPrice
WHERE ProductID = 11111;

UPDATE Product
SET ListPrice = (ListPrice + 1.1)
WHERE ProductID = 11111;

DELETE FROM Product
OUTPUT deleted.*
WHERE ProductID = 11111;

CREATE TABLE ProductAudit
(
ProductAudit_PK INT IDENTITY(1,1) NOT NULL,
ProductID INT NOT NULL,
ProductName NVARCHAR(50) NOT NULL,
OldListPrice MONEY NULL,
NewListPrice MONEY NULL,
[Action] CHAR(6) NULL
);

INSERT INTO Product
(ProductID, ProductName, ListPrice)
OUTPUT inserted.ProductID, inserted.ProductName, inserted.ListPrice,'INSERT'
INTO ProductAudit
(ProductID, ProductName, NewListPrice, [Action])
OUTPUT inserted.ProductID, inserted.ProductName, inserted.ListPrice,'INSERT' AS [Action]
VALUES (11111, 'Super Glue', 10);

SELECT * FROM ProductAudit;

UPDATE Product
SET ListPrice = (ListPrice * 1.1)
OUTPUT deleted.ProductID, deleted.ProductName, deleted.ListPrice, inserted.ListPrice, 'UPDATE'
INTO ProductAudit
(ProductID, ProductName, OldListPrice, NewListPrice, [Action])
OUTPUT deleted.ProductID, deleted.ProductName, deleted.ListPrice AS OldPrice, inserted.ListPrice AS NewPrice, 'UPDATE' AS [Action]
WHERE ProductID = 11111;

SELECT * FROM ProductAudit;

DELETE FROM Product
OUTPUT deleted.ProductID, deleted.ProductName, deleted.ListPrice, 'DELETE'
INTO ProductAudit
(ProductID, ProductName, OldListPrice, NewListPrice, [Action])
OUTPUT deleted.ProductID, deleted.ProductName, deleted.ListPrice, 'DELETE' AS [Action]
WHERE ProductID = 11111;

SELECT * FROM ProductAudit;

SELECT * 
FROM ProductAudit
WHERE [Action] = 'UPDATE';

USE master
DROP DATABASE DemoOUTPUT;
