INSERT INTO Movie_Category (MovieID,CategoryID) 
VALUES (1,1),(1,2),(2,3),(2,4),(2,5),(3,4),(3,2),
(4,2),(5,6),(5,3),(5,2),(6,3),(6,4),(6,5),(7,4),
(7,2),(7,5),(8,6),(8,3),(8,4),(9,1),(9,2),(9,7),
(10,3),(10,4),(10,5)


INSERT INTO MovieHomePage (MovieID,SaloonID,SessionID,WeekID)
VALUES (1,1,1,1),(1,1,4,1),(1,1,6,1),(1,1,8,1),(1,2,7,1),(1,2,9,1),
(2,2,1,1),(2,2,3,1),(2,2,5,1),
(3,3,1,1),(3,3,4,1),(3,3,6,1),(3,3,8,1),
(4,4,7,1),(4,4,9,1),(5,4,2,1),(5,4,4,1),(5,4,5,1),
(1,1,1,2),(1,1,4,2),(1,1,6,2),(1,1,8,2),
(6,2,1,2),(6,2,3,2),(6,2,5,2),(6,2,7,2),(6,2,9,2),
(7,3,1,2),(7,3,3,2),(7,3,5,2),(7,3,7,2),(7,3,9,2),
(4,4,7,2),(4,4,9,2),(8,4,2,2),(8,4,4,2),(8,4,5,2),
(9,1,1,3),(9,1,10,3),(9,1,11,3),(9,3,5,3),(9,3,8,3),
(10,2,1,3),(10,2,3,3),(10,2,5,3),(10,2,7,3),(10,2,12,3),
(7,3,1,3),(7,3,3,3),(11,4,1,3),(11,4,4,3),(11,4,6,3),(11,4,8,3)

Select*From [Sessions]
Select* From Movies


--"Jenny Curran" ile ilgili açýklama içeren film hangisidir? Filmin detaylarýný getirin.
SELECT * FROM Movies
WHERE [Description] LIKE '%Jenny Curran%'


--32. haftada hangi filmler gösterimdedir? Film detaylarýný sürelerine göre sýralayarak getirin.
Select DISTINCT m.MovieName,m.Duration,m.[Description] From MovieHomePage mh
JOIN Movies m on m.MovieID=mh.MovieID
WHERE mh.WeekID=1
order by m.Duration


--33. haftada hangi filmler gösterime yeni girmiþtir? (Geçtiðimiz haftadan farklý olarak yeni gösterime giren filmler nelerdir)
Select DISTINCT m.MovieName From MovieHomePage mh
JOIN Movies m on m.MovieID=mh.MovieID
WHERE mh.WeekID=2 And mh.MovieID NOT IN (SELECT DISTINCT mp.MovieID FROM MovieHomePage mp WHERE mp.WeekID=1) 


--Sinemamdaki salonlarý ve kapasitelerini getirin.
Select * From Saloons


--Sinemamda toplam kaç salon ve toplam kaç koltuk vardýr?
Select Count(SaloonName),Sum(Capacity) From Saloons


--3 Hafta boyunca kaç farklý film gösterime sunulmuþtur?
Select  Count(DISTINCT MovieID) From MovieHomePage Where WeekID IN(1,2,3)


--3 Hafta boyunca sinema salonlarýmda birbirinden farklý kaç film gösterilmiþtir? Sinema salon bilgileri yanýnda sayý olarak getirin.
Select  SaloonName,Count(*) FROM (Select DISTINCT Saloons.SaloonID,MovieID FROM MovieHomePage mh 
JOIN Saloons on Saloons.SaloonID=mh.SaloonID ) d
JOIN Saloons s on s.SaloonID=d.SaloonID
group by SaloonName


--Film ile ilgili detaylarý, filmlerin toplam gösterim sayýsýyla birlikte görüntüleyin. Gösterim sayýsýna göre sýralayýn.
Select m.MovieName,(Count(*)*7),Duration,[Description] From Movies m
JOIN MovieHomePage mh on mh.MovieID=m.MovieID
Group by m.MovieName,Duration,[Description]


--Tüm gösterimleri kapalý giþe oynamasý durumunda 33. ve 34. haftalarýn toplamýnda en çok seyircinin izleyebileceði ilk 3 film hangisidir?
SELECT TOP 3 m.MovieName,(SUM(s.Capacity)*7) Toplamkisi FROM MovieHomePage mh
JOIN Saloons s on s.SaloonID=mh.SaloonID
JOIN Movies m on m.MovieID=mh.MovieID
WHERE mh.WeekID IN('2','3') 
Group by m.MovieName
order by Toplamkisi DESC


--Salonlarýmda film gösterimi olmayan dakikalarý merak ediyorum. 3 haftalýk dilime ayýrarak salon boþ kalma sürelerini haftalýk gösterim ile ayrý ayrý getirin.
Select DISTINCT SaloonID,DATEDIFF(HOUR,MIN([Session]),(MAX([Session]))),WeekID From MovieHomePage mh
JOIN [Sessions] s on s.SessionId=mh.SessionID
JOIN Movies m on m.MovieID=mh.MovieID
WHERE WeekID = 1
Group by SaloonID,WeekID
UNION ALL
Select DISTINCT SaloonID,DATEDIFF(HOUR,MIN([Session]),(MAX([Session]))),WeekID From MovieHomePage mh
JOIN [Sessions] s on s.SessionId=mh.SessionID
JOIN Movies m on m.MovieID=mh.MovieID
WHERE WeekID = 2
Group by SaloonID,WeekID
UNION ALL
Select DISTINCT SaloonID,DATEDIFF(HOUR,MIN([Session]),(MAX([Session]))),WeekID From MovieHomePage mh
JOIN [Sessions] s on s.SessionId=mh.SessionID
JOIN Movies m on m.MovieID=mh.MovieID
WHERE WeekID = 3
Group by SaloonID,WeekID

--Temizlik iþçilerimin 3 haftalýk son çýkýþ saatleri nelerdir? (Sinema gösteriminden sonraki 30dk'lýk temizlik süresini hesaba katýnýz)
Select s.SaloonID,WeekID,DATEADD(MINUTE,30,MAX([Session])) FROM MovieHomePage mh
JOIN Movies m on m.MovieID=mh.MovieID
JOIN Saloons s on s.SaloonID=mh.SaloonID
JOIN [Sessions] se on se.SessionId=mh.SessionID
Group by s.SaloonID,WeekID



--3 ve daha fazla kategoriye sahip filmlerden hangileri bilim kurgu deðildir?
SELECT mc.MovieID FROM Movies m
JOIN Movie_Category mc on mc.MovieID=m.MovieID
WHERE mc.CategoryID!=5
group by mc.MovieID
HAVING Count(*)>=3


--Hangi filmler güldürürken ayný zamanda düþündürmüþtür? (hem komedi hem de drama olan filmler)
Select m.MovieName From Movies m
JOIN Movie_Category mc on mc.MovieID=m.MovieID
JOIN Categories c on c.CategoryID=mc.CategoryID
WHERE mc.CategoryID=2 and mc.MovieID IN (Select MovieID From Movie_Category WHERE Movie_Category.CategoryID=4)