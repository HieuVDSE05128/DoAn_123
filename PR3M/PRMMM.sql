Use master 
go
create database PRMMM
go
use PRMMM
go
create table [Role]
(
	RoleId int not null Identity(0,1) primary key,
	RoleName varchar(50) not null,
)
go
go
create table PRSystem
(
	PRSystemId int not null Identity(0,1) primary key,
	PRSystemName varchar(50) not null,
	PRSystemVName nvarchar(max),
	PRSystemIndependent bit not null,
) 
go
create table [User]
(
	UsernameId varchar(50) not null primary key,
	[Password] nvarchar(MAX),
	Email varchar(50) not null,
	FullName nvarchar(50) not null,
	IsActive bit not null,
	RoleId int NOT NULL,
	PRSystemId int NOT NULL,
	Constraint FK_User_Role Foreign key (RoleId) references [Role](RoleId),
	Constraint FK_User_PRSystem Foreign key (PRSystemId) references PRSystem(PRSystemId)
)
GO
/*
	1 = CREATE
	2 = UPDATE - EDIT
	3 = DELETE
	4 = RECYCLE
	5 = ..
*/
CREATE TABLE LogActionType
(
	LogActionTypeId INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	LogActionTypeName varchar(20) NOT NULL
)
GO
CREATE TABLE LogAction
(
	LogActionId INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	LogCreateBy VARCHAR(50) NOT NULL,
	LogObjectId INT NOT NULL,
	LogObjectType INT NOT NULL,
	LogActionTypeId INT NOT NULL,
	LogActionTime DATETIME NOT NULL,
	CONSTRAINT FK_LA_LAT FOREIGN KEY (LogActionTypeId) REFERENCES LogActionType(LogActionTypeId)
)
GO
create table Post
(
	PostId INT NOT NULL IDENTITY(0,1) PRIMARY KEY,
	PostTitle NVARCHAR(max) NOT NULL, 
	PostEngTitle VARCHAR(max),
	PostHashRealFolder NVARCHAR(max),
	LaunchedDate DATETIME NOT NULL,
	CreateBy VARCHAR(50) not null,
	IsDelete BIT NOT NULL,
	IsHide BIT NOT NULL,
	IsPublic BIT NOT NULL,
	IsInLogoPost BIT NOT NULL,
	Position INT NOT NULL,
	PRSystemId INT NOT NULL,
	DeleteTime DATETIME,
	CONSTRAINT FK_P_PR FOREIGN KEY (PRSystemId) REFERENCES PRSystem(PRSystemId),
	CONSTRAINT FK_P_U FOREIGN KEY (CreateBy) REFERENCES [User](UsernameId)
)
go


create table Material
(
	MaterialId INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	MaterialName NVARCHAR(100) NOT NULL,
	MaterialDisplayName NVARCHAR(100) NOT NULL,
	LaunchedDate DATETIME NOT NULL,
	CreateBy VARCHAR(50) not null,
	IsDelete BIT NOT NULL,
	IsHilde BIT NOT NULL,
	PositionInFolder INT NOT NULL,
	MaterialPathFolder VARCHAR(MAX),
	MaterialMD5Encrypt VARCHAR(MAX),
	PostId INT NOT NULL,
	MIMEType varchar(10) NOT NULL,
	DeleteTime DATETIME,
	ImageAvatar varchar(max),
	Constraint FK_M_U FOREIGN KEY (CreateBy) REFERENCES [User](UsernameId),
	CONSTRAINT FK_M_F FOREIGN KEY (PostId) REFERENCES Post(PostId)
)
go
CREATE TABLE LogoAvartarImage
(
	PostId INT NOT NULL PRIMARY KEY,
	MaterialId INT NOT NULL,
	LastChangeTime DATETIME NOT NULL,
	LastChangeBy VARCHAR(50) NOT NULL,
	CONSTRAINT FK_LG_P FOREIGN KEY (PostId) REFERENCES Post(PostId),
	CONSTRAINT FK_LG_M FOREIGN KEY (MaterialId) REFERENCES Material(MaterialId),
	CONSTRAINT FK_LG_U FOREIGN KEY (LastChangeBy) REFERENCES [User](UsernameId)
)

