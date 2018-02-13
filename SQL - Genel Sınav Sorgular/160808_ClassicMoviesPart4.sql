--Ýçinde bulunduðum haftanýn tüm filmlerini, tüm seanslarýný ve salon detaylarýný getiren bir view oluþturun.
--Gelecek hafta gösterime yeni girecek filmleri getiren bir view oluþturun. Filmin hangi salonda ve hangi seansta gösterime gireceðini ayný view üzerinden görebilmeliyim.
CREATE VIEW vw_HaftalikFilm

AS
Select m.MovieName,s.SaloonName,se.[Session],mh.WeekID From Movies m
JOIN MovieHomePage mh on mh.MovieID=m.MovieID
JOIN Saloons s on s.SaloonID=mh.SaloonID
JOIN [Sessions] se on se.SessionId=mh.SessionID
JOIN Weeks w on w.WeekID=mh.WeekID
WHERE  GETDATE() Between w.WeekFirstDay and w.WeekLastDay


CREATE VIEW vw_GelecekHafta
AS
Select m.MovieName,s.SaloonName,se.[Session],mh.WeekID From Movies m
JOIN MovieHomePage mh on mh.MovieID=m.MovieID
JOIN Saloons s on s.SaloonID=mh.SaloonID
JOIN [Sessions] se on se.SessionId=mh.SessionID
JOIN Weeks w on w.WeekID=mh.WeekID
WHERE (GETDATE()+7) Between w.WeekFirstDay and w.WeekLastDay