INSERT INTO Category (CategoryName) VALUES ('Action'),('Adventure'),('Animation'),('Comedy'),('Crime'),('Drama'),('Family'),('Fantasy'),('History'),('Horror'),
('Romance'),('Scifi'),('Sport'),('War')


INSERT INTO Casts (CastFirstName,CastLastName,BirthDate,Bio)
VALUES ('Morgan','Freeman','1937-06-01','American actor, producer and narrator.'),('Bradley','Cooper','1975-01-05','American actor and producer. '),
('Will','Smith','1968-10-25','American actor, producer, rapper, and songwriter.')


INSERT INTO Director (DirectorFirstName,DirectorLastName,BirthDate)
VALUES 
('Frank','Darabont','1959-01-28'),
('Todd','Phillips','1970-12-20'),
('Louis', 'Leterrier','1973-06-17'),
('Jon ' ,'M.Chu','1979-11-02'),
('Francis', 'Lawrence','1971-03-26')

INSERT INTO Country (CountryName) VALUES
('USA'),('Austria'),('France'),('Turkey'),('Canada'),('Germany'),('Ýtaly')

INSERT INTO Producer(ProducerName,Phone) VALUES 
('Hollywood','321231'),('Ay Yapým','213213'),('Turkish Producer','3213132')


INSERT INTO Movies (MovieName,ReleaseDate,IMDB,ProducerID,MovieDirectorID,MovieTime,[Language],Budget,Gross,Summary,CountryID)
VALUES
('I Am Legend','2008-01-25',7.2,1,5,101,'English',2500,35000000,'Gg',1),
('Now You See Me','2013-05-31',7.3,1,3,115,'English',40000,5121200,'gg',1),
('Now You See Me 2','2016-06-10',6.9,1,4,129,'English',500,50000000,'gg',1),
('The Hangover','2009-07-10',7.8,3,2,100,'Turkish',450000,25000000,'Gg',4)


INSERT INTO Movie_Category (MovieID,CategoryID)
VALUES
(1,6),(1,10),(1,12),
(2,5),
(3,5),
(4,4)

INSERT INTO Roles ([Role])
VALUES
('Actor'),('Movie Star'),('Figurant'),('Understudy')


Select * From Casts
Select * From Movies

INSERT INTO Movie_Cast_Role (MovieID,CastID,RoleID,[Character])
VALUES
(1,3,2,'Robert Neville'),(2,1,4,'Thaddeus Bradley'),(3,1,4,'Thaddeus Bradley'),(4,2,2,'Phil')


INSERT INTO UsersLogin (UserName,[Password]) VALUES('tk','tktktk')

INSERT INTO UserDetails (UserID,FirstName,LastName,Email,BirthDate,CountryID)
VALUES 
(1,'Turgay','Kaya','turgaykaya10@gmail.com','1993-12-25',4)


INSERT INTO Ratings (MovieID,UserID,Rating)
VALUES
(1,1,9.9),(2,1,8.0),(3,1,7.5),(4,1,8)