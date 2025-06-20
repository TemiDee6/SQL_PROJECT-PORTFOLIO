--SQL PORTFOLIO PROJECT

--15 queries focusing strictly on Joins and Subqueries AdventureWorks file

--1st Query- Simple INNER JOIN
SELECT p.Name, p.ListPrice, pr.Name AS ProductSubcategory
FROM Production.Product p
JOIN Production.ProductSubcategory pr ON p.ProductSubcategoryID = pr.ProductSubcategoryID;

--2nd Query - INNER JOIN with WHERE
SELECT s.SalesOrderID, c.CustomerID
FROM Sales.SalesOrderHeader s
JOIN Sales.Customer c ON s.CustomerID = c.CustomerID
WHERE s.TotalDue > 1000;
Select* from Sales.Customer
Select* from Sales.SalesOrderHeader


--3rd Query - LEFT JOIN
SELECT p.Name, pr.Name AS ProductSubcategory
FROM Production.Product p
LEFT JOIN Production.ProductSubcategory pr ON p.ProductSubcategoryID = pr.ProductSubcategoryID;

--4th Question - RIGHT JOIN
SELECT pr.Name AS ProductSubcategory, p.Name AS ProductName
FROM Production.Product p
RIGHT JOIN Production.ProductSubcategory pr ON p.ProductSubcategoryID = pr.ProductSubcategoryID;

--5th Query - FULL OUTER JOIN
SELECT p.Name AS ProductName, pr.Name AS ProductSubcategory
FROM Production.Product p
FULL OUTER JOIN Production.ProductSubcategory pr ON p.ProductSubcategoryID = pr.ProductSubcategoryID;

--6th Query - CROSS JOIN
SELECT p.Name AS ProductName, pr.Name AS ProductSubcategory
FROM Production.Product p
CROSS JOIN Production.ProductSubcategory pr;

--7th Query - JOIN with Aggregate
SELECT pr.Name AS Subcategory, COUNT(p.ProductID) AS ProductCount
FROM Production.Product p
JOIN Production.ProductSubcategory pr ON p.ProductSubcategoryID = pr.ProductSubcategoryID
GROUP BY pr.Name;

--8th Query - Subquery in SELECT
SELECT p.Name, (SELECT AVG(ListPrice) FROM Production.Product) AS AvgPrice
FROM Production.Product p;

--9th Query - Subquery in WHERE
SELECT p.Name, p.ListPrice
FROM Production.Product p
WHERE p.ListPrice > (SELECT AVG(ListPrice) FROM Production.Product);

--10th Query - Subquery in FROM
SELECT SubCategoryName, ProductCount
FROM (SELECT pr.Name AS SubCategoryName, COUNT(p.ProductID) AS ProductCount
FROM Production.Product p
JOIN Production.ProductSubcategory pr ON p.ProductSubcategoryID = pr.ProductSubcategoryID
GROUP BY pr.Name) AS SubQueryResult;


--11th Query - Correlated Subquery
SELECT p.Name, p.ListPrice
FROM Production.Product p
WHERE p.ListPrice > (SELECT AVG(p2.ListPrice)
FROM Production.Product p2
WHERE p2.ProductSubcategoryID = p.ProductSubcategoryID);

--12th Query - JOIN with Subquery in WHERE
SELECT c.PersonID, c.CustomerID
FROM Sales.Customer c
JOIN Sales.SalesOrderHeader s ON c.CustomerID = s.CustomerID
WHERE s.TotalDue > (SELECT AVG(TotalDue)
FROM Sales.SalesOrderHeader);

--13th Query - JOIN with Subquery in SELECT
SELECT s.SalesOrderID, s.TotalDue, 
(SELECT COUNT(*) FROM Sales.SalesOrderDetail d WHERE d.SalesOrderID = s.SalesOrderID) AS LineItems
FROM Sales.SalesOrderHeader s;

--14th Query -Nested Subquery
SELECT p.Name, p.ListPrice
FROM Production.Product p
WHERE p.ListPrice > (
SELECT MAX(AvgPrice)
FROM (
SELECT AVG(ListPrice) AS AvgPrice
FROM Production.Product
GROUP BY ProductSubcategoryID
) AS SubQuery);

--15th Multi-table JOIN
SELECT soh.SalesOrderID, c.CustomerID, p.Name AS ProductName
FROM Sales.SalesOrderHeader soh
JOIN Sales.Customer c ON soh.CustomerID = c.CustomerID
JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
JOIN Production.Product p ON sod.ProductID = p.ProductID;