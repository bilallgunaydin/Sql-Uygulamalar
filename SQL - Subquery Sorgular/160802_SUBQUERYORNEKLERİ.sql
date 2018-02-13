----- Basit Subquery �rnekleri ----
-- 1 -- "Nancy" isimli �al��an�m�n yapt��� sat��lar� g�steriniz.
-- 2 -- "Federal Shipping" isimli firman�n ta��d��� sipari� say�s�n� g�steriniz.
-- 3 -- Tedarik�isi "Karkki Oy" olan ve stokta 10 adetten fazla olan �r�nlerin listesini g�r�nt�leyiniz.
-- 4 -- Fax numaras� olmayan tedarik�ilerden ald���m �r�nleri g�r�nt�leyiniz.
-- 5 -- "a" harfi ile ba�layan m��terilerin sipari�lerini listeleyiniz.


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
-- 1 -- Her �al��an�m�n amirini g�r�nt�leyiniz 
-- 2 -- Her bir kategoriden ka� �r�n sat�lm��
-- 3 -- Her bir kategoriden kazand���m paran�n KDV'sini hesaplay�n�z.
-- 4 -- Ayn� soyada sahip �al��anlar ve m��teri yetkililerini tek bir tabloda g�steriniz. (Zaten yap�lan soru ama subquery ile yap�labilir mi?)
-- 5 -- Her bir �r�nden kazand���m paran�n toplam kazand���m paraya oran�n� g�steren sorguyu yaz�n�z.


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



