------- SORU 1 
----- 1 -- Her bir �al��an�m her �r�n� ka�ar tane satm��

Select e.FirstName,ProductName,Sum(od.Quantity) from Employees e
join Orders o on o.EmployeeID=e.EmployeeID
join [Order Details] od on od.OrderID=o.OrderID
join Products p on p.ProductID=od.ProductID
group by e.FirstName,ProductName
order by e.FirstName


-----SORU 2
----- 2 --ayn� soyada sahip �al��anlar ve m��teri yetkililerini tek bir tablo sonucu olarak listeleyiniz.
Select LastName From Employees 
Intersect
Select right(ContactName,charindex(' ',reverse(rtrim(ContactName)))-1) from Customers

----SORU 3
/*hangi sipari�i, hangi �al��an, hangi tarihte, hangi m��teriye satm��, 
sipari� hangi kargo �irketi ile g�nderilmi�, 
sipari� i�erisinde ge�en �r�nlerin isimleri ve bu �r�nlerin kategori isimleri nedir?*/
Select o.OrderID,e.FirstName,o.OrderDate,c.CustomerID,su.CompanyName,p.ProductName,ca.CategoryName from Orders o
join Employees e on o.EmployeeID=e.EmployeeID
join Customers c on c.CustomerID=o.CustomerID
join [Order Details] od on od.OrderID=o.OrderID
join Products p on p.ProductID=od.ProductID
join Suppliers su on su.SupplierID=p.SupplierID
join Categories ca on ca.CategoryID=p.CategoryID


----SORU 4 
---- 4 -- en ge� teslim edilen sipari�i hangi m��teri alm�� ve hangi �al��an satm��
Select TOP 1 DATEDIFF(Day,RequiredDate,ShippedDate) As Fark,c.ContactName,e.FirstName from Customers c
join Orders o on o.CustomerID=c.CustomerID
join Employees e on e.EmployeeID=o.EmployeeID
order by Fark DESC


----SORU 5 
---- 5 -- kendi �lkesine sipari� g�nderen �al��anlar
Select DISTINCT e.FirstName From Orders o 
join Employees e on e.EmployeeID=o.EmployeeID
Where e.Country=o.ShipCountry

----SORU 6
----- 6 -- 1997 y�l�n�n hangi aylar�nda sipari� al�nm��? (ingilizce ay isimleri)
Select DISTINCT CASE
WHEN Month(OrderDate) = 1 THEN'January'
WHEN Month(OrderDate) = 2 THEN'February'
WHEN Month(OrderDate) = 3 THEN'March'
WHEN Month(OrderDate) = 4 THEN'April'
WHEN Month(OrderDate) = 5 THEN'May'
WHEN Month(OrderDate) = 6 THEN'June'
WHEN Month(OrderDate) = 7 THEN'July'
WHEN Month(OrderDate) = 8  THEN'August'
WHEN Month(OrderDate) = 9  THEN'September'
WHEN Month(OrderDate) = 10 THEN'October'
WHEN Month(OrderDate) = 11 THEN'November'
WHEN Month(OrderDate) = 12 THEN'December'
END
 from Orders
where Year(OrderDate)<1998 and Year(OrderDate)>1996

Select DISTINCT DATENAME(Month,OrderDate) from Orders o 
Where Year(OrderDate) Between 1996 and 1998
----SORU 7
-- 7 -- ismi 4 harften fazla olan ve 5.harfi C olan �r�nlerden ka� tane vard�r?
Select COUNT(ProductName) From Products Where Len(ProductName)>4 and SUBSTRING(ProductName,5,1)='c'

----SORU 8 
-- 8 -- London ve Seattle' l� olan �al��anlar�n ya�lar� toplam� ka�t�r?

Select SUM(YEAR(GETDATE())-YEAR(BirthDate)) from Employees
Where City = 'London' or City = 'Seattle'


----SORU 9 
--- sto�u en fazla olan �r�n�n kategorisinin 4�nc� harfi nedir?
Select TOP 2 SUBSTRING(c.CategoryName,4,1),UnitsInStock From Products p
join Categories c on p.CategoryID=c.CategoryID
order by UnitsInStock DESC

----SORU 10
----- 10 -- En �ok para kazand���m ilk 5 m��teriye �zel �yelik vermek istiyorum. Bu m��terilerim kimlerdir? Bu �irketlere �ifre tan�mlamak istiyorum.Telefon numaras�n�n son 4 harfi

Select TOP 5 SUM(od.UnitPrice*Quantity*(1-Discount)) Pahali,c.CompanyName ,RIGHT(Replace(Phone,' ',''),4) as telefon
From Customers c
join Orders o on c.CustomerID=o.CustomerID
join [Order Details] od on od.OrderID=o.OrderID
group by c.CompanyName,Phone
Order By Pahali Desc