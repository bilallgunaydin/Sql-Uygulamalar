/*
1. T�m filmleri izlesem ne kadar s�rer? (Dakika olarak | Saat olarak | G�n olarak)
2. Filmlerin ald��� ortalama puan i�in View yaz�n (55 | Alpha Beta | 7.4)
3. En gen� ya�ta y�netmenlik yapan ki�i kimdir?
4. Ray Malifalitiko'nun son oynad��� filmdeki rol� nedir?
5. 2003 y�l�nda �ekilmi� filmlerin aktrisleri ve rolleri nelerdir?
6. En merakl� izleyicim kimdir? (En �ok oy veren Kullan�c�)
7. Kay�tl� filmlere ortalama ka� tane oy veriliyor?
8. Hangi filmlerin yazar say�s� 2 ve daha fazlad�r?
9. Bir filmde oyunculuk (Star, Performer) d���nda da g�rev alan ki�iler kimlerdir?
   (Ki�i ad� ve film ad� �eklinde getirin)
10.T�rlere g�re film say�s� da��l�m� nas�l?
	1. Romance | 12
	2. Horror | 4
	gibi
11.En �ok ba�rol oynayan Akt�r kimdir? 
12.Kemal Sunal rol�nde oynayan akt�r ve oynad��� film hangisidir?
**********
13.Hi�bir filmde g�rev almam�� ki�iler kimlerdir?
14.�u ana kadar sadece y�netmenlik yapm�� ki�iler kimlerdir?
15.Do�u�tan y�ld�z olan ki�iler kimlerdir? (Yaln�zca ba�rol oynam�� olanlar)
16.Ne i� olsa yapar�m abi diyenler kimler? (Her g�revde bulunmu� ki�iler)
*/
--1. T�m filmleri izlesem ne kadar s�rer? (Dakika olarak | Saat olarak | G�n olarak)
Select CAST (SUM(Duration)%60 AS VARCHAR(50))+' Dakika '+CAST ((SUM(Duration)/60)%24 AS VARCHAR(50))+' Saat '+ CAST (SUM(Duration)/60/24 AS VARCHAR(50))+' G�N ' From Movie 


--2. Filmlerin ald��� ortalama puan i�in View yaz�n (55 | Alpha Beta | 7.4)
CREATE VIEW vw_OrtalamaFilm
AS
SELECT  m.Name,AVG(r.Rate) AS ORTALAMA FROM Movie m
JOIN Rating r on r.MovieId=m.Id
GROUP BY m.Name

--3. En gen� ya�ta y�netmenlik yapan ki�i kimdir?
SELECT TOP 1 p.FirstName,p.LastName,d.Id FROM Duty d
JOIN MoviePerson mp on d.Id=mp.DutyId
JOIN Person p on p.Id=mp.PersonId
WHERE DutyId=1
Order by DateOfBirth ASC

--4. Ray Malifalitiko'nun son oynad��� filmdeki rol� nedir?

SELECT TOP 1 mp.PerformedAs FROM  Person p
JOIN MoviePerson mp on p.Id=mp.PersonId
JOIN Movie m on m.Id=mp.MovieId
WHERE p.FirstName='Ray' and p.LastName='Malifalitiko'
order by m.[Year] DESC

--5. 2003 y�l�nda �ekilmi� filmlerin aktrisleri ve rolleri nelerdir?
SELECT p.FirstName+' '+p.LastName,PerformedAs,m.[Year] FROM Movie m
JOIN MoviePerson mp on mp.MovieId=m.Id
JOIN Person p on p.Id=mp.PersonId
JOIN Duty d on d.Id=mp.DutyId
WHERE m.[Year] = '2003' and  d.Name='Star'

--6. En merakl� izleyicim kimdir? (En �ok oy veren Kullan�c�)
SELECT TOP 1 UserId,COUNT(*) SIRALAMA FROM Rating r 
JOIN [User] u on r.UserId=u.Id
GROUP BY UserId
ORDER BY SIRALAMA DESC

--7. Kay�tl� filmlere ortalama ka� tane oy veriliyor?
SELECT COUNT(*)/COUNT(DISTINCT(MovieId)) FROM Rating

