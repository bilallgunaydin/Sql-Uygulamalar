--Yeni film kaydeden bir prosed�r yaz�n. Filmi kaydederken film ismini, a��klamas�n�, s�resini ve kategorilerini (birden fazla olabilir) bir kerede arg�man olarak prosed�re ge�ebilmeliyim.


CREATE PROC sp_YeniFilm
@Filmismi varchar(40),
@Aciklama varchar(max),
@Duration int,
@Kategori int
AS 
BEGIN 
INSERT INTO Movies(MovieName,[Description],Duration) VALUES (@Filmismi,@Aciklama,@Duration)
INSERT INTO Movie_Category(MovieID,CategoryID) VALUES ((SELECT MovieID FROM Movies WHERE @Filmismi=MovieName),LEFT(@Kategori,CHARINDEX(',',@Kategori,1)-1))
END

--Filmlere salon ve seans atamas� yapan bir prosed�r yaz�n. 
--Arg�man olarak film ismi, salon kodu, seans saati ve hafta kodu yazaca��m. 
--E�er ki prosed�re hafta kodu g�nderilmemi�se, 
--salon ve seans atamas� i�inde bulundu�um hafta i�in yap�lacak.
-- E�er ki istenen salonda ilgili saat i�erisinde devam etmekte olan bir 
--film varsa kay�t ger�ekle�memelidir. Ayr�ca atama yapt���m saat, 
--salondaki son g�sterilen filmin biti� saatinden en az 30 dk sonra olmal�d�r. 
--Temizlik�ilere s�re ayr�lmas� gerekti�i i�in bir �nceki g�sterimin bitiminden 
--30 dk ge�meyen bir atama ger�ekle�tirilmemelidir ve i�lem iptal edilecektir.
CREATE PROC sp_Atama
@Filmad varchar(40),
@SalonKod int,
@SeansSaat time,
@HaftaKodu varchar(10)
AS
BEGIN
SELECT * FROM Movies m 
JOIN MovieHomePage mh on mh.MovieID=m.MovieID
JOIN Saloons s on s.SaloonID=mh.SaloonID
JOIN [Sessions] se on se.SessionId=mh.SessionID
JOIN Weeks w on w.WeekID=mh.WeekID
if(@HaftaKodu IS NULL)
INSERT INTO MovieHomePage(MovieID,SaloonID,SessionID,WeekID) VALUES
((Select MovieID FROM Movies WHERE @Filmad=MovieName),@SalonKod,(Select SessionId FROM [Sessions] WHERE @SeansSaat=[Session]),
(Select WeekID From Weeks WHERE GETDATE() Between WeekFirstDay and WeekLastDay))
END