GO
CREATE TABLE Slider
(
	SliderId INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	SliderName varchar(50) NOT NULL,
	IsDelete BIT NOT NULL
)
go
insert into Slider (SliderName,IsDelete) values ('TestSlide1.jpg',0)
insert into Slider (SliderName,IsDelete) values ('TestSlide3.jpg',0)
insert into Slider (SliderName,IsDelete) values ('TestSlide6.jpg',0)
insert into Slider (SliderName,IsDelete) values ('TestSlide2.png',0)
insert into Slider (SliderName,IsDelete) values ('TestSlide5.jpg',0)
--insert into [Role] (RoleName) values ('Su')
--insert into [Role] (RoleName) values ('Admin')
--insert into [Role] (RoleName) values ('SysAdmin')
--insert into [Role] (RoleName) values ('Editor')
--insert into [Role] (RoleName) values ('No Services')
--insert into PRSystem (PRSystemName,PRSystemIndependent) values ('FEHO',1)
--insert into PRSystem (PRSystemName,PRSystemIndependent) values ('FPT University',1)
--insert into PRSystem (PRSystemName,PRSystemIndependent) values ('FPT APTECH',1)
--insert into PRSystem (PRSystemName,PRSystemIndependent) values ('FPT Poly',1)
----"AA0fisGSt5QDZNGWKR8TzVcnuwyeubq6RGlrCMXAcf1ND7cwa1Z3NY+wDVNIUvE50Q==", "123abc!@#"
----"AFIVnV0y07JaO+93BtyOfA/5E/+nUDeAWlzQP9iOLCeZrCWE307/caBF7AW9K5JD9Q==", "123abc!@#"
----"AA/DYVIORgl+uCV6y3yA53pE5qDSOF0iZamWxmu/v7UEwmkJNW6ZLojX2QZCFmlXwA==", "123abc!@#"
--insert into [User] (UsernameId,[Password],Email,FullName,IsActive,RoleId,PRSystemId) values ('superuser001',N'AA0fisGSt5QDZNGWKR8TzVcnuwyeubq6RGlrCMXAcf1ND7cwa1Z3NY+wDVNIUvE50Q==','supperuser001@fpt.edu.vn','Supper User',1,0,0)
--insert into [User] (UsernameId,[Password],Email,FullName,IsActive,RoleId,PRSystemId) values ('hieuvdse05128',N'AA/DYVIORgl+uCV6y3yA53pE5qDSOF0iZamWxmu/v7UEwmkJNW6ZLojX2QZCFmlXwA==','hieuvdse05128@fpt.edu.vn','K11-FUG HN Vu Duc Hieu',1,1,0)
--insert into [User] (UsernameId,[Password],Email,FullName,IsActive,RoleId,PRSystemId) values ('acctest001',N'AA/DYVIORgl+uCV6y3yA53pE5qDSOF0iZamWxmu/v7UEwmkJNW6ZLojX2QZCFmlXwA==','acctest001@fpt.edu.vn','acctest001',1,3,0)
--insert into [User] (UsernameId,[Password],Email,FullName,IsActive,RoleId,PRSystemId) values ('acctest002',N'AA/DYVIORgl+uCV6y3yA53pE5qDSOF0iZamWxmu/v7UEwmkJNW6ZLojX2QZCFmlXwA==','acctest002@fpt.edu.vn','acctest002',1,3,0)
--insert into [User] (UsernameId,[Password],Email,FullName,IsActive,RoleId,PRSystemId) values ('acctest003',N'AA/DYVIORgl+uCV6y3yA53pE5qDSOF0iZamWxmu/v7UEwmkJNW6ZLojX2QZCFmlXwA==','acctest003@fpt.edu.vn','acctest003',1,3,0)
--insert into [User] (UsernameId,[Password],Email,FullName,IsActive,RoleId,PRSystemId) values ('acctest004',N'AA/DYVIORgl+uCV6y3yA53pE5qDSOF0iZamWxmu/v7UEwmkJNW6ZLojX2QZCFmlXwA==','acctest004@fpt.edu.vn','acctest004',1,3,0)
--insert into [User] (UsernameId,[Password],Email,FullName,IsActive,RoleId,PRSystemId) values ('acctest005',N'AA/DYVIORgl+uCV6y3yA53pE5qDSOF0iZamWxmu/v7UEwmkJNW6ZLojX2QZCFmlXwA==','acctest005@fpt.edu.vn','acctest005',1,3,0)
--insert into [User] (UsernameId,[Password],Email,FullName,IsActive,RoleId,PRSystemId) values ('acctest006',N'AA/DYVIORgl+uCV6y3yA53pE5qDSOF0iZamWxmu/v7UEwmkJNW6ZLojX2QZCFmlXwA==','acctest006@fpt.edu.vn','acctest006',1,3,0)
--insert into [User] (UsernameId,[Password],Email,FullName,IsActive,RoleId,PRSystemId) values ('acctest007',N'AA/DYVIORgl+uCV6y3yA53pE5qDSOF0iZamWxmu/v7UEwmkJNW6ZLojX2QZCFmlXwA==','acctest007@fpt.edu.vn','acctest007',1,3,0)
--insert into [User] (UsernameId,[Password],Email,FullName,IsActive,RoleId,PRSystemId) values ('acctest008',N'AA/DYVIORgl+uCV6y3yA53pE5qDSOF0iZamWxmu/v7UEwmkJNW6ZLojX2QZCFmlXwA==','acctest008@fpt.edu.vn','acctest008',1,3,0)
--insert into [User] (UsernameId,[Password],Email,FullName,IsActive,RoleId,PRSystemId) values ('acctest009',N'AA/DYVIORgl+uCV6y3yA53pE5qDSOF0iZamWxmu/v7UEwmkJNW6ZLojX2QZCFmlXwA==','acctest009@fpt.edu.vn','acctest009',1,3,0)
--insert into [User] (UsernameId,[Password],Email,FullName,IsActive,RoleId,PRSystemId) values ('acctest0010',N'AA/DYVIORgl+uCV6y3yA53pE5qDSOF0iZamWxmu/v7UEwmkJNW6ZLojX2QZCFmlXwA==','acctest0010@fpt.edu.vn','acctest0010',1,3,0)
--select * from [user] u inner join PRSystem pr on u.PRSystemId = pr.PRSystemId
----insert logaction
--insert into LogAction(LogActionName) values ('CREATE')
--insert into LogAction(LogActionName) values ('UPDATE')
--insert into LogAction(LogActionName) values ('DELETE')
--insert into LogAction(LogActionName) values ('RECYCLE')
--insert into LogAction(LogActionName) values ('HIDE')

----insert post
--insert into Post (PostTitle,PostEngTitle,Position,LaunchedDate,IsPublic,IsHide,IsDelete,CreateBy,PRSystemId,IsInLogoPost) 
--values (N'HỆ THỐNG LOGO TỔ CHỨC GIÁO DỤC','FPT Education Logo',0,'4-15-2020 09:10:15',1,0,0,'superuser001',0,0)
----insert log
--insert into PostLog(PostId,UsernameId,PostActionTime,PostActionDescriptionId) values (0,'superuser001','4-15-2020 09:10:15',1)
----insert post
--insert into Post (PostTitle,PostEngTitle,Position,LaunchedDate,IsPublic,IsHide,IsDelete,CreateBy,PRSystemId,IsInLogoPost,PostHashRealFolder) 
--values (N'SỔ TAY THƯƠNG HIỆU TỔ CHỨC GIÁO DỤC FPT','',3,'4-15-2020 09:10:15',1,0,0,'superuser001',0,0,'LEBTRJULSPEISTNFNOEHWKHVPRINTAQARSSFXSECDSEKRNBDWWJDHCRAVFDABGRR')
----insert log
--insert into PostLog(PostId,UsernameId,PostActionTime,PostActionDescriptionId) values (1,'superuser001','4-15-2020 09:10:15',1)
----insert material
--insert into Material(MaterialName,MaterialDisplayName,LaunchedDate,CreateBy,IsHilde,IsDelete,PostId,PositionInFolder,MIMEType) 
--values				('Brochure-2015',N'Bản Tiếng Việt 2015','4-16-2020 21:22:50','superuser001',0,0,1,1,'pdf')
----insert post
--insert into Post (PostTitle,PostEngTitle,Position,LaunchedDate,IsPublic,IsHide,IsDelete,CreateBy,PRSystemId,IsInLogoPost,PostHashRealFolder) 
--values (N'BẢN TRÌNH CHIẾU GIỚI THIỆU TỔ CHỨC GIÁO DỤC FPT','FPT Education Presentation Presenttation Power Point',2,'4-15-2020 09:10:15',1,0,0,'superuser001',0,0,'XFFYIURAKQYFNFXJRWMUYQDHAMMAQOMKYIRVYSRQOJPAPAMOXRCGCSMHBWXUIRJV')
--insert into Material(MaterialName,MaterialDisplayName,LaunchedDate,CreateBy,IsHilde,IsDelete,PostId,PositionInFolder,MIMEType) 
--values				('Brochure2',N'Bản Tiếng Việt 2015','4-16-2020 21:22:50','superuser001',0,0,2,1,'jpg')
--insert into Material(MaterialName,MaterialDisplayName,LaunchedDate,CreateBy,IsHilde,IsDelete,PostId,PositionInFolder,MIMEType) 
--values				('Brochure5',N'English version 2015','4-16-2020 21:22:50','superuser001',0,0,2,1,'jpg')
----insert log
--insert into PostLog(PostId,UsernameId,PostActionTime,PostActionDescriptionId) values (2,'superuser001','4-15-2020 09:10:15',1)
----insert post
--insert into Post (PostTitle,PostEngTitle,Position,LaunchedDate,IsPublic,IsHide,IsDelete,CreateBy,PRSystemId,IsInLogoPost,PostHashRealFolder) 
--values (N'BROCHURE TỔ CHỨC GIÁO DỤC FPT','FPT Education Brochure',1,'4-15-2020 09:10:15',1,0,0,'superuser001',0,0,'WVLPDLINDYOYAXQPOEWFGGAAVNXGXNWRFRIORJVSOVRMUBBUQGTKBKNPVLTPMCOP')
----folder path : "4superuser0014-15-2020 09:10:15" -> "AJPq6+6yJ4h9Hi3OJPJlTXq0ROMpdLCgIMgSMwI+4LPry4FoaPnBkk1RIKbYqAnTOA=="
----folder path : "4superuser001",                     "AJYsUyPKAMwJWeT1XUQL920NR7HnmfpmEkDOYCXD+nWfFb05APJppR7awfF53jBJOA=="
----                                                    WVLPDLINDYOYAXQPOEWFGGAAVNXGXNWRFRIORJVSOVRMUBBUQGTKBKNPVLTPMCOP             
----insert log
--insert into PostLog(PostId,UsernameId,PostActionTime,PostActionDescriptionId) values (3,'superuser001','4-15-2020 09:10:15',1)
---- insert folder
--insert into Material(MaterialName,MaterialDisplayName,LaunchedDate,CreateBy,IsHilde,IsDelete,PostId,PositionInFolder,MIMEType) 
--values				('1',N'Bản Tiếng Việt 2018','4-16-2020 21:22:50','superuser001',0,0,3,1,'pdf')
--insert into Material(MaterialName,MaterialDisplayName,LaunchedDate,CreateBy,IsHilde,IsDelete,PostId,PositionInFolder,MIMEType) 
--values				('2',N'English Version 2018','4-16-2020 21:22:50','superuser001',0,0,3,2,'pdf')

