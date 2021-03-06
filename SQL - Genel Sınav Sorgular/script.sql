USE [master]
GO
/****** Object:  Database [ClassicMoviesTheaters]    Script Date: 8.8.2016 21:25:13 ******/
CREATE DATABASE [ClassicMoviesTheaters]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ClassicMoviesTheaters', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\ClassicMoviesTheaters.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'ClassicMoviesTheaters_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\ClassicMoviesTheaters_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [ClassicMoviesTheaters] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ClassicMoviesTheaters].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ClassicMoviesTheaters] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ClassicMoviesTheaters] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ClassicMoviesTheaters] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ClassicMoviesTheaters] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ClassicMoviesTheaters] SET ARITHABORT OFF 
GO
ALTER DATABASE [ClassicMoviesTheaters] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ClassicMoviesTheaters] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ClassicMoviesTheaters] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ClassicMoviesTheaters] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ClassicMoviesTheaters] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ClassicMoviesTheaters] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ClassicMoviesTheaters] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ClassicMoviesTheaters] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ClassicMoviesTheaters] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ClassicMoviesTheaters] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ClassicMoviesTheaters] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ClassicMoviesTheaters] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ClassicMoviesTheaters] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ClassicMoviesTheaters] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ClassicMoviesTheaters] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ClassicMoviesTheaters] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ClassicMoviesTheaters] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ClassicMoviesTheaters] SET RECOVERY FULL 
GO
ALTER DATABASE [ClassicMoviesTheaters] SET  MULTI_USER 
GO
ALTER DATABASE [ClassicMoviesTheaters] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ClassicMoviesTheaters] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ClassicMoviesTheaters] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ClassicMoviesTheaters] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [ClassicMoviesTheaters] SET DELAYED_DURABILITY = DISABLED 
GO
USE [ClassicMoviesTheaters]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 8.8.2016 21:25:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Categories](
	[CategoryID] [smallint] IDENTITY(1,1) NOT NULL,
	[CategoryName] [varchar](30) NOT NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Movie_Category]    Script Date: 8.8.2016 21:25:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Movie_Category](
	[MovieID] [int] NOT NULL,
	[CategoryID] [smallint] NOT NULL,
 CONSTRAINT [PK_Movie_Category] PRIMARY KEY CLUSTERED 
(
	[MovieID] ASC,
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MovieHomePage]    Script Date: 8.8.2016 21:25:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MovieHomePage](
	[MovieID] [int] NOT NULL,
	[WeekID] [int] NOT NULL,
	[SessionID] [smallint] NOT NULL,
	[SaloonID] [smallint] NOT NULL,
 CONSTRAINT [PK_MovieHomePage] PRIMARY KEY CLUSTERED 
(
	[MovieID] ASC,
	[WeekID] ASC,
	[SessionID] ASC,
	[SaloonID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Movies]    Script Date: 8.8.2016 21:25:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Movies](
	[MovieID] [int] IDENTITY(1,1) NOT NULL,
	[MovieName] [varchar](70) NOT NULL,
	[Description] [varchar](max) NOT NULL,
	[Duration] [int] NOT NULL,
 CONSTRAINT [PK_Movies] PRIMARY KEY CLUSTERED 
(
	[MovieID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Saloons]    Script Date: 8.8.2016 21:25:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Saloons](
	[SaloonID] [smallint] IDENTITY(1,1) NOT NULL,
	[SaloonName] [char](1) NOT NULL,
	[Capacity] [int] NOT NULL,
 CONSTRAINT [PK_Saloons] PRIMARY KEY CLUSTERED 
(
	[SaloonID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Sessions]    Script Date: 8.8.2016 21:25:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sessions](
	[SessionId] [smallint] IDENTITY(1,1) NOT NULL,
	[Session] [time](7) NOT NULL,
 CONSTRAINT [PK_Sessions] PRIMARY KEY CLUSTERED 
(
	[SessionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Weeks]    Script Date: 8.8.2016 21:25:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Weeks](
	[WeekID] [int] IDENTITY(1,1) NOT NULL,
	[Week] [nchar](10) NOT NULL,
	[WeekFirstDay] [date] NOT NULL,
	[WeekLastDay] [date] NOT NULL,
 CONSTRAINT [PK_Weeks] PRIMARY KEY CLUSTERED 
(
	[WeekID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[vw_GelecekHafta]    Script Date: 8.8.2016 21:25:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_GelecekHafta]
AS
Select m.MovieName,s.SaloonName,se.[Session],mh.WeekID From Movies m
JOIN MovieHomePage mh on mh.MovieID=m.MovieID
JOIN Saloons s on s.SaloonID=mh.SaloonID
JOIN [Sessions] se on se.SessionId=mh.SessionID
JOIN Weeks w on w.WeekID=mh.WeekID
WHERE (GETDATE()+7) Between w.WeekFirstDay and w.WeekLastDay
GO
/****** Object:  View [dbo].[vw_HaftalikFilm]    Script Date: 8.8.2016 21:25:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_HaftalikFilm]

AS
Select m.MovieName,s.SaloonName,se.[Session],mh.WeekID From Movies m
JOIN MovieHomePage mh on mh.MovieID=m.MovieID
JOIN Saloons s on s.SaloonID=mh.SaloonID
JOIN [Sessions] se on se.SessionId=mh.SessionID
JOIN Weeks w on w.WeekID=mh.WeekID
WHERE  GETDATE() Between w.WeekFirstDay and w.WeekLastDay
GO
SET IDENTITY_INSERT [dbo].[Categories] ON 

INSERT [dbo].[Categories] ([CategoryID], [CategoryName]) VALUES (1, N'Crime
')
INSERT [dbo].[Categories] ([CategoryID], [CategoryName]) VALUES (2, N'Drama
')
INSERT [dbo].[Categories] ([CategoryID], [CategoryName]) VALUES (3, N'Adventure
')
INSERT [dbo].[Categories] ([CategoryID], [CategoryName]) VALUES (4, N'Comedy
')
INSERT [dbo].[Categories] ([CategoryID], [CategoryName]) VALUES (5, N' Sci-Fi
')
INSERT [dbo].[Categories] ([CategoryID], [CategoryName]) VALUES (6, N'Animation
')
INSERT [dbo].[Categories] ([CategoryID], [CategoryName]) VALUES (7, N'Fantasy
')
SET IDENTITY_INSERT [dbo].[Categories] OFF
INSERT [dbo].[Movie_Category] ([MovieID], [CategoryID]) VALUES (1, 1)
INSERT [dbo].[Movie_Category] ([MovieID], [CategoryID]) VALUES (1, 2)
INSERT [dbo].[Movie_Category] ([MovieID], [CategoryID]) VALUES (2, 3)
INSERT [dbo].[Movie_Category] ([MovieID], [CategoryID]) VALUES (2, 4)
INSERT [dbo].[Movie_Category] ([MovieID], [CategoryID]) VALUES (2, 5)
INSERT [dbo].[Movie_Category] ([MovieID], [CategoryID]) VALUES (3, 2)
INSERT [dbo].[Movie_Category] ([MovieID], [CategoryID]) VALUES (3, 4)
INSERT [dbo].[Movie_Category] ([MovieID], [CategoryID]) VALUES (4, 2)
INSERT [dbo].[Movie_Category] ([MovieID], [CategoryID]) VALUES (5, 2)
INSERT [dbo].[Movie_Category] ([MovieID], [CategoryID]) VALUES (5, 3)
INSERT [dbo].[Movie_Category] ([MovieID], [CategoryID]) VALUES (5, 6)
INSERT [dbo].[Movie_Category] ([MovieID], [CategoryID]) VALUES (6, 3)
INSERT [dbo].[Movie_Category] ([MovieID], [CategoryID]) VALUES (6, 4)
INSERT [dbo].[Movie_Category] ([MovieID], [CategoryID]) VALUES (6, 5)
INSERT [dbo].[Movie_Category] ([MovieID], [CategoryID]) VALUES (7, 2)
INSERT [dbo].[Movie_Category] ([MovieID], [CategoryID]) VALUES (7, 4)
INSERT [dbo].[Movie_Category] ([MovieID], [CategoryID]) VALUES (7, 5)
INSERT [dbo].[Movie_Category] ([MovieID], [CategoryID]) VALUES (8, 3)
INSERT [dbo].[Movie_Category] ([MovieID], [CategoryID]) VALUES (8, 4)
INSERT [dbo].[Movie_Category] ([MovieID], [CategoryID]) VALUES (8, 6)
INSERT [dbo].[Movie_Category] ([MovieID], [CategoryID]) VALUES (9, 1)
INSERT [dbo].[Movie_Category] ([MovieID], [CategoryID]) VALUES (9, 2)
INSERT [dbo].[Movie_Category] ([MovieID], [CategoryID]) VALUES (9, 7)
INSERT [dbo].[Movie_Category] ([MovieID], [CategoryID]) VALUES (10, 3)
INSERT [dbo].[Movie_Category] ([MovieID], [CategoryID]) VALUES (10, 4)
INSERT [dbo].[Movie_Category] ([MovieID], [CategoryID]) VALUES (10, 5)
INSERT [dbo].[MovieHomePage] ([MovieID], [WeekID], [SessionID], [SaloonID]) VALUES (1, 1, 1, 1)
INSERT [dbo].[MovieHomePage] ([MovieID], [WeekID], [SessionID], [SaloonID]) VALUES (1, 1, 4, 1)
INSERT [dbo].[MovieHomePage] ([MovieID], [WeekID], [SessionID], [SaloonID]) VALUES (1, 1, 6, 1)
INSERT [dbo].[MovieHomePage] ([MovieID], [WeekID], [SessionID], [SaloonID]) VALUES (1, 1, 7, 2)
INSERT [dbo].[MovieHomePage] ([MovieID], [WeekID], [SessionID], [SaloonID]) VALUES (1, 1, 8, 1)
INSERT [dbo].[MovieHomePage] ([MovieID], [WeekID], [SessionID], [SaloonID]) VALUES (1, 1, 9, 2)
INSERT [dbo].[MovieHomePage] ([MovieID], [WeekID], [SessionID], [SaloonID]) VALUES (1, 2, 1, 1)
INSERT [dbo].[MovieHomePage] ([MovieID], [WeekID], [SessionID], [SaloonID]) VALUES (1, 2, 4, 1)
INSERT [dbo].[MovieHomePage] ([MovieID], [WeekID], [SessionID], [SaloonID]) VALUES (1, 2, 6, 1)
INSERT [dbo].[MovieHomePage] ([MovieID], [WeekID], [SessionID], [SaloonID]) VALUES (1, 2, 8, 1)
INSERT [dbo].[MovieHomePage] ([MovieID], [WeekID], [SessionID], [SaloonID]) VALUES (2, 1, 1, 2)
INSERT [dbo].[MovieHomePage] ([MovieID], [WeekID], [SessionID], [SaloonID]) VALUES (2, 1, 3, 2)
INSERT [dbo].[MovieHomePage] ([MovieID], [WeekID], [SessionID], [SaloonID]) VALUES (2, 1, 5, 2)
INSERT [dbo].[MovieHomePage] ([MovieID], [WeekID], [SessionID], [SaloonID]) VALUES (3, 1, 1, 3)
INSERT [dbo].[MovieHomePage] ([MovieID], [WeekID], [SessionID], [SaloonID]) VALUES (3, 1, 4, 3)
INSERT [dbo].[MovieHomePage] ([MovieID], [WeekID], [SessionID], [SaloonID]) VALUES (3, 1, 6, 3)
INSERT [dbo].[MovieHomePage] ([MovieID], [WeekID], [SessionID], [SaloonID]) VALUES (3, 1, 8, 3)
INSERT [dbo].[MovieHomePage] ([MovieID], [WeekID], [SessionID], [SaloonID]) VALUES (4, 1, 7, 4)
INSERT [dbo].[MovieHomePage] ([MovieID], [WeekID], [SessionID], [SaloonID]) VALUES (4, 1, 9, 4)
INSERT [dbo].[MovieHomePage] ([MovieID], [WeekID], [SessionID], [SaloonID]) VALUES (4, 2, 7, 4)
INSERT [dbo].[MovieHomePage] ([MovieID], [WeekID], [SessionID], [SaloonID]) VALUES (4, 2, 9, 4)
INSERT [dbo].[MovieHomePage] ([MovieID], [WeekID], [SessionID], [SaloonID]) VALUES (5, 1, 2, 4)
INSERT [dbo].[MovieHomePage] ([MovieID], [WeekID], [SessionID], [SaloonID]) VALUES (5, 1, 4, 4)
INSERT [dbo].[MovieHomePage] ([MovieID], [WeekID], [SessionID], [SaloonID]) VALUES (5, 1, 5, 4)
INSERT [dbo].[MovieHomePage] ([MovieID], [WeekID], [SessionID], [SaloonID]) VALUES (6, 2, 1, 2)
INSERT [dbo].[MovieHomePage] ([MovieID], [WeekID], [SessionID], [SaloonID]) VALUES (6, 2, 3, 2)
INSERT [dbo].[MovieHomePage] ([MovieID], [WeekID], [SessionID], [SaloonID]) VALUES (6, 2, 5, 2)
INSERT [dbo].[MovieHomePage] ([MovieID], [WeekID], [SessionID], [SaloonID]) VALUES (6, 2, 7, 2)
INSERT [dbo].[MovieHomePage] ([MovieID], [WeekID], [SessionID], [SaloonID]) VALUES (6, 2, 9, 2)
INSERT [dbo].[MovieHomePage] ([MovieID], [WeekID], [SessionID], [SaloonID]) VALUES (7, 2, 1, 3)
INSERT [dbo].[MovieHomePage] ([MovieID], [WeekID], [SessionID], [SaloonID]) VALUES (7, 2, 3, 3)
INSERT [dbo].[MovieHomePage] ([MovieID], [WeekID], [SessionID], [SaloonID]) VALUES (7, 2, 5, 3)
INSERT [dbo].[MovieHomePage] ([MovieID], [WeekID], [SessionID], [SaloonID]) VALUES (7, 2, 7, 3)
INSERT [dbo].[MovieHomePage] ([MovieID], [WeekID], [SessionID], [SaloonID]) VALUES (7, 2, 9, 3)
INSERT [dbo].[MovieHomePage] ([MovieID], [WeekID], [SessionID], [SaloonID]) VALUES (7, 3, 1, 3)
INSERT [dbo].[MovieHomePage] ([MovieID], [WeekID], [SessionID], [SaloonID]) VALUES (7, 3, 3, 3)
INSERT [dbo].[MovieHomePage] ([MovieID], [WeekID], [SessionID], [SaloonID]) VALUES (8, 2, 2, 4)
INSERT [dbo].[MovieHomePage] ([MovieID], [WeekID], [SessionID], [SaloonID]) VALUES (8, 2, 4, 4)
INSERT [dbo].[MovieHomePage] ([MovieID], [WeekID], [SessionID], [SaloonID]) VALUES (8, 2, 5, 4)
INSERT [dbo].[MovieHomePage] ([MovieID], [WeekID], [SessionID], [SaloonID]) VALUES (9, 3, 1, 1)
INSERT [dbo].[MovieHomePage] ([MovieID], [WeekID], [SessionID], [SaloonID]) VALUES (9, 3, 5, 3)
INSERT [dbo].[MovieHomePage] ([MovieID], [WeekID], [SessionID], [SaloonID]) VALUES (9, 3, 8, 3)
INSERT [dbo].[MovieHomePage] ([MovieID], [WeekID], [SessionID], [SaloonID]) VALUES (9, 3, 10, 1)
INSERT [dbo].[MovieHomePage] ([MovieID], [WeekID], [SessionID], [SaloonID]) VALUES (9, 3, 11, 1)
INSERT [dbo].[MovieHomePage] ([MovieID], [WeekID], [SessionID], [SaloonID]) VALUES (10, 3, 1, 2)
INSERT [dbo].[MovieHomePage] ([MovieID], [WeekID], [SessionID], [SaloonID]) VALUES (10, 3, 3, 2)
INSERT [dbo].[MovieHomePage] ([MovieID], [WeekID], [SessionID], [SaloonID]) VALUES (10, 3, 5, 2)
INSERT [dbo].[MovieHomePage] ([MovieID], [WeekID], [SessionID], [SaloonID]) VALUES (10, 3, 7, 2)
INSERT [dbo].[MovieHomePage] ([MovieID], [WeekID], [SessionID], [SaloonID]) VALUES (10, 3, 12, 2)
INSERT [dbo].[MovieHomePage] ([MovieID], [WeekID], [SessionID], [SaloonID]) VALUES (11, 3, 1, 4)
INSERT [dbo].[MovieHomePage] ([MovieID], [WeekID], [SessionID], [SaloonID]) VALUES (11, 3, 4, 4)
INSERT [dbo].[MovieHomePage] ([MovieID], [WeekID], [SessionID], [SaloonID]) VALUES (11, 3, 6, 4)
INSERT [dbo].[MovieHomePage] ([MovieID], [WeekID], [SessionID], [SaloonID]) VALUES (11, 3, 8, 4)
SET IDENTITY_INSERT [dbo].[Movies] ON 

INSERT [dbo].[Movies] ([MovieID], [MovieName], [Description], [Duration]) VALUES (1, N'The Shawshank Redemption
', N'Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency.
', 142)
INSERT [dbo].[Movies] ([MovieID], [MovieName], [Description], [Duration]) VALUES (2, N'Back to the Future
', N'Marty McFly, a 17-year-old high school student, is accidentally sent 30 years into the past in a time-traveling DeLorean invented by his close friend, the maverick scientist Doc Brown.
', 114)
INSERT [dbo].[Movies] ([MovieID], [MovieName], [Description], [Duration]) VALUES (3, N'Forrest Gump
', N'Forrest Gump, while not intelligent, has accidentally been present at many historic moments, but his true love, Jenny Curran, eludes him.
', 142)
INSERT [dbo].[Movies] ([MovieID], [MovieName], [Description], [Duration]) VALUES (4, N'Fight Club
', N'An insomniac office worker, looking for a way to change his life, crosses paths with a devil-may-care soap maker, forming an underground fight club that evolves into something much, much more.
', 140)
INSERT [dbo].[Movies] ([MovieID], [MovieName], [Description], [Duration]) VALUES (5, N'The Lion King
', N'Lion cub and future king Simba searches for his identity. His eagerness to please others and penchant for testing his boundaries sometimes gets him into trouble.
', 90)
INSERT [dbo].[Movies] ([MovieID], [MovieName], [Description], [Duration]) VALUES (6, N'Back to the Future 2
', N'After visiting 2015, Marty McFly must repeat his visit to 1955 to prevent disastrous changes to 1985...without interfering with his first trip.
', 110)
INSERT [dbo].[Movies] ([MovieID], [MovieName], [Description], [Duration]) VALUES (7, N'The Truman Show
', N'An insurance salesman/adjuster discovers his entire life is actually a television show.
', 105)
INSERT [dbo].[Movies] ([MovieID], [MovieName], [Description], [Duration]) VALUES (8, N'Ice Age
', N'Set during the Ice Age, a sabertooth tiger, a sloth, and a wooly mammoth find a lost human infant, and they try to return him to his tribe.
', 81)
INSERT [dbo].[Movies] ([MovieID], [MovieName], [Description], [Duration]) VALUES (9, N'The Green Mile
', N'The lives of guards on Death Row are affected by one of their charges: a black man accused of child murder and rape, yet who has a mysterious gift.
', 190)
INSERT [dbo].[Movies] ([MovieID], [MovieName], [Description], [Duration]) VALUES (10, N'Back to the Future 3
', N'Enjoying a peaceable existence in 1885, Doctor Emmet Brown is about to be killed by Buford "Mad Dog" Tannen. Marty McFly travels back in time to save his friend.
', 120)
INSERT [dbo].[Movies] ([MovieID], [MovieName], [Description], [Duration]) VALUES (11, N'The Matrix', N'A computer hacker learns from mysterious rebels about the true nature of his reality and his role in the war against its controllers.
', 140)
SET IDENTITY_INSERT [dbo].[Movies] OFF
SET IDENTITY_INSERT [dbo].[Saloons] ON 

INSERT [dbo].[Saloons] ([SaloonID], [SaloonName], [Capacity]) VALUES (1, N'A', 40)
INSERT [dbo].[Saloons] ([SaloonID], [SaloonName], [Capacity]) VALUES (2, N'B', 58)
INSERT [dbo].[Saloons] ([SaloonID], [SaloonName], [Capacity]) VALUES (3, N'C', 94)
INSERT [dbo].[Saloons] ([SaloonID], [SaloonName], [Capacity]) VALUES (4, N'D', 72)
SET IDENTITY_INSERT [dbo].[Saloons] OFF
SET IDENTITY_INSERT [dbo].[Sessions] ON 

INSERT [dbo].[Sessions] ([SessionId], [Session]) VALUES (1, CAST(N'11:00:00' AS Time))
INSERT [dbo].[Sessions] ([SessionId], [Session]) VALUES (2, CAST(N'12:00:00' AS Time))
INSERT [dbo].[Sessions] ([SessionId], [Session]) VALUES (3, CAST(N'13:30:00' AS Time))
INSERT [dbo].[Sessions] ([SessionId], [Session]) VALUES (4, CAST(N'14:00:00' AS Time))
INSERT [dbo].[Sessions] ([SessionId], [Session]) VALUES (5, CAST(N'16:00:00' AS Time))
INSERT [dbo].[Sessions] ([SessionId], [Session]) VALUES (6, CAST(N'17:00:00' AS Time))
INSERT [dbo].[Sessions] ([SessionId], [Session]) VALUES (7, CAST(N'18:30:00' AS Time))
INSERT [dbo].[Sessions] ([SessionId], [Session]) VALUES (8, CAST(N'20:00:00' AS Time))
INSERT [dbo].[Sessions] ([SessionId], [Session]) VALUES (9, CAST(N'21:30:00' AS Time))
INSERT [dbo].[Sessions] ([SessionId], [Session]) VALUES (10, CAST(N'15:00:00' AS Time))
INSERT [dbo].[Sessions] ([SessionId], [Session]) VALUES (11, CAST(N'19:00:00' AS Time))
INSERT [dbo].[Sessions] ([SessionId], [Session]) VALUES (12, CAST(N'21:00:00' AS Time))
SET IDENTITY_INSERT [dbo].[Sessions] OFF
SET IDENTITY_INSERT [dbo].[Weeks] ON 

INSERT [dbo].[Weeks] ([WeekID], [Week], [WeekFirstDay], [WeekLastDay]) VALUES (1, N'W32       ', CAST(N'2016-08-08' AS Date), CAST(N'2016-08-14' AS Date))
INSERT [dbo].[Weeks] ([WeekID], [Week], [WeekFirstDay], [WeekLastDay]) VALUES (2, N'W33       ', CAST(N'2016-08-15' AS Date), CAST(N'2016-08-21' AS Date))
INSERT [dbo].[Weeks] ([WeekID], [Week], [WeekFirstDay], [WeekLastDay]) VALUES (3, N'W34       ', CAST(N'2016-08-22' AS Date), CAST(N'2016-08-28' AS Date))
SET IDENTITY_INSERT [dbo].[Weeks] OFF
ALTER TABLE [dbo].[Movie_Category]  WITH CHECK ADD  CONSTRAINT [FK_Movie_Category_Categories] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Categories] ([CategoryID])
GO
ALTER TABLE [dbo].[Movie_Category] CHECK CONSTRAINT [FK_Movie_Category_Categories]
GO
ALTER TABLE [dbo].[Movie_Category]  WITH CHECK ADD  CONSTRAINT [FK_Movie_Category_Movies] FOREIGN KEY([MovieID])
REFERENCES [dbo].[Movies] ([MovieID])
GO
ALTER TABLE [dbo].[Movie_Category] CHECK CONSTRAINT [FK_Movie_Category_Movies]
GO
ALTER TABLE [dbo].[MovieHomePage]  WITH CHECK ADD  CONSTRAINT [FK_MovieHomePage_Movies] FOREIGN KEY([MovieID])
REFERENCES [dbo].[Movies] ([MovieID])
GO
ALTER TABLE [dbo].[MovieHomePage] CHECK CONSTRAINT [FK_MovieHomePage_Movies]
GO
ALTER TABLE [dbo].[MovieHomePage]  WITH CHECK ADD  CONSTRAINT [FK_MovieHomePage_Saloons] FOREIGN KEY([SaloonID])
REFERENCES [dbo].[Saloons] ([SaloonID])
GO
ALTER TABLE [dbo].[MovieHomePage] CHECK CONSTRAINT [FK_MovieHomePage_Saloons]
GO
ALTER TABLE [dbo].[MovieHomePage]  WITH CHECK ADD  CONSTRAINT [FK_MovieHomePage_Sessions] FOREIGN KEY([SessionID])
REFERENCES [dbo].[Sessions] ([SessionId])
GO
ALTER TABLE [dbo].[MovieHomePage] CHECK CONSTRAINT [FK_MovieHomePage_Sessions]
GO
ALTER TABLE [dbo].[MovieHomePage]  WITH CHECK ADD  CONSTRAINT [FK_MovieHomePage_Weeks] FOREIGN KEY([WeekID])
REFERENCES [dbo].[Weeks] ([WeekID])
GO
ALTER TABLE [dbo].[MovieHomePage] CHECK CONSTRAINT [FK_MovieHomePage_Weeks]
GO
/****** Object:  StoredProcedure [dbo].[sp_YeniFilm]    Script Date: 8.8.2016 21:25:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[sp_YeniFilm]
@Filmismi varchar(40),
@Aciklama varchar(max),
@Duration int,
@Kategori int
AS 
BEGIN 
INSERT INTO Movies(MovieName,[Description],Duration) VALUES (@Filmismi,@Aciklama,@Duration)
INSERT INTO Movie_Category(MovieID,CategoryID) VALUES((SELECT MovieID FROM Movies WHERE  @Filmismi=MovieName),@Kategori)
END
GO
USE [master]
GO
ALTER DATABASE [ClassicMoviesTheaters] SET  READ_WRITE 
GO
