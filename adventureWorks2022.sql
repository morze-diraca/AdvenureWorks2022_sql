-- male employees whose last name starts with 'N'
SELECT
	p.FirstName AS Imie
	,p.LastName AS Nazwisko
FROM HumanResources.Employee e
JOIN Person.Person p ON e.BusinessEntityID = p.BusinessEntityID
WHERE e.Gender = 'M'
AND p.LastName LIKE 'N%';

-- previous list limited to first 10 rows
SELECT TOP (10)
	p.FirstName AS Imie
	,p.LastName AS Nazwisko
FROM HumanResources.Employee e
JOIN Person.Person p ON e.BusinessEntityID = p.BusinessEntityID
WHERE e.Gender = 'M'
AND p.LastName LIKE 'N%';

-- list od products from Z-A
SELECT Name AS Produkt
FROM Production.Product
ORDER BY Name DESC;

-- list of unique job titles
SELECT DISTINCT JobTitle AS Stanowisko
FROM HumanResources.Employee;

-- number of employees in 'Sales' department
SELECT COUNT(*) AS LiczbaPracownikow
FROM HumanResources.EmployeeDepartmentHistory edh
JOIN HumanResources.Department d ON edh.DepartmentID = d.DepartmentID
WHERE d.Name = 'Sales'
AND edh.EndDate IS NULL;

-- view of employees whose job title is 'Accounts Payable Specialist'
CREATE VIEW vw_AP AS
SELECT
	p.FirstName AS Imie
	,p.LastName AS Nazwisko
	,e.JobTitle	AS Stanowisko
FROM HumanResources.Employee e
JOIN Person.Person p ON e.BusinessEntityID = p.BusinessEntityID
WHERE JobTitle = 'Accounts Payable Specialist';

-- view of employees showing also their gender
CREATE VIEW vw_Pracownicy AS
SELECT 
	p.FirstName AS Imie
	,p.LastName AS Nazwisko
	,e.JobTitle	AS Stanowisko
	,e.Gender	AS Płeć
FROM Person.Person p
JOIN HumanResources.Employee e
ON p.BusinessEntityID = e.BusinessEntityID;

-- view of total transaction amounts per sales' person
CREATE VIEW vw_SprzedazPracownikow
AS
SELECT
    p.FirstName 	AS Imię
    ,p.LastName 	AS Nazwisko
    ,SUM(s.TotalDue) 	AS SumaTransakcji
FROM Person.Person p
JOIN Sales.SalesOrderHeader s
ON p.BusinessEntityID = s.SalesPersonID
GROUP BY p.FirstName, p.LastName;