----insert logo folder
----FPT Education
--insert into Post (PostTitle,PostEngTitle,Position,LaunchedDate,IsPublic,IsHide,IsDelete,CreateBy,PRSystemId,IsInLogoPost,PostHashRealFolder) 
--values			 (N'FPT Education','',1,'4-16-2020 21:22:50',1,0,0,'superuser001',1,1,'DONHMNTTNGODKYSOKRLWOGIOSEYTHHGGUDXJTNOFAHMOGOWIXYBJVEVVFXNHOALG')
--insert into Material(MaterialName,MaterialDisplayName,LaunchedDate,CreateBy,IsHilde,IsDelete,PostId,PositionInFolder,MIMEType)
--values	         ('Logo-FE','Logo-FE.ai','4-16-2020 21:22:50','superuser001',0,0,4,1,'ai')
--insert into Material(MaterialName,MaterialDisplayName,LaunchedDate,CreateBy,IsHilde,IsDelete,PostId,PositionInFolder,MIMEType)
--values	         ('Logo-FE','Logo-FE.png','4-16-2020 21:22:50','superuser001',0,0,4,1,'png')
--insert into Material(MaterialName,MaterialDisplayName,LaunchedDate,CreateBy,IsHilde,IsDelete,PostId,PositionInFolder,MIMEType)
--values	         ('Logo-FE-view','Logo-FE-view.pdf','4-16-2020 21:22:50','superuser001',0,0,4,1,'pdf')

--insert LogoAvartarImage (PostId,MaterialId) values (4,7)
--insert LogoAvartarImage (PostId,MaterialId) values (6,15)
--insert LogoAvartarImage (PostId,MaterialId) values (12,30)
----FPT University
--insert into Post (PostTitle,PostEngTitle,Position,LaunchedDate,IsPublic,IsHide,IsDelete,CreateBy,PRSystemId,IsInLogoPost,PostHashRealFolder) 
--values			 (N'FPT University','',2,'4-16-2020 21:22:50',1,0,0,'superuser001',1,1,'UTDCWYUXUWATWVKVMFGKVXLLOIVYMTOBSONEXCQTYRVVEARWTEXAGEWWIRNODULB')
--insert into Material(MaterialName,MaterialDisplayName,LaunchedDate,CreateBy,IsHilde,IsDelete,PostId,PositionInFolder,MIMEType)
--values	         ('Logo-FU','Logo-FU.ai','4-16-2020 21:22:50','superuser001',0,0,5,1,'ai')
--insert into Material(MaterialName,MaterialDisplayName,LaunchedDate,CreateBy,IsHilde,IsDelete,PostId,PositionInFolder,MIMEType)
--values	         ('Logo-FU-01','Logo-FU-01.png','4-16-2020 21:22:50','superuser001',0,0,5,2,'png')
--insert into Material(MaterialName,MaterialDisplayName,LaunchedDate,CreateBy,IsHilde,IsDelete,PostId,PositionInFolder,MIMEType)
--values	         ('Logo-FU-02','Logo-FU-02.png','4-16-2020 21:22:50','superuser001',0,0,5,3,'png')
--insert into Material(MaterialName,MaterialDisplayName,LaunchedDate,CreateBy,IsHilde,IsDelete,PostId,PositionInFolder,MIMEType)
--values	         ('Logo-FU-03','Logo-FU-03.png','4-16-2020 21:22:50','superuser001',0,0,5,4,'png')
--insert into Material(MaterialName,MaterialDisplayName,LaunchedDate,CreateBy,IsHilde,IsDelete,PostId,PositionInFolder,MIMEType)
--values	         ('Logo-FU-view','Logo-FU-view.pdf','4-16-2020 21:22:50','superuser001',0,0,5,5,'pdf')

--insert LogoAvartarImage (PostId,MaterialId) values (5,10)
----Nanoversity
--insert into Post (PostTitle,PostEngTitle,Position,LaunchedDate,IsPublic,IsHide,IsDelete,CreateBy,PRSystemId,IsInLogoPost,PostHashRealFolder) 
--values			 (N'Nanoversity','',3,'4-16-2020 21:22:50',1,0,0,'superuser001',1,1,'JSDTCBJXPHVXNAEJRXWONRUJWXLBFGUVUBDUIJIWFNLYUVOIFECIJTEQXSVEOIRI')
--insert into Material(MaterialName,MaterialDisplayName,LaunchedDate,CreateBy,IsHilde,IsDelete,PostId,PositionInFolder,MIMEType)
--values	         ('Logo-Nano','Logo-Nano.ai','4-16-2020 21:22:50','superuser001',0,0,6,1,'ai')
--insert into Material(MaterialName,MaterialDisplayName,LaunchedDate,CreateBy,IsHilde,IsDelete,PostId,PositionInFolder,MIMEType)
--values	         ('Logo-Nano','Logo-Nano.png','4-16-2020 21:22:50','superuser001',0,0,6,2,'png')
--insert into Material(MaterialName,MaterialDisplayName,LaunchedDate,CreateBy,IsHilde,IsDelete,PostId,PositionInFolder,MIMEType)
--values	         ('Logo-Nano-view','Logo-Nano-view.pdf','4-16-2020 21:22:50','superuser001',0,0,6,5,'pdf')

