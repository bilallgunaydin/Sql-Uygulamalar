--------------------------------------------------
----------STORED PROCEDURE(SAKLI YORDAM)----------
-- En çok satan ilk 5 ürünümü prosedure haline getiriniz.

SELECT TOP 5 p.ProductName, SUM(od.Quantity) EnCokSatan FROM Products p
JOIN [Order Details] od ON od.ProductID=p.ProductID
GROUP BY p.ProductName
ORDER BY  EnCokSatan DESC

GO
CREATE PROCEDURE sp_EnCokSatilan5Urun
AS 
BEGIN
SELECT TOP 5 p.ProductName, SUM(od.Quantity) EnCokSatan FROM Products p
JOIN [Order Details] od ON od.ProductID=p.ProductID
GROUP BY p.ProductName
ORDER BY  EnCokSatan DESC

END

EXECUTE sp_EnCokSatilan5Urun
EXEC sp_EnCokSatilan5Urun


-- Kargocu kaydý ekleyen proc yazýnýz.
GO

Select * From Shippers
GO
CREATE PROC sp_KargocuEkle
@JhonDoe NVARCHAR(50),
@Telefon CHAR(15)
AS 
BEGIN
INSERT INTO Shippers(CompanyName,Phone) VALUES(@JhonDoe,@Telefon)
END

EXEC sp_KargocuEkle 'Bilal Kargo','555-1122'

----------------------
-- Dýþarýdan girilen miktar kadar ürüne zam yapan proc yazýnýz.
GO
CREATE PROC sp_MiktariArttir
@Fiyat int
AS
BEGIN
UPDATE Products
SET UnitPrice=UnitPrice+@Fiyat
END

EXEC sp_MiktariArttir 5


--------------------------------
-- DATABASE oluþturan prosedürü yazýnýz.

--Adýný yazdýðým ürüne ait ciromu hesaplayan proc?
GO
CREATE PROC sp_KazancCiro
@Ciro VARCHAR(50)
AS
BEGIN
SELECT SUM(p.UnitPrice*Quantity*(1-Discount)) FROM Products p
JOIN [Order Details] od on od.ProductID=p.ProductID
WHERE ProductName=@Ciro
END

EXEC sp_KazancCiro 'Chai'
Select * From Products
-- Adýný yazdýðým ürünü veri tabanýna kaydeden, eðer ayný isimden kayýt varsa kaydetmeyip o isimdeki ürün kaydýný sonuç olarak döndüren proc yazýnýz.
GO
CREATE PROC sp_Kontrol
@isim VARCHAR(20)
AS
BEGIN
IF(@isim=(SELECT ProductName FROM Products WHERE ProductName=@isim))
	PRINT 'Hatalý Kullaný Kayýdý'
ELSE 
	INSERT INTO Products (ProductName) VALUES (@isim)
END

SELECT * FROM Products

EXEC sp_Kontrol 'Chai'



---Parametre olarak kategori adý ve ürün adý alan PROC yazýnýz.Adý girilen kategori yoksa eklenecek.adý girilen ürün yoksa eklenecek ve ürün kategorIDsi adýný yazdýðým kategorinin idsi olacak
GO
CREATE PROC sp_degisim
@Urun VARCHAR(20),
@Kategori VARCHAR(20), @IdKontrol int= 0
AS
BEGIN

IF(@Kategori=(SELECT CategoryName FROM Categories WHERE CategoryName=@Kategori))
	SET @IdKontrol=(SELECT CategoryID FROM Categories WHERE CategoryName=@Kategori)
ELSE 
	INSERT INTO Categories(CategoryName) VALUES (@Kategori)
	SET @IdKontrol=(SELECT CategoryID FROM Categories WHERE CategoryName=@Kategori)

IF(@Urun=(SELECT ProductName FROM Products WHERE ProductName=@Urun))
	UPDATE Products
	SET CategoryID=@IdKontrol
ELSE 
	INSERT INTO Products (ProductName) VALUES (@Urun)
	UPDATE Products
	SET CategoryID=@IdKontrol
END

DROP PROC sp_degisim
SELECT * FROM Categories
SELECT * FROM Products




-- Belirsiz sayýda ürün ismin ürünler tablosuna insert eden program yazýnýz.
GO
CREATE PROC sp_Belirsiz
@yazi VARCHAR(30),
@sayi int=0,
@sayi2 int=1
AS 
BEGIN
While(@sayi<@sayi2)
INSERT INTO Products (ProductName) VALUES(@yazi)

END





--Idsini ve miktarýný yazdýðým ürünü,yine ID sini yazdýðým müþterime sipariþ oluþturan PROC yazýnýz.

