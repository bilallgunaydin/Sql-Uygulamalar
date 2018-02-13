/*17. Ad�n� girdi�im oyunucunun filmlerini listeleyen SP yaz�n�z.
18. Bir filme oyuncu ekleyen SP yaz�n�z. (Oyuncu yoksa ekleyecek)
18.1  Bir filme belirsiz say�da oyuncu ekleyen SP yaz�n�z. (Oyuncu yoksa ekleyecek)
19. Bir oyuncunun birden fazla karakteri canland�rd��� filmlerle ilgilenen kullan�c�lar�m� listeleyen SP yaz�n�z.
20. Devam filminde daha az puan alm�� filmlerimi listeleyen SP yaz�n�z.*/
CREATE PROC sp_OyuncuFilm
@ad VARCHAR(50),
@soyad VARCHAR(50)
AS 
BEGIN 
SELECT @ad+' '+@soyad,m.Name FROM Movie m
JOIN MoviePerson mp on mp.MovieId=m.Id
JOIN Person p on p.Id=mp.PersonId
WHERE p.FirstName=@ad and p.LastName=@soyad
END
EXEC sp_OyuncuFilm 'Nasim','Chaney'

SELECT * FROM Person
--18. Bir filme oyuncu ekleyen SP yaz�n�z. (Oyuncu yoksa ekleyecek)

CREATE PROC sp_FilmeOyuncuEkleme

@FilmID int,
@OyuncuID int,
@RolID int,
@Karakter varchar(50)
AS 
BEGIN

	IF	(@OyuncuID=(SELECT PersonId FROM MoviePerson 
	WHERE PersonId=@OyuncuID AND @FilmID=MovieId GROUP BY PersonId) )
		BEGIN

		PRINT 'HATA!!! Bu filmde bu oyuncu Var.'

		END

	ELSE
		BEGIN

		INSERT INTO MoviePerson (MovieId,PersonId,DutyId,PerformedAs) 
		VALUES(@FilmID,@OyuncuID,@RolID,@Karakter)

		END
END

EXEC sp_FilmeOyuncuEkleme 1,71,1,''

--Bir filme belirsiz say�da oyuncu ekleyen SP yaz�n�z. (Oyuncu yoksa ekleyecek)



CREATE PROCEDURE sp_Belirsiz_Ekle
@OyuncuID int,
@FilmID int,
@Duty int,
@Karakter VARCHAR(50)
AS
BEGIN
		
		IF	(@OyuncuID=(SELECT PersonId FROM MoviePerson 
	WHERE PersonId=@OyuncuID AND @FilmID=MovieId GROUP BY PersonId) )

		BEGIN


		INSERT INTO MoviePerson (MovieId,PersonId,DutyId,PerformedAs)
		SELECT @FilmID,@OyuncuID,@Duty,@Karakter
		
		END


		ELSE
		BEGIN
		PRINT 'HATA!!! Bu filmde bu oyuncu Var.'
		END
END


--19. Bir oyuncunun birden fazla karakteri canland�rd��� filmlerle ilgilenen kullan�c�lar�m� listeleyen SP yaz�n�z.
CREATE PROCEDURE sp_BirdenFazlaKarakter
@OyuncuID int,
@FilmID int
AS
BEGIN
		
		IF	(@OyuncuID=(SELECT PersonId FROM MoviePerson 
	WHERE PersonId=@OyuncuID AND @FilmID=MovieId  GROUP BY PersonId HAVING Count(PerformedAs)>1) )
		BEGIN
		Select  @FilmID,UserId From Rating Where MovieId=@FilmID
		END

		ELSE
		PRINT '�yle bir Kullan�c� Yok'

END
Select MovieId,PersonId From MoviePerson Group by MovieId,PersonId HAVING COUNT(PersonId)>1
EXEC sp_BirdenFazlaKarakter 25,5


--20. Devam filminde daha az puan alm�� filmlerimi listeleyen SP yaz�n�z.
SELECT(
Select DISTINCT m.Name,AVG(Rate) From Movie m
JOIN Rating r on r.MovieId=m.Id
WHERE ContinuationOf IS NOT NULL
Group By m.Name
UNION
Select DISTINCT c.Name,AVG(Rate) From Movie m
JOIN Movie c on c.Id=m.ContinuationOf
JOIN Rating r on r.MovieId=c.Id
Group By c.Name)

FROM 