----Alliance
--insert into Post (PostTitle,PostEngTitle,Position,LaunchedDate,IsPublic,IsHide,IsDelete,CreateBy,PRSystemId,IsInLogoPost,PostHashRealFolder) 
--values			 (N'Alliance','',2,'4-16-2020 21:22:50',1,0,0,'superuser001',1,1,'GRQHFGIHURMIYCXIDVQMQDQCQUDWWHYFCGEHPYNJBEGJKLWCWNJTAXGDBNPKCKJM')
--insert into Material(MaterialName,MaterialDisplayName,LaunchedDate,CreateBy,IsHilde,IsDelete,PostId,PositionInFolder,MIMEType)
--values	         ('Logo-FaiTongHop','Logo-FaiTongHop.ai','4-16-2020 21:22:50','superuser001',0,0,7,1,'ai')
--insert into Material(MaterialName,MaterialDisplayName,LaunchedDate,CreateBy,IsHilde,IsDelete,PostId,PositionInFolder,MIMEType)
--values	         ('Logo-FaiTongHop','Logo-FaiTongHop.png','4-16-2020 21:22:50','superuser001',0,0,7,2,'png')
--insert into Material(MaterialName,MaterialDisplayName,LaunchedDate,CreateBy,IsHilde,IsDelete,PostId,PositionInFolder,MIMEType)
--values	         ('Logo-FaiTongHop-01','Logo-FaiTongHop-01.png','4-16-2020 21:22:50','superuser001',0,0,7,3,'png')
--insert into Material(MaterialName,MaterialDisplayName,LaunchedDate,CreateBy,IsHilde,IsDelete,PostId,PositionInFolder,MIMEType)
--values	         ('Logo-FU-03','Logo-FU-03.png','4-16-2020 21:22:50','superuser001',1,0,7,4,'png')
--insert into Material(MaterialName,MaterialDisplayName,LaunchedDate,CreateBy,IsHilde,IsDelete,PostId,PositionInFolder,MIMEType)
--values	         ('Logo-FaiTongHop-view','Logo-FaiTongHop-view.pdf','4-16-2020 21:22:50','superuser001',0,0,7,5,'pdf')

SET IDENTITY_INSERT [dbo].[PRSystem] ON 
GO
INSERT [dbo].[PRSystem] ([PRSystemId], [PRSystemName], [PRSystemVName], [PRSystemIndependent]) VALUES (0, N'FEHO', NULL, 1)
GO
INSERT [dbo].[PRSystem] ([PRSystemId], [PRSystemName], [PRSystemVName], [PRSystemIndependent]) VALUES (1, N'FPT University', NULL, 1)
GO
INSERT [dbo].[PRSystem] ([PRSystemId], [PRSystemName], [PRSystemVName], [PRSystemIndependent]) VALUES (2, N'FPT APTECH', NULL, 1)
GO
INSERT [dbo].[PRSystem] ([PRSystemId], [PRSystemName], [PRSystemVName], [PRSystemIndependent]) VALUES (3, N'FPT Poly', NULL, 1)
GO
SET IDENTITY_INSERT [dbo].[PRSystem] OFF
GO
SET IDENTITY_INSERT [dbo].[Role] ON 
GO
INSERT [dbo].[Role] ([RoleId], [RoleName]) VALUES (0, N'Su')
GO
INSERT [dbo].[Role] ([RoleId], [RoleName]) VALUES (1, N'Admin')
GO
INSERT [dbo].[Role] ([RoleId], [RoleName]) VALUES (2, N'SysAdmin')
GO
INSERT [dbo].[Role] ([RoleId], [RoleName]) VALUES (3, N'Editor')
GO
INSERT [dbo].[Role] ([RoleId], [RoleName]) VALUES (4, N'No Services')
GO
SET IDENTITY_INSERT [dbo].[Role] OFF
GO
SET IDENTITY_INSERT [dbo].LogActionType ON
GO
INSERT [dbo].LogActionType ([LogActionTypeId], LogActionTypeName) VALUES (1, N'CREATE')
GO
INSERT [dbo].LogActionType ([LogActionTypeId], LogActionTypeName) VALUES (2, N'UPDATE')
GO
INSERT [dbo].LogActionType ([LogActionTypeId], LogActionTypeName) VALUES (3, N'DELETE')
GO
INSERT [dbo].LogActionType ([LogActionTypeId], LogActionTypeName) VALUES (4, N'RECYCLE')
GO
INSERT [dbo].LogActionType ([LogActionTypeId], LogActionTypeName) VALUES (5, N'HIDE')
GO
SET IDENTITY_INSERT [dbo].LogActionType OFF
GO
INSERT [dbo].[User] ([UsernameId], [Password], [Email], [FullName], [IsActive], [RoleId], [PRSystemId]) VALUES (N'acctest001', N'AA/DYVIORgl+uCV6y3yA53pE5qDSOF0iZamWxmu/v7UEwmkJNW6ZLojX2QZCFmlXwA==', N'acctest001@fpt.edu.vn', N'acctest001', 1, 3, 0)
GO
INSERT [dbo].[User] ([UsernameId], [Password], [Email], [FullName], [IsActive], [RoleId], [PRSystemId]) VALUES (N'acctest0010', N'AA/DYVIORgl+uCV6y3yA53pE5qDSOF0iZamWxmu/v7UEwmkJNW6ZLojX2QZCFmlXwA==', N'acctest0010@fpt.edu.vn', N'acctest0010', 1, 3, 0)
GO
INSERT [dbo].[User] ([UsernameId], [Password], [Email], [FullName], [IsActive], [RoleId], [PRSystemId]) VALUES (N'acctest002', N'AA/DYVIORgl+uCV6y3yA53pE5qDSOF0iZamWxmu/v7UEwmkJNW6ZLojX2QZCFmlXwA==', N'acctest002@fpt.edu.vn', N'acctest002', 1, 3, 0)
GO
INSERT [dbo].[User] ([UsernameId], [Password], [Email], [FullName], [IsActive], [RoleId], [PRSystemId]) VALUES (N'acctest003', N'AA/DYVIORgl+uCV6y3yA53pE5qDSOF0iZamWxmu/v7UEwmkJNW6ZLojX2QZCFmlXwA==', N'acctest003@fpt.edu.vn', N'acctest003', 1, 3, 0)
GO
INSERT [dbo].[User] ([UsernameId], [Password], [Email], [FullName], [IsActive], [RoleId], [PRSystemId]) VALUES (N'acctest004', N'AA/DYVIORgl+uCV6y3yA53pE5qDSOF0iZamWxmu/v7UEwmkJNW6ZLojX2QZCFmlXwA==', N'acctest004@fpt.edu.vn', N'acctest004', 1, 3, 0)
GO
INSERT [dbo].[User] ([UsernameId], [Password], [Email], [FullName], [IsActive], [RoleId], [PRSystemId]) VALUES (N'acctest005', N'AA/DYVIORgl+uCV6y3yA53pE5qDSOF0iZamWxmu/v7UEwmkJNW6ZLojX2QZCFmlXwA==', N'acctest005@fpt.edu.vn', N'acctest005', 1, 3, 0)
GO
INSERT [dbo].[User] ([UsernameId], [Password], [Email], [FullName], [IsActive], [RoleId], [PRSystemId]) VALUES (N'acctest006', N'AA/DYVIORgl+uCV6y3yA53pE5qDSOF0iZamWxmu/v7UEwmkJNW6ZLojX2QZCFmlXwA==', N'acctest006@fpt.edu.vn', N'acctest006', 1, 3, 0)
GO
INSERT [dbo].[User] ([UsernameId], [Password], [Email], [FullName], [IsActive], [RoleId], [PRSystemId]) VALUES (N'acctest007', N'AA/DYVIORgl+uCV6y3yA53pE5qDSOF0iZamWxmu/v7UEwmkJNW6ZLojX2QZCFmlXwA==', N'acctest007@fpt.edu.vn', N'acctest007', 1, 3, 0)
GO
INSERT [dbo].[User] ([UsernameId], [Password], [Email], [FullName], [IsActive], [RoleId], [PRSystemId]) VALUES (N'acctest008', N'AA/DYVIORgl+uCV6y3yA53pE5qDSOF0iZamWxmu/v7UEwmkJNW6ZLojX2QZCFmlXwA==', N'acctest008@fpt.edu.vn', N'acctest008', 1, 3, 0)
GO
INSERT [dbo].[User] ([UsernameId], [Password], [Email], [FullName], [IsActive], [RoleId], [PRSystemId]) VALUES (N'acctest009', N'AA/DYVIORgl+uCV6y3yA53pE5qDSOF0iZamWxmu/v7UEwmkJNW6ZLojX2QZCFmlXwA==', N'acctest009@fpt.edu.vn', N'acctest009', 1, 3, 0)
GO
INSERT [dbo].[User] ([UsernameId], [Password], [Email], [FullName], [IsActive], [RoleId], [PRSystemId]) VALUES (N'hieuvdse05128', N'AA/DYVIORgl+uCV6y3yA53pE5qDSOF0iZamWxmu/v7UEwmkJNW6ZLojX2QZCFmlXwA==', N'hieuvdse05128@fpt.edu.vn', N'K11-FUG HN Vu Duc Hieu', 1, 1, 0)
GO
INSERT [dbo].[User] ([UsernameId], [Password], [Email], [FullName], [IsActive], [RoleId], [PRSystemId]) VALUES (N'superuser001', N'AA0fisGSt5QDZNGWKR8TzVcnuwyeubq6RGlrCMXAcf1ND7cwa1Z3NY+wDVNIUvE50Q==', N'supperuser001@fpt.edu.vn', N'Supper User', 1, 0, 0)
GO