--8. Hangi filmlerin yazar say�s� 2 ve daha fazlad�r?

SELECT MovieId,COUNT(PersonId) FROM MoviePerson WHERE DutyId=2
GROUP BY MovieId
HAVING 
COUNT(PersonId)>=2

--9. Bir filmde oyunculuk (Star, Performer) d���nda da g�rev alan ki�iler kimlerdir?
--(Ki�i ad� ve film ad� �eklinde getirin)
   
SELECT * FROM MoviePerson
SELECT * FROM Duty

SELECT DISTINCT PersonId,p.FirstName+' '+p.LastName  From Person p
JOIN MoviePerson mp on mp.PersonId=p.Id
JOIN Duty d on d.Id=mp.DutyId
WHERE d.Id NOT IN(3,4) AND mp.PersonId IN 
(Select DISTINCT PersonId FROM (Select DISTINCT PersonId,DutyId FROM MoviePerson) mp

Group By PersonId HAVING Count(PersonId)=1 or COunt(PersonId)=2)
Order by PersonId


/*10.T�rlere g�re film say�s� da��l�m� nas�l?
	1. Romance | 12
	2. Horror | 4
	gibi*/

SELECT g.Name,Count(m.Id) FROM Movie m
JOIN Movie_Genre mg on m.Id=mg.MovieId
JOIN Genre g on g.Id=mg.GenreId
Group by g.Name

--11.En �ok ba�rol oynayan Akt�r kimdir? 
Select * From Duty

SELECT TOP 1  p.FirstName+' '+p.LastName,COUNT(*) EnCok FROM MoviePerson mp 
JOIN movie m  on m.Id=mp.MovieId
JOIN Person p on p.Id=mp.PersonId
WHERE mp.DutyId=3
GROUP BY p.FirstName+' '+p.LastName
ORDER BY EnCok DESC

--12.Kemal Sunal rol�nde oynayan akt�r ve oynad��� film hangisidir?
SELECT p.FirstName+' '+p.LastName AKT�R,m.Name FROM MoviePerson mp
JOIN Person p ON p.Id=mp.MovieId
JOIN Movie m ON m.Id=mp.MovieId
WHERE PerformedAs='Kemal Sunal'





--13.Hi�bir filmde g�rev almam�� ki�iler kimlerdir?
SELECT * FROM Person p
WHERE p.Id NOT IN (SELECT MoviePerson.PersonId FROM MoviePerson WHERE MoviePerson.PersonId=p.Id)

--14.�u ana kadar sadece y�netmenlik yapm�� ki�iler kimlerdir?
SELECT DISTINCT PersonId,p.FirstName+' '+p.LastName  From Person p
JOIN MoviePerson mp on mp.PersonId=p.Id
JOIN Duty d on d.Id=mp.DutyId
WHERE d.Id=1 AND mp.PersonId IN 
(Select DISTINCT PersonId FROM (Select DISTINCT PersonId,DutyId FROM MoviePerson) mp
Group By PersonId HAVING Count(PersonId)=1)
Order by PersonId


--15.Do�u�tan y�ld�z olan ki�iler kimlerdir? (Yaln�zca ba�rol oynam�� olanlar)
SELECT DISTINCT PersonId,p.FirstName+' '+p.LastName  From Person p
JOIN MoviePerson mp on mp.PersonId=p.Id
JOIN Duty d on d.Id=mp.DutyId
WHERE d.Id=3 AND mp.PersonId IN 
(Select DISTINCT PersonId FROM (Select DISTINCT PersonId,DutyId FROM MoviePerson) mp

Group By PersonId HAVING Count(PersonId)=1)
Order by PersonId



--16.Ne i� olsa yapar�m abi diyenler kimler? (Her g�revde bulunmu� ki�iler)
SELECT DISTINCT PersonId,p.FirstName+' '+p.LastName  From Person p
JOIN MoviePerson mp on mp.PersonId=p.Id
JOIN Duty d on d.Id=mp.DutyId
WHERE  mp.PersonId IN 
(Select DISTINCT PersonId FROM (Select DISTINCT PersonId,DutyId FROM MoviePerson) mp

Group By PersonId HAVING Count(PersonId)=4)
Order by PersonId

