
-- S2 Last Digit 7, 8 or 9 Quiz 1

-- Question 3

SELECT cast(OrderDate as date) Date,
       sum(OrderQty) TotalProductQuantitySold
FROM Sales.SalesOrderHeader so
JOIN Sales.SalesOrderDetail sd
ON so.SalesOrderID = sd.SalesOrderID
WHERE OrderDate NOT IN
(SELECT OrderDate
 FROM Sales.SalesOrderHeader sh
 JOIN Sales.SalesOrderDetail sd
      ON sh.SalesOrderID = sd.SalesOrderID
 JOIN Production.Product p
      ON p.ProductID = sd.ProductID
 WHERE p.Color = 'Red')
GROUP BY OrderDate
ORDER BY TotalProductQuantitySold desc;



-- Question 4

with temp as
(select year(OrderDate) OrderYear, Color, sum(OrderQty) TotalSoldQuantity,
        rank() over (partition by year(OrderDate) order by sum(OrderQty) asc) Popularity
from Sales.SalesOrderHeader sh
join Sales.SalesOrderDetail sd
on sh.SalesOrderID = sd.SalesOrderID
join Production.Product p
on sd.ProductID = p.ProductID
where color is not null
group by year(OrderDate), Color)

select * from temp
where popularity = 1
order by OrderYear;