GO
SET IDENTITY_INSERT [dbo].[Post] ON 
GO
INSERT [dbo].[Post] ([PostId], [PostTitle], [PostEngTitle], [PostHashRealFolder], [LaunchedDate], [CreateBy], [IsDelete], [IsHide], [IsPublic], [IsInLogoPost], [Position], [PRSystemId]) VALUES (0, N'HỆ THỐNG LOGO TỔ CHỨC GIÁO DỤC', N'FPT Education Logo', NULL, CAST(0x0000AB9E00972174 AS DateTime), N'superuser001', 0, 0, 1, 0, 0, 0)
GO
INSERT [dbo].[Post] ([PostId], [PostTitle], [PostEngTitle], [PostHashRealFolder], [LaunchedDate], [CreateBy], [IsDelete], [IsHide], [IsPublic], [IsInLogoPost], [Position], [PRSystemId]) VALUES (1, N'SỔ TAY THƯƠNG HIỆU TỔ CHỨC GIÁO DỤC FPT', NULL, N'LEBTRJULSPEISTNFNOEHWKHVPRINTAQARSSFXSECDSEKRNBDWWJDHCRAVFDABGRR', CAST(0x0000AB9E00972174 AS DateTime), N'superuser001', 0, 0, 1, 0, 4, 0)
GO
INSERT [dbo].[Post] ([PostId], [PostTitle], [PostEngTitle], [PostHashRealFolder], [LaunchedDate], [CreateBy], [IsDelete], [IsHide], [IsPublic], [IsInLogoPost], [Position], [PRSystemId]) VALUES (2, N'BẢN TRÌNH CHIẾU GIỚI THIỆU TỔ CHỨC GIÁO DỤC FPT', N'FPT Education Presentation Presenttation Power Point', N'XFFYIURAKQYFNFXJRWMUYQDHAMMAQOMKYIRVYSRQOJPAPAMOXRCGCSMHBWXUIRJV', CAST(0x0000AB9E00972174 AS DateTime), N'superuser001', 0, 0, 1, 0, 2, 0)
GO
INSERT [dbo].[Post] ([PostId], [PostTitle], [PostEngTitle], [PostHashRealFolder], [LaunchedDate], [CreateBy], [IsDelete], [IsHide], [IsPublic], [IsInLogoPost], [Position], [PRSystemId]) VALUES (3, N'BROCHURE TỔ CHỨC GIÁO DỤC FPT', N'FPT Education Brochure', N'WVLPDLINDYOYAXQPOEWFGGAAVNXGXNWRFRIORJVSOVRMUBBUQGTKBKNPVLTPMCOP', CAST(0x0000AB9E00972174 AS DateTime), N'superuser001', 0, 0, 1, 0, 1, 0)
GO
INSERT [dbo].[Post] ([PostId], [PostTitle], [PostEngTitle], [PostHashRealFolder], [LaunchedDate], [CreateBy], [IsDelete], [IsHide], [IsPublic], [IsInLogoPost], [Position], [PRSystemId]) VALUES (4, N'FPT Education', N'', N'DONHMNTTNGODKYSOKRLWOGIOSEYTHHGGUDXJTNOFAHMOGOWIXYBJVEVVFXNHOALG', CAST(0x0000AB9F01605738 AS DateTime), N'superuser001', 0, 0, 1, 1, 1, 1)
GO
INSERT [dbo].[Post] ([PostId], [PostTitle], [PostEngTitle], [PostHashRealFolder], [LaunchedDate], [CreateBy], [IsDelete], [IsHide], [IsPublic], [IsInLogoPost], [Position], [PRSystemId]) VALUES (5, N'FPT University', N'', N'UTDCWYUXUWATWVKVMFGKVXLLOIVYMTOBSONEXCQTYRVVEARWTEXAGEWWIRNODULB', CAST(0x0000AB9F01605738 AS DateTime), N'superuser001', 0, 0, 1, 1, 2, 1)
GO
INSERT [dbo].[Post] ([PostId], [PostTitle], [PostEngTitle], [PostHashRealFolder], [LaunchedDate], [CreateBy], [IsDelete], [IsHide], [IsPublic], [IsInLogoPost], [Position], [PRSystemId]) VALUES (6, N'Nanoversity', N'', N'JSDTCBJXPHVXNAEJRXWONRUJWXLBFGUVUBDUIJIWFNLYUVOIFECIJTEQXSVEOIRI', CAST(0x0000AB9F01605738 AS DateTime), N'superuser001', 0, 0, 1, 1, 3, 1)
GO
INSERT [dbo].[Post] ([PostId], [PostTitle], [PostEngTitle], [PostHashRealFolder], [LaunchedDate], [CreateBy], [IsDelete], [IsHide], [IsPublic], [IsInLogoPost], [Position], [PRSystemId]) VALUES (7, N'Alliance', N'', N'GRQHFGIHURMIYCXIDVQMQDQCQUDWWHYFCGEHPYNJBEGJKLWCWNJTAXGDBNPKCKJM', CAST(0x0000AB9F01605738 AS DateTime), N'superuser001', 0, 0, 1, 1, 2, 1)
GO
INSERT [dbo].[Post] ([PostId], [PostTitle], [PostEngTitle], [PostHashRealFolder], [LaunchedDate], [CreateBy], [IsDelete], [IsHide], [IsPublic], [IsInLogoPost], [Position], [PRSystemId]) VALUES (8, N'Ảnh về đại học FPT', N'Image about FPTU', N'VOQAMSBHOUETMODIUVCLYWQSQYRHGJQJTOOVHUNAPWSJLDKADAXUDPFYXXINATBE', CAST(0x0000ABA2015CB9DD AS DateTime), N'superuser001', 0, 0, 1, 0, 3, 0)
GO
INSERT [dbo].[Post] ([PostId], [PostTitle], [PostEngTitle], [PostHashRealFolder], [LaunchedDate], [CreateBy], [IsDelete], [IsHide], [IsPublic], [IsInLogoPost], [Position], [PRSystemId]) VALUES (9, N'AA', N'AA', N'TSYFLMSTHXKYAEWNAQAUGQRKVDMPCKAYVQHBTCUXXUGLIYVVNYIENEFCBNJIACQV', CAST(0x0000ABA301810DCF AS DateTime), N'superuser001', 0, 0, 1, 0, 5, 0)
GO
INSERT [dbo].[Post] ([PostId], [PostTitle], [PostEngTitle], [PostHashRealFolder], [LaunchedDate], [CreateBy], [IsDelete], [IsHide], [IsPublic], [IsInLogoPost], [Position], [PRSystemId]) VALUES (10, N'Ảnh về hệ thống giáo dục FPT', N'Image about FPT Education', N'PUVXJQPUNEBLATYTWIKWUQWOFROPKSRCVGHDWGXOKWGMMAPYWGHLALCYWGRRCYJT', CAST(0x0000ABA400EF969D AS DateTime), N'superuser001', 0, 0, 1, 0, 6, 0)
GO
INSERT [dbo].[Post] ([PostId], [PostTitle], [PostEngTitle], [PostHashRealFolder], [LaunchedDate], [CreateBy], [IsDelete], [IsHide], [IsPublic], [IsInLogoPost], [Position], [PRSystemId]) VALUES (11, N'Ảnh do sinh viên chụp', N'Image from student', N'JMKUQEKEVPQCAPITEIOTBTAVDHXCLNVORMMFUFFDPAOKDVOFMJCQXUVOMORIGHRH', CAST(0x0000ABA40101A1DA AS DateTime), N'superuser001', 0, 0, 1, 0, 7, 0)
GO
INSERT [dbo].[Post] ([PostId], [PostTitle], [PostEngTitle], [PostHashRealFolder], [LaunchedDate], [CreateBy], [IsDelete], [IsHide], [IsPublic], [IsInLogoPost], [Position], [PRSystemId]) VALUES (12, N'Jetking', N'', N'TANBLKKTHSBRAEMPWPEYUIUDBOXHAERWXCXPVGXVJWXXBELDDKWPJFVLFJAVLDTD', CAST(0x0000ABA4015C6BA3 AS DateTime), N'superuser001', 0, 0, 1, 1, 4, 0)
GO
INSERT [dbo].[Post] ([PostId], [PostTitle], [PostEngTitle], [PostHashRealFolder], [LaunchedDate], [CreateBy], [IsDelete], [IsHide], [IsPublic], [IsInLogoPost], [Position], [PRSystemId]) VALUES (13, N'Ảnh do hiếu đẹp trai chụp', N'Bisu ngok ngeck', N'WWYUBSRQOGAVTVPVVABSNTGCOVLFSHFMBPEFJQQNVPAHKAWPECFBVTCCPWFEHMXG', CAST(0x0000ABA4015E701F AS DateTime), N'superuser001', 0, 0, 1, 0, 8, 0)
GO
INSERT [dbo].[Post] ([PostId], [PostTitle], [PostEngTitle], [PostHashRealFolder], [LaunchedDate], [CreateBy], [IsDelete], [IsHide], [IsPublic], [IsInLogoPost], [Position], [PRSystemId]) VALUES (14, N'Bài viết 1', N'Post 1', N'HAFCTHGYFAUDSMNDFUEEMCAXQPRKIEAYIPQFQSXFVYJYHFCGYSUJETDEYHKEOVPA', CAST(0x0000ABA5010F7DB2 AS DateTime), N'superuser001', 0, 0, 1, 0, 9, 0)
GO
SET IDENTITY_INSERT [dbo].[Post] OFF
GO
SET IDENTITY_INSERT [dbo].[Material] ON 
GO
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [PositionInFolder], [MaterialPathFolder], [MaterialMD5Encrypt], [PostId], [MIMEType]) VALUES (1, N'Brochure-2015', N'Bản Tiếng Việt 2015', CAST(0x0000AB9F01605738 AS DateTime), N'superuser001', 0, 0, 1, NULL, NULL, 1, N'pdf')
GO
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [PositionInFolder], [MaterialPathFolder], [MaterialMD5Encrypt], [PostId], [MIMEType]) VALUES (2, N'Brochure2', N'Bản Tiếng Việt 2015', CAST(0x0000AB9F01605738 AS DateTime), N'superuser001', 0, 0, 1, NULL, NULL, 2, N'jpg')
GO
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [PositionInFolder], [MaterialPathFolder], [MaterialMD5Encrypt], [PostId], [MIMEType]) VALUES (3, N'Brochure5', N'English version 2015', CAST(0x0000AB9F01605738 AS DateTime), N'superuser001', 0, 0, 1, NULL, NULL, 2, N'jpg')
GO
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [PositionInFolder], [MaterialPathFolder], [MaterialMD5Encrypt], [PostId], [MIMEType]) VALUES (4, N'1', N'Bản Tiếng Việt 2018', CAST(0x0000AB9F01605738 AS DateTime), N'superuser001', 0, 0, 1, NULL, NULL, 3, N'pdf')
GO
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [PositionInFolder], [MaterialPathFolder], [MaterialMD5Encrypt], [PostId], [MIMEType]) VALUES (5, N'2', N'English Version 2018', CAST(0x0000AB9F01605738 AS DateTime), N'superuser001', 0, 0, 2, NULL, NULL, 3, N'pdf')
GO
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [PositionInFolder], [MaterialPathFolder], [MaterialMD5Encrypt], [PostId], [MIMEType]) VALUES (6, N'Logo-FE', N'Logo-FE.ai', CAST(0x0000AB9F01605738 AS DateTime), N'superuser001', 0, 0, 1, NULL, NULL, 4, N'ai')
GO
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [PositionInFolder], [MaterialPathFolder], [MaterialMD5Encrypt], [PostId], [MIMEType]) VALUES (7, N'Logo-FE', N'Logo-FE.png', CAST(0x0000AB9F01605738 AS DateTime), N'superuser001', 0, 0, 1, NULL, NULL, 4, N'png')
GO
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [PositionInFolder], [MaterialPathFolder], [MaterialMD5Encrypt], [PostId], [MIMEType]) VALUES (8, N'Logo-FE-view', N'Logo-FE-view.pdf', CAST(0x0000AB9F01605738 AS DateTime), N'superuser001', 0, 0, 1, NULL, NULL, 4, N'pdf')
GO
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [PositionInFolder], [MaterialPathFolder], [MaterialMD5Encrypt], [PostId], [MIMEType]) VALUES (9, N'Logo-FU', N'Logo-FU.ai', CAST(0x0000AB9F01605738 AS DateTime), N'superuser001', 0, 0, 1, NULL, NULL, 5, N'ai')
GO
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [PositionInFolder], [MaterialPathFolder], [MaterialMD5Encrypt], [PostId], [MIMEType]) VALUES (10, N'Logo-FU-01', N'Logo-FU-01.png', CAST(0x0000AB9F01605738 AS DateTime), N'superuser001', 0, 0, 2, NULL, NULL, 5, N'png')
GO
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [PositionInFolder], [MaterialPathFolder], [MaterialMD5Encrypt], [PostId], [MIMEType]) VALUES (11, N'Logo-FU-02', N'Logo-FU-02.png', CAST(0x0000AB9F01605738 AS DateTime), N'superuser001', 0, 0, 3, NULL, NULL, 5, N'png')
GO
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [PositionInFolder], [MaterialPathFolder], [MaterialMD5Encrypt], [PostId], [MIMEType]) VALUES (12, N'Logo-FU-03', N'Logo-FU-03.png', CAST(0x0000AB9F01605738 AS DateTime), N'superuser001', 0, 0, 4, NULL, NULL, 5, N'png')
GO
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [PositionInFolder], [MaterialPathFolder], [MaterialMD5Encrypt], [PostId], [MIMEType]) VALUES (13, N'Logo-FU-view', N'Logo-FU-view.pdf', CAST(0x0000AB9F01605738 AS DateTime), N'superuser001', 0, 0, 5, NULL, NULL, 5, N'pdf')
GO
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [PositionInFolder], [MaterialPathFolder], [MaterialMD5Encrypt], [PostId], [MIMEType]) VALUES (14, N'Logo-Nano', N'Logo-Nano.ai', CAST(0x0000AB9F01605738 AS DateTime), N'superuser001', 0, 0, 1, NULL, NULL, 6, N'ai')
GO
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [PositionInFolder], [MaterialPathFolder], [MaterialMD5Encrypt], [PostId], [MIMEType]) VALUES (15, N'Logo-Nano', N'Logo-Nano.png', CAST(0x0000AB9F01605738 AS DateTime), N'superuser001', 0, 0, 2, NULL, NULL, 6, N'png')
GO
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [PositionInFolder], [MaterialPathFolder], [MaterialMD5Encrypt], [PostId], [MIMEType]) VALUES (16, N'Logo-Nano-view', N'Logo-Nano-view.pdf', CAST(0x0000AB9F01605738 AS DateTime), N'superuser001', 0, 0, 5, NULL, NULL, 6, N'pdf')
GO
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [PositionInFolder], [MaterialPathFolder], [MaterialMD5Encrypt], [PostId], [MIMEType]) VALUES (17, N'Logo-FaiTongHop', N'Logo-FaiTongHop.ai', CAST(0x0000AB9F01605738 AS DateTime), N'superuser001', 0, 0, 1, NULL, NULL, 7, N'ai')
GO
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [PositionInFolder], [MaterialPathFolder], [MaterialMD5Encrypt], [PostId], [MIMEType]) VALUES (18, N'Logo-FaiTongHop', N'Logo-FaiTongHop.png', CAST(0x0000AB9F01605738 AS DateTime), N'superuser001', 0, 0, 2, NULL, NULL, 7, N'jpg')
GO
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [PositionInFolder], [MaterialPathFolder], [MaterialMD5Encrypt], [PostId], [MIMEType]) VALUES (19, N'Logo-FaiTongHop-01', N'Logo-FaiTongHop-01.png', CAST(0x0000AB9F01605738 AS DateTime), N'superuser001', 0, 0, 3, NULL, NULL, 7, N'png')
GO
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [PositionInFolder], [MaterialPathFolder], [MaterialMD5Encrypt], [PostId], [MIMEType]) VALUES (20, N'Logo-FU-03', N'Logo-FU-03.png', CAST(0x0000AB9F01605738 AS DateTime), N'superuser001', 1, 0, 4, NULL, NULL, 7, N'png')
GO
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [PositionInFolder], [MaterialPathFolder], [MaterialMD5Encrypt], [PostId], [MIMEType]) VALUES (21, N'Logo-FaiTongHop-view', N'Logo-FaiTongHop-view.pdf', CAST(0x0000AB9F01605738 AS DateTime), N'superuser001', 0, 0, 5, NULL, NULL, 7, N'pdf')
GO
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [PositionInFolder], [MaterialPathFolder], [MaterialMD5Encrypt], [PostId], [MIMEType]) VALUES (22, N'Login', N'ASDASD', CAST(0x0000ABA201570E23 AS DateTime), N'superuser001', 0, 0, 2, NULL, NULL, 3, N'html')
GO
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [PositionInFolder], [MaterialPathFolder], [MaterialMD5Encrypt], [PostId], [MIMEType]) VALUES (23, N'brochure3', N'Hình ảnh 1', CAST(0x0000ABA2015977B4 AS DateTime), N'superuser001', 0, 0, 1, NULL, NULL, 2, N'jpg')
GO
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [PositionInFolder], [MaterialPathFolder], [MaterialMD5Encrypt], [PostId], [MIMEType]) VALUES (24, N'video2', N'Bản tiếng việt 2020', CAST(0x0000ABA2015DCC97 AS DateTime), N'superuser001', 0, 0, 2, NULL, NULL, 3, N'm4v')
GO
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [PositionInFolder], [MaterialPathFolder], [MaterialMD5Encrypt], [PostId], [MIMEType]) VALUES (25, N'Brochure6', N'Khuân viên trường học', CAST(0x0000ABA400EFA381 AS DateTime), N'superuser001', 0, 0, 1, NULL, NULL, 10, N'jpg')
GO
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [PositionInFolder], [MaterialPathFolder], [MaterialMD5Encrypt], [PostId], [MIMEType]) VALUES (26, N'Brochure10', N'Ảnh đại diện 2', CAST(0x0000ABA400EFA827 AS DateTime), N'superuser001', 0, 0, 2, NULL, NULL, 10, N'jpg')
GO
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [PositionInFolder], [MaterialPathFolder], [MaterialMD5Encrypt], [PostId], [MIMEType]) VALUES (27, N'Test8', N'Ảnh dại diện 3', CAST(0x0000ABA400EFABD8 AS DateTime), N'superuser001', 0, 0, 3, NULL, NULL, 10, N'jpg')
GO
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [PositionInFolder], [MaterialPathFolder], [MaterialMD5Encrypt], [PostId], [MIMEType]) VALUES (28, N'Brochure11', N'Tết dân gian', CAST(0x0000ABA40101A209 AS DateTime), N'superuser001', 0, 0, 1, NULL, NULL, 11, N'jpg')
GO
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [PositionInFolder], [MaterialPathFolder], [MaterialMD5Encrypt], [PostId], [MIMEType]) VALUES (29, N'Logo-Jetking', N'Logo-Jetking.ai', CAST(0x0000ABA4015C6BDF AS DateTime), N'superuser001', 0, 0, 1, NULL, NULL, 12, N'ai')
GO
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [PositionInFolder], [MaterialPathFolder], [MaterialMD5Encrypt], [PostId], [MIMEType]) VALUES (30, N'Logo-Jetking', N'Logo-Jetking.png', CAST(0x0000ABA4015C6BE8 AS DateTime), N'superuser001', 0, 0, 2, NULL, NULL, 12, N'png')
GO
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [PositionInFolder], [MaterialPathFolder], [MaterialMD5Encrypt], [PostId], [MIMEType]) VALUES (31, N'Logo-Jetking-view', N'Logo-Jetking-view.pdf', CAST(0x0000ABA4015C6BEB AS DateTime), N'superuser001', 0, 0, 3, NULL, NULL, 12, N'pdf')
GO
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [PositionInFolder], [MaterialPathFolder], [MaterialMD5Encrypt], [PostId], [MIMEType]) VALUES (32, N'Brochure2', N'Ảnh hiếu 1', CAST(0x0000ABA4015E7058 AS DateTime), N'superuser001', 0, 0, 1, NULL, NULL, 13, N'jpg')
GO
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [PositionInFolder], [MaterialPathFolder], [MaterialMD5Encrypt], [PostId], [MIMEType]) VALUES (33, N'Brochure3', N'Ảnh hiếu 1', CAST(0x0000ABA4015E7064 AS DateTime), N'superuser001', 0, 0, 2, NULL, NULL, 13, N'jpg')
GO
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [PositionInFolder], [MaterialPathFolder], [MaterialMD5Encrypt], [PostId], [MIMEType]) VALUES (34, N'Brochure4', N'Ảnh hiếu 1', CAST(0x0000ABA4015E7067 AS DateTime), N'superuser001', 0, 0, 3, NULL, NULL, 13, N'jpg')
GO
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [PositionInFolder], [MaterialPathFolder], [MaterialMD5Encrypt], [PostId], [MIMEType]) VALUES (35, N'Brochure5', N'Ảnh hiếu 1', CAST(0x0000ABA4015E706D AS DateTime), N'superuser001', 0, 0, 4, NULL, NULL, 13, N'jpg')
GO
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [PositionInFolder], [MaterialPathFolder], [MaterialMD5Encrypt], [PostId], [MIMEType]) VALUES (36, N'Brochure6', N'Ảnh hiếu 1', CAST(0x0000ABA4015E7070 AS DateTime), N'superuser001', 0, 0, 5, NULL, NULL, 13, N'jpg')
GO
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [PositionInFolder], [MaterialPathFolder], [MaterialMD5Encrypt], [PostId], [MIMEType]) VALUES (37, N'Brochure7', N'Ảnh hiếu 1', CAST(0x0000ABA4015E7076 AS DateTime), N'superuser001', 0, 0, 6, NULL, NULL, 13, N'jpg')
GO
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [PositionInFolder], [MaterialPathFolder], [MaterialMD5Encrypt], [PostId], [MIMEType]) VALUES (38, N'Brochure8', N'Ảnh hiếu 1', CAST(0x0000ABA4015E707C AS DateTime), N'superuser001', 0, 0, 7, NULL, NULL, 13, N'jpg')
GO
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [PositionInFolder], [MaterialPathFolder], [MaterialMD5Encrypt], [PostId], [MIMEType]) VALUES (39, N'Brochure9', N'Ảnh hiếu 1', CAST(0x0000ABA4015E7080 AS DateTime), N'superuser001', 0, 0, 8, NULL, NULL, 13, N'jpg')
GO
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [PositionInFolder], [MaterialPathFolder], [MaterialMD5Encrypt], [PostId], [MIMEType]) VALUES (40, N'Brochure10', N'Ảnh hiếu 1', CAST(0x0000ABA4015E7082 AS DateTime), N'superuser001', 0, 0, 9, NULL, NULL, 13, N'jpg')
GO
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [PositionInFolder], [MaterialPathFolder], [MaterialMD5Encrypt], [PostId], [MIMEType]) VALUES (41, N'Brochure11', N'Ảnh hiếu 1', CAST(0x0000ABA4015E7085 AS DateTime), N'superuser001', 0, 0, 10, NULL, NULL, 13, N'jpg')
GO
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [PositionInFolder], [MaterialPathFolder], [MaterialMD5Encrypt], [PostId], [MIMEType]) VALUES (42, N'Brochure12', N'Ảnh hiếu 1', CAST(0x0000ABA4015E7088 AS DateTime), N'superuser001', 0, 0, 11, NULL, NULL, 13, N'jpg')
GO
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [PositionInFolder], [MaterialPathFolder], [MaterialMD5Encrypt], [PostId], [MIMEType]) VALUES (43, N'Brochure13', N'Ảnh hiếu 2', CAST(0x0000ABA4015E708A AS DateTime), N'superuser001', 0, 0, 12, NULL, NULL, 13, N'png')
GO
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [PositionInFolder], [MaterialPathFolder], [MaterialMD5Encrypt], [PostId], [MIMEType]) VALUES (44, N'Brochure2', N'Thanh niên chăm học', CAST(0x0000ABA4016C14DD AS DateTime), N'superuser001', 0, 0, 2, NULL, NULL, 3, N'jpg')
GO
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [PositionInFolder], [MaterialPathFolder], [MaterialMD5Encrypt], [PostId], [MIMEType]) VALUES (45, N'Video3', N'Video3.mp4', CAST(0x0000ABA500013C41 AS DateTime), N'superuser001', 0, 0, 1, NULL, NULL, 8, N'mp4')
GO
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [PositionInFolder], [MaterialPathFolder], [MaterialMD5Encrypt], [PostId], [MIMEType]) VALUES (46, N'Test2', N'Test2.jpg', CAST(0x0000ABA5010F7DEE AS DateTime), N'superuser001', 0, 0, 1, NULL, NULL, 14, N'jpg')
GO
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [PositionInFolder], [MaterialPathFolder], [MaterialMD5Encrypt], [PostId], [MIMEType]) VALUES (47, N'Test5', N'Test5.jpg', CAST(0x0000ABA5010F7DFB AS DateTime), N'superuser001', 0, 0, 2, NULL, NULL, 14, N'jpg')
GO
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [PositionInFolder], [MaterialPathFolder], [MaterialMD5Encrypt], [PostId], [MIMEType]) VALUES (48, N'Test7', N'Test7.png', CAST(0x0000ABA5010F7DFD AS DateTime), N'superuser001', 0, 0, 3, NULL, NULL, 14, N'png')
GO
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [PositionInFolder], [MaterialPathFolder], [MaterialMD5Encrypt], [PostId], [MIMEType]) VALUES (49, N'Brochure11', N'Tết dân gian _ Test', CAST(0x0000ABA5010FFEFE AS DateTime), N'superuser001', 0, 0, 2, NULL, NULL, 3, N'jpg')
GO
SET IDENTITY_INSERT [dbo].[Material] OFF
GO


