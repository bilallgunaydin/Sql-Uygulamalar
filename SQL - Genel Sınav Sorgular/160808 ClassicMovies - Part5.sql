--Yeni film kaydeden bir prosedür yazýn. Filmi kaydederken film ismini, açýklamasýný, süresini ve kategorilerini (birden fazla olabilir) bir kerede argüman olarak prosedüre geçebilmeliyim.


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

--Filmlere salon ve seans atamasý yapan bir prosedür yazýn. 
--Argüman olarak film ismi, salon kodu, seans saati ve hafta kodu yazacaðým. 
--Eðer ki prosedüre hafta kodu gönderilmemiþse, 
--salon ve seans atamasý içinde bulunduðum hafta için yapýlacak.
-- Eðer ki istenen salonda ilgili saat içerisinde devam etmekte olan bir 
--film varsa kayýt gerçekleþmemelidir. Ayrýca atama yaptýðým saat, 
--salondaki son gösterilen filmin bitiþ saatinden en az 30 dk sonra olmalýdýr. 
--Temizlikçilere süre ayrýlmasý gerektiði için bir önceki gösterimin bitiminden 
--30 dk geçmeyen bir atama gerçekleþtirilmemelidir ve iþlem iptal edilecektir.
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