----- Basit Subquery Örnekleri ----
-- 1 -- "Nancy" isimli çalýþanýmýn yaptýðý satýþlarý gösteriniz.
-- 2 -- "Federal Shipping" isimli firmanýn taþýdýðý sipariþ sayýsýný gösteriniz.
-- 3 -- Tedarikçisi "Karkki Oy" olan ve stokta 10 adetten fazla olan ürünlerin listesini görüntüleyiniz.
-- 4 -- Fax numarasý olmayan tedarikçilerden aldýðým ürünleri görüntüleyiniz.
-- 5 -- "a" harfi ile baþlayan müþterilerin sipariþlerini listeleyiniz.


--SORU 1 
Select * From Orders 
Where EmployeeID =(Select EmployeeID From Employees Where FirstName ='Nancy') 

--SORU 2 
Select Count(*) From Orders
Where ShipVia = (Select ShipperID From Shippers Where CompanyName='Federal Shipping')

--SORU 3 
Select * From Products
Where SupplierID=(Select SupplierID From Suppliers Where CompanyName='Karkki Oy') and UnitsInStock>10 

--SORU 4 
Select * From Products
Where SupplierID  IN(Select SupplierID From Suppliers Where Fax is NULL)

--SORU 5
Select * From Orders 
Where CustomerID IN (Select CustomerID From Customers Where ContactName Like'a%')



----- UYGULAMA -------------------
-- 1 -- Her çalýþanýmýn amirini görüntüleyiniz 
-- 2 -- Her bir kategoriden kaç ürün satýlmýþ
-- 3 -- Her bir kategoriden kazandýðým paranýn KDV'sini hesaplayýnýz.
-- 4 -- Ayný soyada sahip çalýþanlar ve müþteri yetkililerini tek bir tabloda gösteriniz. (Zaten yapýlan soru ama subquery ile yapýlabilir mi?)
-- 5 -- Her bir üründen kazandýðým paranýn toplam kazandýðým paraya oranýný gösteren sorguyu yazýnýz.


---SORU 1 
Select e.FirstName amir,(Select ep.FirstName Calisan From Employees ep Where e.ReportsTo=ep.EmployeeID) From Employees e

---Soru 2
Select CategoryName,Sum(Quantity) From Categories c
join Products p on c.CategoryID=p.CategoryID
join [Order Details] od on od.ProductID=p.ProductID
Group by CategoryName

---Soru 3 
Select CategoryName,SUM(od.UnitPrice*od.Quantity*(1-od.Discount))*(1-0.08) From Categories c
join Products p on c.CategoryID=p.CategoryID
join [Order Details] od on od.ProductID=p.ProductID
Group by CategoryName


---Soru 4 
Select * From Employees 
WHERE LastName IN(Select right(ContactName,charindex(' ',reverse(rtrim(ContactName)))-1) from Customers )

---SORU 5



