/*17. Adýný girdiðim oyunucunun filmlerini listeleyen SP yazýnýz.
18. Bir filme oyuncu ekleyen SP yazýnýz. (Oyuncu yoksa ekleyecek)
18.1  Bir filme belirsiz sayýda oyuncu ekleyen SP yazýnýz. (Oyuncu yoksa ekleyecek)
19. Bir oyuncunun birden fazla karakteri canlandýrdýðý filmlerle ilgilenen kullanýcýlarýmý listeleyen SP yazýnýz.
20. Devam filminde daha az puan almýþ filmlerimi listeleyen SP yazýnýz.*/
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
--18. Bir filme oyuncu ekleyen SP yazýnýz. (Oyuncu yoksa ekleyecek)

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

--Bir filme belirsiz sayýda oyuncu ekleyen SP yazýnýz. (Oyuncu yoksa ekleyecek)



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


--19. Bir oyuncunun birden fazla karakteri canlandýrdýðý filmlerle ilgilenen kullanýcýlarýmý listeleyen SP yazýnýz.
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
		PRINT 'Öyle bir Kullanýcý Yok'

END
Select MovieId,PersonId From MoviePerson Group by MovieId,PersonId HAVING COUNT(PersonId)>1
EXEC sp_BirdenFazlaKarakter 25,5


--20. Devam filminde daha az puan almýþ filmlerimi listeleyen SP yazýnýz.
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

