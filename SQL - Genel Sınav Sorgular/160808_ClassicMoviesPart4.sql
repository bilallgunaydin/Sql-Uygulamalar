--��inde bulundu�um haftan�n t�m filmlerini, t�m seanslar�n� ve salon detaylar�n� getiren bir view olu�turun.
--Gelecek hafta g�sterime yeni girecek filmleri getiren bir view olu�turun. Filmin hangi salonda ve hangi seansta g�sterime girece�ini ayn� view �zerinden g�rebilmeliyim.
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