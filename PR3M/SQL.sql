USE [master]
GO
/****** Object:  Database [PRMMM]    Script Date: 4/30/2020 11:51:47 PM ******/
CREATE DATABASE [PRMMM]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PRMMM', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\PRMMM.mdf' , SIZE = 3136KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'PRMMM_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\PRMMM_log.ldf' , SIZE = 832KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [PRMMM] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PRMMM].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PRMMM] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PRMMM] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PRMMM] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PRMMM] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PRMMM] SET ARITHABORT OFF 
GO
ALTER DATABASE [PRMMM] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [PRMMM] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [PRMMM] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PRMMM] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PRMMM] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PRMMM] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [PRMMM] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PRMMM] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PRMMM] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PRMMM] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PRMMM] SET  ENABLE_BROKER 
GO
ALTER DATABASE [PRMMM] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PRMMM] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [PRMMM] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [PRMMM] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PRMMM] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PRMMM] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [PRMMM] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [PRMMM] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [PRMMM] SET  MULTI_USER 
GO
ALTER DATABASE [PRMMM] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [PRMMM] SET DB_CHAINING OFF 
GO
ALTER DATABASE [PRMMM] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [PRMMM] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [PRMMM]
GO
/****** Object:  Table [dbo].[FileInDB]    Script Date: 4/30/2020 11:51:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FileInDB](
	[FileId] [int] IDENTITY(1,1) NOT NULL,
	[FileName] [nvarchar](max) NOT NULL,
	[MIMEType] [varchar](10) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[IsHide] [bit] NOT NULL,
	[IsDelete] [bit] NOT NULL,
	[IsPublic] [bit] NOT NULL,
	[LaunchedBy] [varchar](50) NOT NULL,
	[LaunchedDate] [datetime] NOT NULL,
	[LastEditBy] [varchar](50) NOT NULL,
	[LastEditTime] [datetime] NOT NULL,
	[FolderId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[FileId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Folder]    Script Date: 4/30/2020 11:51:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Folder](
	[FolderId] [int] IDENTITY(1,1) NOT NULL,
	[FolderName] [nvarchar](max) NOT NULL,
	[IsDelete] [bit] NOT NULL,
	[CreateBy] [varchar](50) NOT NULL,
	[CreateTime] [datetime] NOT NULL,
	[PRSystemId] [int] NOT NULL,
	[ParrentId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[FolderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LogAction]    Script Date: 4/30/2020 11:51:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LogAction](
	[LogActionId] [int] IDENTITY(1,1) NOT NULL,
	[LogCreateBy] [varchar](50) NOT NULL,
	[LogObjectId] [int] NOT NULL,
	[LogObjectType] [int] NOT NULL,
	[LogActionTypeId] [int] NOT NULL,
	[LogActionTime] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[LogActionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LogActionType]    Script Date: 4/30/2020 11:51:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LogActionType](
	[LogActionTypeId] [int] IDENTITY(1,1) NOT NULL,
	[LogActionTypeName] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[LogActionTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LogoAvartarImage]    Script Date: 4/30/2020 11:51:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LogoAvartarImage](
	[PostId] [int] NOT NULL,
	[MaterialId] [int] NOT NULL,
	[LastChangeTime] [datetime] NOT NULL,
	[LastChangeBy] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PostId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Material]    Script Date: 4/30/2020 11:51:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Material](
	[MaterialId] [int] IDENTITY(1,1) NOT NULL,
	[MaterialName] [nvarchar](100) NOT NULL,
	[MaterialDisplayName] [nvarchar](100) NOT NULL,
	[LaunchedDate] [datetime] NOT NULL,
	[CreateBy] [varchar](50) NOT NULL,
	[IsDelete] [bit] NOT NULL,
	[IsHilde] [bit] NOT NULL,
	[IsPublic] [bit] NOT NULL,
	[PositionInFolder] [int] NOT NULL,
	[MaterialType] [varchar](50) NULL,
	[FolderName] [nvarchar](max) NULL,
	[MaterialMD5Encrypt] [varchar](max) NULL,
	[PostId] [int] NOT NULL,
	[MIMEType] [varchar](10) NOT NULL,
	[DeleteTime] [datetime] NULL,
	[ImageAvatar] [varchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaterialId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Post]    Script Date: 4/30/2020 11:51:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Post](
	[PostId] [int] IDENTITY(0,1) NOT NULL,
	[PostTitle] [nvarchar](max) NOT NULL,
	[PostEngTitle] [varchar](max) NULL,
	[PostHashRealFolder] [nvarchar](max) NULL,
	[LaunchedDate] [datetime] NOT NULL,
	[CreateBy] [varchar](50) NOT NULL,
	[IsDelete] [bit] NOT NULL,
	[IsHide] [bit] NOT NULL,
	[IsPublic] [bit] NOT NULL,
	[IsInLogoPost] [bit] NOT NULL,
	[Position] [int] NOT NULL,
	[PRSystemId] [int] NOT NULL,
	[DeleteTime] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[PostId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PRSystem]    Script Date: 4/30/2020 11:51:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PRSystem](
	[PRSystemId] [int] IDENTITY(0,1) NOT NULL,
	[PRSystemName] [varchar](50) NOT NULL,
	[PRSystemVName] [nvarchar](max) NULL,
	[PRSystemIndependent] [bit] NOT NULL,
	[PRIsDelete] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PRSystemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Role]    Script Date: 4/30/2020 11:51:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Role](
	[RoleId] [int] IDENTITY(0,1) NOT NULL,
	[RoleName] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Slider]    Script Date: 4/30/2020 11:51:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Slider](
	[SliderId] [int] NOT NULL,
	[SliderName] [varchar](50) NOT NULL,
	[IsDelete] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SliderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[User]    Script Date: 4/30/2020 11:51:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[User](
	[UsernameId] [varchar](50) NOT NULL,
	[Password] [nvarchar](max) NULL,
	[Email] [varchar](50) NOT NULL,
	[FullName] [nvarchar](50) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[RoleId] [int] NOT NULL,
	[PRSystemId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UsernameId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[FileInDB] ON 

INSERT [dbo].[FileInDB] ([FileId], [FileName], [MIMEType], [Description], [IsHide], [IsDelete], [IsPublic], [LaunchedBy], [LaunchedDate], [LastEditBy], [LastEditTime], [FolderId]) VALUES (1, N'1', N'jpg', NULL, 0, 0, 0, N'superuser001', CAST(0x0000ABAC013419C6 AS DateTime), N'superuser001', CAST(0x0000ABAC013419C6 AS DateTime), 1)
INSERT [dbo].[FileInDB] ([FileId], [FileName], [MIMEType], [Description], [IsHide], [IsDelete], [IsPublic], [LaunchedBy], [LaunchedDate], [LastEditBy], [LastEditTime], [FolderId]) VALUES (2, N'2', N'jpg', NULL, 0, 0, 0, N'superuser001', CAST(0x0000ABAC01341A01 AS DateTime), N'superuser001', CAST(0x0000ABAC01341A01 AS DateTime), 1)
INSERT [dbo].[FileInDB] ([FileId], [FileName], [MIMEType], [Description], [IsHide], [IsDelete], [IsPublic], [LaunchedBy], [LaunchedDate], [LastEditBy], [LastEditTime], [FolderId]) VALUES (3, N'3', N'jpg', NULL, 0, 0, 0, N'superuser001', CAST(0x0000ABAC01341A04 AS DateTime), N'superuser001', CAST(0x0000ABAC01341A04 AS DateTime), 1)
INSERT [dbo].[FileInDB] ([FileId], [FileName], [MIMEType], [Description], [IsHide], [IsDelete], [IsPublic], [LaunchedBy], [LaunchedDate], [LastEditBy], [LastEditTime], [FolderId]) VALUES (4, N'pdf', N'jpg', NULL, 0, 0, 0, N'superuser001', CAST(0x0000ABAC013698A7 AS DateTime), N'superuser001', CAST(0x0000ABAC013698A7 AS DateTime), 6)
INSERT [dbo].[FileInDB] ([FileId], [FileName], [MIMEType], [Description], [IsHide], [IsDelete], [IsPublic], [LaunchedBy], [LaunchedDate], [LastEditBy], [LastEditTime], [FolderId]) VALUES (5, N'1', N'jpg', NULL, 0, 0, 0, N'superuser001', CAST(0x0000ABAC014F3F89 AS DateTime), N'superuser001', CAST(0x0000ABAC014F3F89 AS DateTime), 1)
INSERT [dbo].[FileInDB] ([FileId], [FileName], [MIMEType], [Description], [IsHide], [IsDelete], [IsPublic], [LaunchedBy], [LaunchedDate], [LastEditBy], [LastEditTime], [FolderId]) VALUES (6, N'2', N'jpg', NULL, 0, 0, 0, N'superuser001', CAST(0x0000ABAC014F3F8D AS DateTime), N'superuser001', CAST(0x0000ABAC014F3F8D AS DateTime), 1)
INSERT [dbo].[FileInDB] ([FileId], [FileName], [MIMEType], [Description], [IsHide], [IsDelete], [IsPublic], [LaunchedBy], [LaunchedDate], [LastEditBy], [LastEditTime], [FolderId]) VALUES (7, N'3', N'jpg', NULL, 0, 0, 0, N'superuser001', CAST(0x0000ABAC014F3F90 AS DateTime), N'superuser001', CAST(0x0000ABAC014F3F90 AS DateTime), 1)
INSERT [dbo].[FileInDB] ([FileId], [FileName], [MIMEType], [Description], [IsHide], [IsDelete], [IsPublic], [LaunchedBy], [LaunchedDate], [LastEditBy], [LastEditTime], [FolderId]) VALUES (8, N'4', N'jpg', NULL, 0, 0, 0, N'superuser001', CAST(0x0000ABAC014F3F93 AS DateTime), N'superuser001', CAST(0x0000ABAC014F3F93 AS DateTime), 1)
INSERT [dbo].[FileInDB] ([FileId], [FileName], [MIMEType], [Description], [IsHide], [IsDelete], [IsPublic], [LaunchedBy], [LaunchedDate], [LastEditBy], [LastEditTime], [FolderId]) VALUES (9, N'6', N'jpg', NULL, 0, 0, 0, N'superuser001', CAST(0x0000ABAC014F3F96 AS DateTime), N'superuser001', CAST(0x0000ABAC014F3F96 AS DateTime), 1)
INSERT [dbo].[FileInDB] ([FileId], [FileName], [MIMEType], [Description], [IsHide], [IsDelete], [IsPublic], [LaunchedBy], [LaunchedDate], [LastEditBy], [LastEditTime], [FolderId]) VALUES (10, N'7', N'jpg', NULL, 0, 0, 0, N'superuser001', CAST(0x0000ABAC014F3F99 AS DateTime), N'superuser001', CAST(0x0000ABAC014F3F99 AS DateTime), 1)
INSERT [dbo].[FileInDB] ([FileId], [FileName], [MIMEType], [Description], [IsHide], [IsDelete], [IsPublic], [LaunchedBy], [LaunchedDate], [LastEditBy], [LastEditTime], [FolderId]) VALUES (11, N'pdf', N'jpg', NULL, 0, 0, 0, N'superuser001', CAST(0x0000ABAC014F3FA0 AS DateTime), N'superuser001', CAST(0x0000ABAC014F3FA0 AS DateTime), 1)
INSERT [dbo].[FileInDB] ([FileId], [FileName], [MIMEType], [Description], [IsHide], [IsDelete], [IsPublic], [LaunchedBy], [LaunchedDate], [LastEditBy], [LastEditTime], [FolderId]) VALUES (12, N'all', N'css', NULL, 0, 0, 1, N'superuser001', CAST(0x0000ABAD00FDF6D8 AS DateTime), N'superuser001', CAST(0x0000ABAD00FDF6D8 AS DateTime), 9)
INSERT [dbo].[FileInDB] ([FileId], [FileName], [MIMEType], [Description], [IsHide], [IsDelete], [IsPublic], [LaunchedBy], [LaunchedDate], [LastEditBy], [LastEditTime], [FolderId]) VALUES (13, N'facebook', N'png', NULL, 0, 0, 1, N'superuser001', CAST(0x0000ABAD00FDF6E7 AS DateTime), N'superuser001', CAST(0x0000ABAD00FDF6E7 AS DateTime), 9)
INSERT [dbo].[FileInDB] ([FileId], [FileName], [MIMEType], [Description], [IsHide], [IsDelete], [IsPublic], [LaunchedBy], [LaunchedDate], [LastEditBy], [LastEditTime], [FolderId]) VALUES (14, N'font-awesome.min', N'css', NULL, 0, 0, 1, N'superuser001', CAST(0x0000ABAD00FDF706 AS DateTime), N'superuser001', CAST(0x0000ABAD00FDF706 AS DateTime), 9)
INSERT [dbo].[FileInDB] ([FileId], [FileName], [MIMEType], [Description], [IsHide], [IsDelete], [IsPublic], [LaunchedBy], [LaunchedDate], [LastEditBy], [LastEditTime], [FolderId]) VALUES (15, N'frog', N'png', NULL, 0, 0, 1, N'superuser001', CAST(0x0000ABAD00FDF726 AS DateTime), N'superuser001', CAST(0x0000ABAD00FDF726 AS DateTime), 9)
INSERT [dbo].[FileInDB] ([FileId], [FileName], [MIMEType], [Description], [IsHide], [IsDelete], [IsPublic], [LaunchedBy], [LaunchedDate], [LastEditBy], [LastEditTime], [FolderId]) VALUES (16, N'bootstrap.min', N'css', NULL, 0, 0, 1, N'superuser001', CAST(0x0000ABAD00FDF732 AS DateTime), N'superuser001', CAST(0x0000ABAD00FDF732 AS DateTime), 9)
INSERT [dbo].[FileInDB] ([FileId], [FileName], [MIMEType], [Description], [IsHide], [IsDelete], [IsPublic], [LaunchedBy], [LaunchedDate], [LastEditBy], [LastEditTime], [FolderId]) VALUES (17, N'CssFooter', N'css', NULL, 0, 0, 1, N'superuser001', CAST(0x0000ABAD00FDF742 AS DateTime), N'superuser001', CAST(0x0000ABAD00FDF742 AS DateTime), 9)
INSERT [dbo].[FileInDB] ([FileId], [FileName], [MIMEType], [Description], [IsHide], [IsDelete], [IsPublic], [LaunchedBy], [LaunchedDate], [LastEditBy], [LastEditTime], [FolderId]) VALUES (18, N'CssHeader1', N'css', NULL, 0, 0, 1, N'superuser001', CAST(0x0000ABAD00FDF75D AS DateTime), N'superuser001', CAST(0x0000ABAD00FDF75D AS DateTime), 9)
INSERT [dbo].[FileInDB] ([FileId], [FileName], [MIMEType], [Description], [IsHide], [IsDelete], [IsPublic], [LaunchedBy], [LaunchedDate], [LastEditBy], [LastEditTime], [FolderId]) VALUES (19, N'jquery.min.js', N'download', NULL, 0, 0, 1, N'superuser001', CAST(0x0000ABAD00FDF796 AS DateTime), N'superuser001', CAST(0x0000ABAD00FDF796 AS DateTime), 9)
INSERT [dbo].[FileInDB] ([FileId], [FileName], [MIMEType], [Description], [IsHide], [IsDelete], [IsPublic], [LaunchedBy], [LaunchedDate], [LastEditBy], [LastEditTime], [FolderId]) VALUES (20, N'youtube', N'png', NULL, 0, 0, 1, N'superuser001', CAST(0x0000ABAD00FDF7A1 AS DateTime), N'superuser001', CAST(0x0000ABAD00FDF7A1 AS DateTime), 9)
INSERT [dbo].[FileInDB] ([FileId], [FileName], [MIMEType], [Description], [IsHide], [IsDelete], [IsPublic], [LaunchedBy], [LaunchedDate], [LastEditBy], [LastEditTime], [FolderId]) VALUES (21, N'Header', N'png', NULL, 0, 0, 1, N'superuser001', CAST(0x0000ABAD00FDF7DE AS DateTime), N'superuser001', CAST(0x0000ABAD00FDF7DE AS DateTime), 9)
INSERT [dbo].[FileInDB] ([FileId], [FileName], [MIMEType], [Description], [IsHide], [IsDelete], [IsPublic], [LaunchedBy], [LaunchedDate], [LastEditBy], [LastEditTime], [FolderId]) VALUES (22, N'jpg', N'png', NULL, 0, 0, 1, N'superuser001', CAST(0x0000ABAD00FDF7F9 AS DateTime), N'superuser001', CAST(0x0000ABAD00FDF7F9 AS DateTime), 9)
INSERT [dbo].[FileInDB] ([FileId], [FileName], [MIMEType], [Description], [IsHide], [IsDelete], [IsPublic], [LaunchedBy], [LaunchedDate], [LastEditBy], [LastEditTime], [FolderId]) VALUES (23, N'all', N'css', NULL, 0, 0, 0, N'superuser001', CAST(0x0000ABAD017912DE AS DateTime), N'superuser001', CAST(0x0000ABAD017912DE AS DateTime), 1)
INSERT [dbo].[FileInDB] ([FileId], [FileName], [MIMEType], [Description], [IsHide], [IsDelete], [IsPublic], [LaunchedBy], [LaunchedDate], [LastEditBy], [LastEditTime], [FolderId]) VALUES (24, N'bootstrap.min', N'css', NULL, 0, 0, 0, N'superuser001', CAST(0x0000ABAD017912E7 AS DateTime), N'superuser001', CAST(0x0000ABAD017912E7 AS DateTime), 1)
INSERT [dbo].[FileInDB] ([FileId], [FileName], [MIMEType], [Description], [IsHide], [IsDelete], [IsPublic], [LaunchedBy], [LaunchedDate], [LastEditBy], [LastEditTime], [FolderId]) VALUES (25, N'CssFooter', N'css', NULL, 0, 0, 0, N'superuser001', CAST(0x0000ABAD017912EA AS DateTime), N'superuser001', CAST(0x0000ABAD017912EA AS DateTime), 1)
INSERT [dbo].[FileInDB] ([FileId], [FileName], [MIMEType], [Description], [IsHide], [IsDelete], [IsPublic], [LaunchedBy], [LaunchedDate], [LastEditBy], [LastEditTime], [FolderId]) VALUES (26, N'CssHeader1', N'css', NULL, 0, 0, 0, N'superuser001', CAST(0x0000ABAD017912EE AS DateTime), N'superuser001', CAST(0x0000ABAD017912EE AS DateTime), 1)
INSERT [dbo].[FileInDB] ([FileId], [FileName], [MIMEType], [Description], [IsHide], [IsDelete], [IsPublic], [LaunchedBy], [LaunchedDate], [LastEditBy], [LastEditTime], [FolderId]) VALUES (27, N'facebook', N'png', NULL, 0, 0, 0, N'superuser001', CAST(0x0000ABAD017912F0 AS DateTime), N'superuser001', CAST(0x0000ABAD017912F0 AS DateTime), 1)
INSERT [dbo].[FileInDB] ([FileId], [FileName], [MIMEType], [Description], [IsHide], [IsDelete], [IsPublic], [LaunchedBy], [LaunchedDate], [LastEditBy], [LastEditTime], [FolderId]) VALUES (28, N'font-awesome.min', N'css', NULL, 0, 0, 0, N'superuser001', CAST(0x0000ABAD017912F3 AS DateTime), N'superuser001', CAST(0x0000ABAD017912F3 AS DateTime), 1)
INSERT [dbo].[FileInDB] ([FileId], [FileName], [MIMEType], [Description], [IsHide], [IsDelete], [IsPublic], [LaunchedBy], [LaunchedDate], [LastEditBy], [LastEditTime], [FolderId]) VALUES (29, N'frog', N'png', NULL, 0, 0, 0, N'superuser001', CAST(0x0000ABAD017912F5 AS DateTime), N'superuser001', CAST(0x0000ABAD017912F5 AS DateTime), 1)
INSERT [dbo].[FileInDB] ([FileId], [FileName], [MIMEType], [Description], [IsHide], [IsDelete], [IsPublic], [LaunchedBy], [LaunchedDate], [LastEditBy], [LastEditTime], [FolderId]) VALUES (30, N'Header', N'png', NULL, 0, 0, 0, N'superuser001', CAST(0x0000ABAD017912F7 AS DateTime), N'superuser001', CAST(0x0000ABAD017912F7 AS DateTime), 1)
INSERT [dbo].[FileInDB] ([FileId], [FileName], [MIMEType], [Description], [IsHide], [IsDelete], [IsPublic], [LaunchedBy], [LaunchedDate], [LastEditBy], [LastEditTime], [FolderId]) VALUES (31, N'jpg', N'png', NULL, 0, 0, 0, N'superuser001', CAST(0x0000ABAD017912F9 AS DateTime), N'superuser001', CAST(0x0000ABAD017912F9 AS DateTime), 1)
INSERT [dbo].[FileInDB] ([FileId], [FileName], [MIMEType], [Description], [IsHide], [IsDelete], [IsPublic], [LaunchedBy], [LaunchedDate], [LastEditBy], [LastEditTime], [FolderId]) VALUES (32, N'jquery.min.js', N'download', NULL, 0, 0, 0, N'superuser001', CAST(0x0000ABAD0179130E AS DateTime), N'superuser001', CAST(0x0000ABAD0179130E AS DateTime), 1)
INSERT [dbo].[FileInDB] ([FileId], [FileName], [MIMEType], [Description], [IsHide], [IsDelete], [IsPublic], [LaunchedBy], [LaunchedDate], [LastEditBy], [LastEditTime], [FolderId]) VALUES (33, N'youtube', N'png', NULL, 0, 0, 0, N'superuser001', CAST(0x0000ABAD01791310 AS DateTime), N'superuser001', CAST(0x0000ABAD01791310 AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[FileInDB] OFF
SET IDENTITY_INSERT [dbo].[Folder] ON 

INSERT [dbo].[Folder] ([FolderId], [FolderName], [IsDelete], [CreateBy], [CreateTime], [PRSystemId], [ParrentId]) VALUES (0, N'Root', 0, N'superuser001', CAST(0x0000ABAC00317040 AS DateTime), 0, NULL)
INSERT [dbo].[Folder] ([FolderId], [FolderName], [IsDelete], [CreateBy], [CreateTime], [PRSystemId], [ParrentId]) VALUES (1, N'FEHO', 0, N'superuser001', CAST(0x0000ABAC00317040 AS DateTime), 0, 0)
INSERT [dbo].[Folder] ([FolderId], [FolderName], [IsDelete], [CreateBy], [CreateTime], [PRSystemId], [ParrentId]) VALUES (2, N'FPT University', 0, N'superuser001', CAST(0x0000ABAC00317040 AS DateTime), 1, 0)
INSERT [dbo].[Folder] ([FolderId], [FolderName], [IsDelete], [CreateBy], [CreateTime], [PRSystemId], [ParrentId]) VALUES (3, N'FPT Aptech', 0, N'superuser001', CAST(0x0000ABAC00317040 AS DateTime), 2, 0)
INSERT [dbo].[Folder] ([FolderId], [FolderName], [IsDelete], [CreateBy], [CreateTime], [PRSystemId], [ParrentId]) VALUES (4, N'FPT Poly', 0, N'superuser001', CAST(0x0000ABAC00317040 AS DateTime), 3, 0)
INSERT [dbo].[Folder] ([FolderId], [FolderName], [IsDelete], [CreateBy], [CreateTime], [PRSystemId], [ParrentId]) VALUES (5, N'ABC', 0, N'superuser001', CAST(0x0000ABAC012659BB AS DateTime), 0, 1)
INSERT [dbo].[Folder] ([FolderId], [FolderName], [IsDelete], [CreateBy], [CreateTime], [PRSystemId], [ParrentId]) VALUES (6, N'BCD', 0, N'superuser001', CAST(0x0000ABAC01270F36 AS DateTime), 0, 1)
INSERT [dbo].[Folder] ([FolderId], [FolderName], [IsDelete], [CreateBy], [CreateTime], [PRSystemId], [ParrentId]) VALUES (7, N'Tài nguyên số hóa FPT', 0, N'superuser001', CAST(0x0000ABAC012725CB AS DateTime), 0, 1)
INSERT [dbo].[Folder] ([FolderId], [FolderName], [IsDelete], [CreateBy], [CreateTime], [PRSystemId], [ParrentId]) VALUES (8, N'BCD_Child', 0, N'superuser001', CAST(0x0000ABAC014EE188 AS DateTime), 0, 6)
INSERT [dbo].[Folder] ([FolderId], [FolderName], [IsDelete], [CreateBy], [CreateTime], [PRSystemId], [ParrentId]) VALUES (9, N'Hệ thống số hóa thương hiệu FPT Education_files', 0, N'superuser001', CAST(0x0000ABAD00FDF694 AS DateTime), 0, 1)
INSERT [dbo].[Folder] ([FolderId], [FolderName], [IsDelete], [CreateBy], [CreateTime], [PRSystemId], [ParrentId]) VALUES (10, N'Folder Mới', 0, N'superuser001', CAST(0x0000ABAD0178F042 AS DateTime), 0, 1)
INSERT [dbo].[Folder] ([FolderId], [FolderName], [IsDelete], [CreateBy], [CreateTime], [PRSystemId], [ParrentId]) VALUES (11, N'Folder Mới 1', 0, N'superuser001', CAST(0x0000ABAD0182DDE9 AS DateTime), 0, 1)
INSERT [dbo].[Folder] ([FolderId], [FolderName], [IsDelete], [CreateBy], [CreateTime], [PRSystemId], [ParrentId]) VALUES (12, N'F', 0, N'superuser001', CAST(0x0000ABAD0182E73E AS DateTime), 0, 11)
SET IDENTITY_INSERT [dbo].[Folder] OFF
SET IDENTITY_INSERT [dbo].[LogAction] ON 

INSERT [dbo].[LogAction] ([LogActionId], [LogCreateBy], [LogObjectId], [LogObjectType], [LogActionTypeId], [LogActionTime]) VALUES (1, N'superuser001', 53, 2, 1, CAST(0x0000ABAC014B9582 AS DateTime))
INSERT [dbo].[LogAction] ([LogActionId], [LogCreateBy], [LogObjectId], [LogObjectType], [LogActionTypeId], [LogActionTime]) VALUES (2, N'superuser001', 2, 2, 3, CAST(0x0000ABAD00FAC046 AS DateTime))
INSERT [dbo].[LogAction] ([LogActionId], [LogCreateBy], [LogObjectId], [LogObjectType], [LogActionTypeId], [LogActionTime]) VALUES (3, N'superuser001', 3, 2, 3, CAST(0x0000ABAD00FAC04D AS DateTime))
INSERT [dbo].[LogAction] ([LogActionId], [LogCreateBy], [LogObjectId], [LogObjectType], [LogActionTypeId], [LogActionTime]) VALUES (4, N'superuser001', 23, 2, 3, CAST(0x0000ABAD00FAC04F AS DateTime))
INSERT [dbo].[LogAction] ([LogActionId], [LogCreateBy], [LogObjectId], [LogObjectType], [LogActionTypeId], [LogActionTime]) VALUES (5, N'superuser001', 2, 1, 3, CAST(0x0000ABAD00FAC050 AS DateTime))
INSERT [dbo].[LogAction] ([LogActionId], [LogCreateBy], [LogObjectId], [LogObjectType], [LogActionTypeId], [LogActionTime]) VALUES (6, N'superuser001', 45, 2, 3, CAST(0x0000ABAD00FAC4C9 AS DateTime))
INSERT [dbo].[LogAction] ([LogActionId], [LogCreateBy], [LogObjectId], [LogObjectType], [LogActionTypeId], [LogActionTime]) VALUES (7, N'superuser001', 8, 1, 3, CAST(0x0000ABAD00FAC4CC AS DateTime))
INSERT [dbo].[LogAction] ([LogActionId], [LogCreateBy], [LogObjectId], [LogObjectType], [LogActionTypeId], [LogActionTime]) VALUES (8, N'superuser001', 1, 2, 3, CAST(0x0000ABAD00FAC8A3 AS DateTime))
INSERT [dbo].[LogAction] ([LogActionId], [LogCreateBy], [LogObjectId], [LogObjectType], [LogActionTypeId], [LogActionTime]) VALUES (9, N'superuser001', 1, 1, 3, CAST(0x0000ABAD00FAC8A5 AS DateTime))
INSERT [dbo].[LogAction] ([LogActionId], [LogCreateBy], [LogObjectId], [LogObjectType], [LogActionTypeId], [LogActionTime]) VALUES (10, N'superuser001', 53, 2, 3, CAST(0x0000ABAD00FACCBB AS DateTime))
INSERT [dbo].[LogAction] ([LogActionId], [LogCreateBy], [LogObjectId], [LogObjectType], [LogActionTypeId], [LogActionTime]) VALUES (11, N'superuser001', 9, 1, 3, CAST(0x0000ABAD00FACCBE AS DateTime))
INSERT [dbo].[LogAction] ([LogActionId], [LogCreateBy], [LogObjectId], [LogObjectType], [LogActionTypeId], [LogActionTime]) VALUES (12, N'superuser001', 32, 2, 3, CAST(0x0000ABAD010687B5 AS DateTime))
INSERT [dbo].[LogAction] ([LogActionId], [LogCreateBy], [LogObjectId], [LogObjectType], [LogActionTypeId], [LogActionTime]) VALUES (13, N'superuser001', 33, 2, 3, CAST(0x0000ABAD010687EE AS DateTime))
INSERT [dbo].[LogAction] ([LogActionId], [LogCreateBy], [LogObjectId], [LogObjectType], [LogActionTypeId], [LogActionTime]) VALUES (14, N'superuser001', 34, 2, 3, CAST(0x0000ABAD010687F0 AS DateTime))
INSERT [dbo].[LogAction] ([LogActionId], [LogCreateBy], [LogObjectId], [LogObjectType], [LogActionTypeId], [LogActionTime]) VALUES (15, N'superuser001', 35, 2, 3, CAST(0x0000ABAD010687F2 AS DateTime))
INSERT [dbo].[LogAction] ([LogActionId], [LogCreateBy], [LogObjectId], [LogObjectType], [LogActionTypeId], [LogActionTime]) VALUES (16, N'superuser001', 36, 2, 3, CAST(0x0000ABAD010687F3 AS DateTime))
INSERT [dbo].[LogAction] ([LogActionId], [LogCreateBy], [LogObjectId], [LogObjectType], [LogActionTypeId], [LogActionTime]) VALUES (17, N'superuser001', 37, 2, 3, CAST(0x0000ABAD010687F4 AS DateTime))
INSERT [dbo].[LogAction] ([LogActionId], [LogCreateBy], [LogObjectId], [LogObjectType], [LogActionTypeId], [LogActionTime]) VALUES (18, N'superuser001', 38, 2, 3, CAST(0x0000ABAD010687F4 AS DateTime))
INSERT [dbo].[LogAction] ([LogActionId], [LogCreateBy], [LogObjectId], [LogObjectType], [LogActionTypeId], [LogActionTime]) VALUES (19, N'superuser001', 39, 2, 3, CAST(0x0000ABAD010687F6 AS DateTime))
INSERT [dbo].[LogAction] ([LogActionId], [LogCreateBy], [LogObjectId], [LogObjectType], [LogActionTypeId], [LogActionTime]) VALUES (20, N'superuser001', 40, 2, 3, CAST(0x0000ABAD010687F7 AS DateTime))
INSERT [dbo].[LogAction] ([LogActionId], [LogCreateBy], [LogObjectId], [LogObjectType], [LogActionTypeId], [LogActionTime]) VALUES (21, N'superuser001', 41, 2, 3, CAST(0x0000ABAD010687F7 AS DateTime))
INSERT [dbo].[LogAction] ([LogActionId], [LogCreateBy], [LogObjectId], [LogObjectType], [LogActionTypeId], [LogActionTime]) VALUES (22, N'superuser001', 42, 2, 3, CAST(0x0000ABAD010687F8 AS DateTime))
INSERT [dbo].[LogAction] ([LogActionId], [LogCreateBy], [LogObjectId], [LogObjectType], [LogActionTypeId], [LogActionTime]) VALUES (23, N'superuser001', 43, 2, 3, CAST(0x0000ABAD010687F9 AS DateTime))
INSERT [dbo].[LogAction] ([LogActionId], [LogCreateBy], [LogObjectId], [LogObjectType], [LogActionTypeId], [LogActionTime]) VALUES (24, N'superuser001', 13, 1, 3, CAST(0x0000ABAD010687FA AS DateTime))
INSERT [dbo].[LogAction] ([LogActionId], [LogCreateBy], [LogObjectId], [LogObjectType], [LogActionTypeId], [LogActionTime]) VALUES (25, N'superuser001', 46, 2, 3, CAST(0x0000ABAD01068E63 AS DateTime))
INSERT [dbo].[LogAction] ([LogActionId], [LogCreateBy], [LogObjectId], [LogObjectType], [LogActionTypeId], [LogActionTime]) VALUES (26, N'superuser001', 47, 2, 3, CAST(0x0000ABAD01068E66 AS DateTime))
INSERT [dbo].[LogAction] ([LogActionId], [LogCreateBy], [LogObjectId], [LogObjectType], [LogActionTypeId], [LogActionTime]) VALUES (27, N'superuser001', 48, 2, 3, CAST(0x0000ABAD01068E68 AS DateTime))
INSERT [dbo].[LogAction] ([LogActionId], [LogCreateBy], [LogObjectId], [LogObjectType], [LogActionTypeId], [LogActionTime]) VALUES (28, N'superuser001', 14, 1, 3, CAST(0x0000ABAD01068E69 AS DateTime))
INSERT [dbo].[LogAction] ([LogActionId], [LogCreateBy], [LogObjectId], [LogObjectType], [LogActionTypeId], [LogActionTime]) VALUES (29, N'superuser001', 25, 2, 3, CAST(0x0000ABAD0106940B AS DateTime))
INSERT [dbo].[LogAction] ([LogActionId], [LogCreateBy], [LogObjectId], [LogObjectType], [LogActionTypeId], [LogActionTime]) VALUES (30, N'superuser001', 26, 2, 3, CAST(0x0000ABAD0106940F AS DateTime))
INSERT [dbo].[LogAction] ([LogActionId], [LogCreateBy], [LogObjectId], [LogObjectType], [LogActionTypeId], [LogActionTime]) VALUES (31, N'superuser001', 27, 2, 3, CAST(0x0000ABAD01069411 AS DateTime))
INSERT [dbo].[LogAction] ([LogActionId], [LogCreateBy], [LogObjectId], [LogObjectType], [LogActionTypeId], [LogActionTime]) VALUES (32, N'superuser001', 10, 1, 3, CAST(0x0000ABAD01069412 AS DateTime))
INSERT [dbo].[LogAction] ([LogActionId], [LogCreateBy], [LogObjectId], [LogObjectType], [LogActionTypeId], [LogActionTime]) VALUES (33, N'superuser001', 28, 2, 3, CAST(0x0000ABAD01069856 AS DateTime))
INSERT [dbo].[LogAction] ([LogActionId], [LogCreateBy], [LogObjectId], [LogObjectType], [LogActionTypeId], [LogActionTime]) VALUES (34, N'superuser001', 11, 1, 3, CAST(0x0000ABAD01069859 AS DateTime))
INSERT [dbo].[LogAction] ([LogActionId], [LogCreateBy], [LogObjectId], [LogObjectType], [LogActionTypeId], [LogActionTime]) VALUES (35, N'superuser001', 60, 2, 1, CAST(0x0000ABAD010A0FFA AS DateTime))
INSERT [dbo].[LogAction] ([LogActionId], [LogCreateBy], [LogObjectId], [LogObjectType], [LogActionTypeId], [LogActionTime]) VALUES (36, N'superuser001', 4, 2, 3, CAST(0x0000ABAD010A18B6 AS DateTime))
INSERT [dbo].[LogAction] ([LogActionId], [LogCreateBy], [LogObjectId], [LogObjectType], [LogActionTypeId], [LogActionTime]) VALUES (37, N'superuser001', 5, 2, 3, CAST(0x0000ABAD010A18BB AS DateTime))
INSERT [dbo].[LogAction] ([LogActionId], [LogCreateBy], [LogObjectId], [LogObjectType], [LogActionTypeId], [LogActionTime]) VALUES (38, N'superuser001', 22, 2, 3, CAST(0x0000ABAD010A18BD AS DateTime))
INSERT [dbo].[LogAction] ([LogActionId], [LogCreateBy], [LogObjectId], [LogObjectType], [LogActionTypeId], [LogActionTime]) VALUES (39, N'superuser001', 24, 2, 3, CAST(0x0000ABAD010A18BE AS DateTime))
INSERT [dbo].[LogAction] ([LogActionId], [LogCreateBy], [LogObjectId], [LogObjectType], [LogActionTypeId], [LogActionTime]) VALUES (40, N'superuser001', 44, 2, 3, CAST(0x0000ABAD010A18BF AS DateTime))
INSERT [dbo].[LogAction] ([LogActionId], [LogCreateBy], [LogObjectId], [LogObjectType], [LogActionTypeId], [LogActionTime]) VALUES (41, N'superuser001', 49, 2, 3, CAST(0x0000ABAD010A18C0 AS DateTime))
INSERT [dbo].[LogAction] ([LogActionId], [LogCreateBy], [LogObjectId], [LogObjectType], [LogActionTypeId], [LogActionTime]) VALUES (42, N'superuser001', 3, 1, 3, CAST(0x0000ABAD010A18C2 AS DateTime))
INSERT [dbo].[LogAction] ([LogActionId], [LogCreateBy], [LogObjectId], [LogObjectType], [LogActionTypeId], [LogActionTime]) VALUES (43, N'superuser001', 61, 2, 1, CAST(0x0000ABAD010A1F09 AS DateTime))
INSERT [dbo].[LogAction] ([LogActionId], [LogCreateBy], [LogObjectId], [LogObjectType], [LogActionTypeId], [LogActionTime]) VALUES (44, N'superuser001', 62, 2, 1, CAST(0x0000ABAD0173B7A4 AS DateTime))
INSERT [dbo].[LogAction] ([LogActionId], [LogCreateBy], [LogObjectId], [LogObjectType], [LogActionTypeId], [LogActionTime]) VALUES (45, N'superuser001', 63, 2, 1, CAST(0x0000ABAD0173CB6A AS DateTime))
INSERT [dbo].[LogAction] ([LogActionId], [LogCreateBy], [LogObjectId], [LogObjectType], [LogActionTypeId], [LogActionTime]) VALUES (46, N'superuser001', 64, 2, 1, CAST(0x0000ABAD0174DB63 AS DateTime))
INSERT [dbo].[LogAction] ([LogActionId], [LogCreateBy], [LogObjectId], [LogObjectType], [LogActionTypeId], [LogActionTime]) VALUES (47, N'superuser001', 54, 2, 3, CAST(0x0000ABAD0174EFE7 AS DateTime))
INSERT [dbo].[LogAction] ([LogActionId], [LogCreateBy], [LogObjectId], [LogObjectType], [LogActionTypeId], [LogActionTime]) VALUES (48, N'superuser001', 55, 2, 3, CAST(0x0000ABAD0174EFEB AS DateTime))
INSERT [dbo].[LogAction] ([LogActionId], [LogCreateBy], [LogObjectId], [LogObjectType], [LogActionTypeId], [LogActionTime]) VALUES (49, N'superuser001', 56, 2, 3, CAST(0x0000ABAD0174EFF0 AS DateTime))
INSERT [dbo].[LogAction] ([LogActionId], [LogCreateBy], [LogObjectId], [LogObjectType], [LogActionTypeId], [LogActionTime]) VALUES (50, N'superuser001', 57, 2, 3, CAST(0x0000ABAD0174EFF2 AS DateTime))
INSERT [dbo].[LogAction] ([LogActionId], [LogCreateBy], [LogObjectId], [LogObjectType], [LogActionTypeId], [LogActionTime]) VALUES (51, N'superuser001', 58, 2, 3, CAST(0x0000ABAD0174EFF4 AS DateTime))
INSERT [dbo].[LogAction] ([LogActionId], [LogCreateBy], [LogObjectId], [LogObjectType], [LogActionTypeId], [LogActionTime]) VALUES (52, N'superuser001', 59, 2, 3, CAST(0x0000ABAD0174EFF5 AS DateTime))
INSERT [dbo].[LogAction] ([LogActionId], [LogCreateBy], [LogObjectId], [LogObjectType], [LogActionTypeId], [LogActionTime]) VALUES (53, N'superuser001', 60, 2, 3, CAST(0x0000ABAD0174EFF6 AS DateTime))
INSERT [dbo].[LogAction] ([LogActionId], [LogCreateBy], [LogObjectId], [LogObjectType], [LogActionTypeId], [LogActionTime]) VALUES (54, N'superuser001', 61, 2, 3, CAST(0x0000ABAD0174EFF8 AS DateTime))
INSERT [dbo].[LogAction] ([LogActionId], [LogCreateBy], [LogObjectId], [LogObjectType], [LogActionTypeId], [LogActionTime]) VALUES (55, N'superuser001', 64, 2, 3, CAST(0x0000ABAD0174EFFA AS DateTime))
INSERT [dbo].[LogAction] ([LogActionId], [LogCreateBy], [LogObjectId], [LogObjectType], [LogActionTypeId], [LogActionTime]) VALUES (56, N'superuser001', 15, 1, 3, CAST(0x0000ABAD0174EFFB AS DateTime))
INSERT [dbo].[LogAction] ([LogActionId], [LogCreateBy], [LogObjectId], [LogObjectType], [LogActionTypeId], [LogActionTime]) VALUES (57, N'superuser001', 68, 2, 1, CAST(0x0000ABAD0182491D AS DateTime))
INSERT [dbo].[LogAction] ([LogActionId], [LogCreateBy], [LogObjectId], [LogObjectType], [LogActionTypeId], [LogActionTime]) VALUES (58, N'superuser001', 69, 2, 1, CAST(0x0000ABAD01826163 AS DateTime))
SET IDENTITY_INSERT [dbo].[LogAction] OFF
SET IDENTITY_INSERT [dbo].[LogActionType] ON 

INSERT [dbo].[LogActionType] ([LogActionTypeId], [LogActionTypeName]) VALUES (1, N'CREATE')
INSERT [dbo].[LogActionType] ([LogActionTypeId], [LogActionTypeName]) VALUES (2, N'UPDATE')
INSERT [dbo].[LogActionType] ([LogActionTypeId], [LogActionTypeName]) VALUES (3, N'DELETE')
INSERT [dbo].[LogActionType] ([LogActionTypeId], [LogActionTypeName]) VALUES (4, N'RECYCLE')
INSERT [dbo].[LogActionType] ([LogActionTypeId], [LogActionTypeName]) VALUES (5, N'HIDE')
SET IDENTITY_INSERT [dbo].[LogActionType] OFF
INSERT [dbo].[LogoAvartarImage] ([PostId], [MaterialId], [LastChangeTime], [LastChangeBy]) VALUES (4, 7, CAST(0x0000ABAC011D9029 AS DateTime), N'superuser001')
INSERT [dbo].[LogoAvartarImage] ([PostId], [MaterialId], [LastChangeTime], [LastChangeBy]) VALUES (5, 11, CAST(0x0000ABAC011D820E AS DateTime), N'superuser001')
INSERT [dbo].[LogoAvartarImage] ([PostId], [MaterialId], [LastChangeTime], [LastChangeBy]) VALUES (7, 18, CAST(0x0000ABAC011D8950 AS DateTime), N'superuser001')
INSERT [dbo].[LogoAvartarImage] ([PostId], [MaterialId], [LastChangeTime], [LastChangeBy]) VALUES (17, 66, CAST(0x0000ABAD0175A664 AS DateTime), N'superuser001')
SET IDENTITY_INSERT [dbo].[Material] ON 

INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [IsPublic], [PositionInFolder], [MaterialType], [FolderName], [MaterialMD5Encrypt], [PostId], [MIMEType], [DeleteTime], [ImageAvatar]) VALUES (1, N'Brochure-2015', N'Bản Tiếng Việt 2015', CAST(0x0000AB9F01605738 AS DateTime), N'superuser001', 1, 0, 1, 1, NULL, NULL, NULL, 1, N'pdf', NULL, N'3.jpg')
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [IsPublic], [PositionInFolder], [MaterialType], [FolderName], [MaterialMD5Encrypt], [PostId], [MIMEType], [DeleteTime], [ImageAvatar]) VALUES (2, N'Brochure2', N'Bản Tiếng Việt 2015', CAST(0x0000AB9F01605738 AS DateTime), N'superuser001', 1, 0, 1, 1, NULL, NULL, NULL, 2, N'jpg', NULL, NULL)
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [IsPublic], [PositionInFolder], [MaterialType], [FolderName], [MaterialMD5Encrypt], [PostId], [MIMEType], [DeleteTime], [ImageAvatar]) VALUES (3, N'Brochure5', N'English version 2015', CAST(0x0000AB9F01605738 AS DateTime), N'superuser001', 1, 0, 1, 1, NULL, NULL, NULL, 2, N'jpg', NULL, NULL)
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [IsPublic], [PositionInFolder], [MaterialType], [FolderName], [MaterialMD5Encrypt], [PostId], [MIMEType], [DeleteTime], [ImageAvatar]) VALUES (4, N'1', N'Bản Tiếng Việt 2018', CAST(0x0000AB9F01605738 AS DateTime), N'superuser001', 1, 0, 1, 1, NULL, NULL, NULL, 3, N'pdf', NULL, NULL)
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [IsPublic], [PositionInFolder], [MaterialType], [FolderName], [MaterialMD5Encrypt], [PostId], [MIMEType], [DeleteTime], [ImageAvatar]) VALUES (5, N'2', N'English Version 2018', CAST(0x0000AB9F01605738 AS DateTime), N'superuser001', 1, 0, 1, 2, NULL, NULL, NULL, 3, N'pdf', NULL, NULL)
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [IsPublic], [PositionInFolder], [MaterialType], [FolderName], [MaterialMD5Encrypt], [PostId], [MIMEType], [DeleteTime], [ImageAvatar]) VALUES (6, N'Logo-FE', N'Logo-FE.ai', CAST(0x0000AB9F01605738 AS DateTime), N'superuser001', 0, 0, 1, 1, NULL, NULL, NULL, 4, N'ai', NULL, NULL)
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [IsPublic], [PositionInFolder], [MaterialType], [FolderName], [MaterialMD5Encrypt], [PostId], [MIMEType], [DeleteTime], [ImageAvatar]) VALUES (7, N'Logo-FE', N'Logo-FE.png', CAST(0x0000AB9F01605738 AS DateTime), N'superuser001', 0, 0, 1, 1, NULL, NULL, NULL, 4, N'png', NULL, NULL)
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [IsPublic], [PositionInFolder], [MaterialType], [FolderName], [MaterialMD5Encrypt], [PostId], [MIMEType], [DeleteTime], [ImageAvatar]) VALUES (8, N'Logo-FE-view', N'Logo-FE-view.pdf', CAST(0x0000AB9F01605738 AS DateTime), N'superuser001', 0, 0, 1, 1, NULL, NULL, NULL, 4, N'pdf', NULL, NULL)
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [IsPublic], [PositionInFolder], [MaterialType], [FolderName], [MaterialMD5Encrypt], [PostId], [MIMEType], [DeleteTime], [ImageAvatar]) VALUES (9, N'Logo-FU', N'Logo-FU.ai', CAST(0x0000AB9F01605738 AS DateTime), N'superuser001', 0, 0, 1, 1, NULL, NULL, NULL, 5, N'ai', NULL, NULL)
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [IsPublic], [PositionInFolder], [MaterialType], [FolderName], [MaterialMD5Encrypt], [PostId], [MIMEType], [DeleteTime], [ImageAvatar]) VALUES (10, N'Logo-FU-01', N'Logo-FU-01.png', CAST(0x0000AB9F01605738 AS DateTime), N'superuser001', 0, 0, 1, 2, NULL, NULL, NULL, 5, N'png', NULL, NULL)
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [IsPublic], [PositionInFolder], [MaterialType], [FolderName], [MaterialMD5Encrypt], [PostId], [MIMEType], [DeleteTime], [ImageAvatar]) VALUES (11, N'Logo-FU-02', N'Logo-FU-02.png', CAST(0x0000AB9F01605738 AS DateTime), N'superuser001', 0, 0, 1, 3, NULL, NULL, NULL, 5, N'png', NULL, NULL)
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [IsPublic], [PositionInFolder], [MaterialType], [FolderName], [MaterialMD5Encrypt], [PostId], [MIMEType], [DeleteTime], [ImageAvatar]) VALUES (12, N'Logo-FU-03', N'Logo-FU-03.png', CAST(0x0000AB9F01605738 AS DateTime), N'superuser001', 0, 0, 1, 4, NULL, NULL, NULL, 5, N'png', NULL, NULL)
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [IsPublic], [PositionInFolder], [MaterialType], [FolderName], [MaterialMD5Encrypt], [PostId], [MIMEType], [DeleteTime], [ImageAvatar]) VALUES (13, N'Logo-FU-view', N'Logo-FU-view.pdf', CAST(0x0000AB9F01605738 AS DateTime), N'superuser001', 0, 0, 1, 5, NULL, NULL, NULL, 5, N'pdf', NULL, NULL)
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [IsPublic], [PositionInFolder], [MaterialType], [FolderName], [MaterialMD5Encrypt], [PostId], [MIMEType], [DeleteTime], [ImageAvatar]) VALUES (14, N'Logo-Nano', N'Logo-Nano.ai', CAST(0x0000AB9F01605738 AS DateTime), N'superuser001', 0, 0, 1, 1, NULL, NULL, NULL, 6, N'ai', NULL, NULL)
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [IsPublic], [PositionInFolder], [MaterialType], [FolderName], [MaterialMD5Encrypt], [PostId], [MIMEType], [DeleteTime], [ImageAvatar]) VALUES (15, N'Logo-Nano', N'Logo-Nano.png', CAST(0x0000AB9F01605738 AS DateTime), N'superuser001', 0, 0, 1, 2, NULL, NULL, NULL, 6, N'png', NULL, NULL)
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [IsPublic], [PositionInFolder], [MaterialType], [FolderName], [MaterialMD5Encrypt], [PostId], [MIMEType], [DeleteTime], [ImageAvatar]) VALUES (16, N'Logo-Nano-view', N'Logo-Nano-view.pdf', CAST(0x0000AB9F01605738 AS DateTime), N'superuser001', 0, 0, 1, 5, NULL, NULL, NULL, 6, N'pdf', NULL, NULL)
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [IsPublic], [PositionInFolder], [MaterialType], [FolderName], [MaterialMD5Encrypt], [PostId], [MIMEType], [DeleteTime], [ImageAvatar]) VALUES (17, N'Logo-FaiTongHop', N'Logo-FaiTongHop.ai', CAST(0x0000AB9F01605738 AS DateTime), N'superuser001', 0, 0, 1, 1, NULL, NULL, NULL, 7, N'ai', NULL, NULL)
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [IsPublic], [PositionInFolder], [MaterialType], [FolderName], [MaterialMD5Encrypt], [PostId], [MIMEType], [DeleteTime], [ImageAvatar]) VALUES (18, N'Logo-FaiTongHop', N'Logo-FaiTongHop.png', CAST(0x0000AB9F01605738 AS DateTime), N'superuser001', 0, 0, 1, 2, NULL, NULL, NULL, 7, N'jpg', NULL, NULL)
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [IsPublic], [PositionInFolder], [MaterialType], [FolderName], [MaterialMD5Encrypt], [PostId], [MIMEType], [DeleteTime], [ImageAvatar]) VALUES (19, N'Logo-FaiTongHop-01', N'Logo-FaiTongHop-01.png', CAST(0x0000AB9F01605738 AS DateTime), N'superuser001', 0, 0, 1, 3, NULL, NULL, NULL, 7, N'png', NULL, NULL)
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [IsPublic], [PositionInFolder], [MaterialType], [FolderName], [MaterialMD5Encrypt], [PostId], [MIMEType], [DeleteTime], [ImageAvatar]) VALUES (20, N'Logo-FU-03', N'Logo-FU-03.png', CAST(0x0000AB9F01605738 AS DateTime), N'superuser001', 1, 0, 1, 4, NULL, NULL, NULL, 7, N'png', NULL, NULL)
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [IsPublic], [PositionInFolder], [MaterialType], [FolderName], [MaterialMD5Encrypt], [PostId], [MIMEType], [DeleteTime], [ImageAvatar]) VALUES (21, N'Logo-FaiTongHop-view', N'Logo-FaiTongHop-view.pdf', CAST(0x0000AB9F01605738 AS DateTime), N'superuser001', 0, 0, 1, 5, NULL, NULL, NULL, 7, N'pdf', NULL, NULL)
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [IsPublic], [PositionInFolder], [MaterialType], [FolderName], [MaterialMD5Encrypt], [PostId], [MIMEType], [DeleteTime], [ImageAvatar]) VALUES (22, N'Login', N'ASDASD', CAST(0x0000ABA201570E23 AS DateTime), N'superuser001', 1, 0, 1, 2, NULL, NULL, NULL, 3, N'html', NULL, NULL)
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [IsPublic], [PositionInFolder], [MaterialType], [FolderName], [MaterialMD5Encrypt], [PostId], [MIMEType], [DeleteTime], [ImageAvatar]) VALUES (23, N'brochure3', N'Hình ảnh 1', CAST(0x0000ABA2015977B4 AS DateTime), N'superuser001', 1, 0, 1, 1, NULL, NULL, NULL, 2, N'jpg', NULL, NULL)
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [IsPublic], [PositionInFolder], [MaterialType], [FolderName], [MaterialMD5Encrypt], [PostId], [MIMEType], [DeleteTime], [ImageAvatar]) VALUES (24, N'video2', N'Bản tiếng việt 2020', CAST(0x0000ABA2015DCC97 AS DateTime), N'superuser001', 1, 0, 1, 2, NULL, NULL, NULL, 3, N'm4v', NULL, NULL)
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [IsPublic], [PositionInFolder], [MaterialType], [FolderName], [MaterialMD5Encrypt], [PostId], [MIMEType], [DeleteTime], [ImageAvatar]) VALUES (25, N'Brochure6', N'Khuân viên trường học', CAST(0x0000ABA400EFA381 AS DateTime), N'superuser001', 1, 0, 1, 1, NULL, NULL, NULL, 10, N'jpg', NULL, NULL)
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [IsPublic], [PositionInFolder], [MaterialType], [FolderName], [MaterialMD5Encrypt], [PostId], [MIMEType], [DeleteTime], [ImageAvatar]) VALUES (26, N'Brochure10', N'Ảnh đại diện 2', CAST(0x0000ABA400EFA827 AS DateTime), N'superuser001', 1, 0, 1, 2, NULL, NULL, NULL, 10, N'jpg', NULL, NULL)
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [IsPublic], [PositionInFolder], [MaterialType], [FolderName], [MaterialMD5Encrypt], [PostId], [MIMEType], [DeleteTime], [ImageAvatar]) VALUES (27, N'Test8', N'Ảnh dại diện 3', CAST(0x0000ABA400EFABD8 AS DateTime), N'superuser001', 1, 0, 1, 3, NULL, NULL, NULL, 10, N'jpg', NULL, NULL)
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [IsPublic], [PositionInFolder], [MaterialType], [FolderName], [MaterialMD5Encrypt], [PostId], [MIMEType], [DeleteTime], [ImageAvatar]) VALUES (28, N'Brochure11', N'Tết dân gian', CAST(0x0000ABA40101A209 AS DateTime), N'superuser001', 1, 0, 1, 1, NULL, NULL, NULL, 11, N'jpg', NULL, NULL)
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [IsPublic], [PositionInFolder], [MaterialType], [FolderName], [MaterialMD5Encrypt], [PostId], [MIMEType], [DeleteTime], [ImageAvatar]) VALUES (29, N'Logo-Jetking', N'Logo-Jetking.ai', CAST(0x0000ABA4015C6BDF AS DateTime), N'superuser001', 0, 0, 1, 1, NULL, NULL, NULL, 12, N'ai', NULL, NULL)
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [IsPublic], [PositionInFolder], [MaterialType], [FolderName], [MaterialMD5Encrypt], [PostId], [MIMEType], [DeleteTime], [ImageAvatar]) VALUES (30, N'Logo-Jetking', N'Logo-Jetking.png', CAST(0x0000ABA4015C6BE8 AS DateTime), N'superuser001', 0, 0, 1, 2, NULL, NULL, NULL, 12, N'png', NULL, NULL)
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [IsPublic], [PositionInFolder], [MaterialType], [FolderName], [MaterialMD5Encrypt], [PostId], [MIMEType], [DeleteTime], [ImageAvatar]) VALUES (31, N'Logo-Jetking-view', N'Logo-Jetking-view.pdf', CAST(0x0000ABA4015C6BEB AS DateTime), N'superuser001', 0, 0, 1, 3, NULL, NULL, NULL, 12, N'pdf', NULL, NULL)
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [IsPublic], [PositionInFolder], [MaterialType], [FolderName], [MaterialMD5Encrypt], [PostId], [MIMEType], [DeleteTime], [ImageAvatar]) VALUES (32, N'Brochure2', N'Ảnh hiếu 1', CAST(0x0000ABA4015E7058 AS DateTime), N'superuser001', 1, 0, 1, 1, NULL, NULL, NULL, 13, N'jpg', NULL, NULL)
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [IsPublic], [PositionInFolder], [MaterialType], [FolderName], [MaterialMD5Encrypt], [PostId], [MIMEType], [DeleteTime], [ImageAvatar]) VALUES (33, N'Brochure3', N'Ảnh hiếu 1', CAST(0x0000ABA4015E7064 AS DateTime), N'superuser001', 1, 0, 1, 2, NULL, NULL, NULL, 13, N'jpg', NULL, NULL)
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [IsPublic], [PositionInFolder], [MaterialType], [FolderName], [MaterialMD5Encrypt], [PostId], [MIMEType], [DeleteTime], [ImageAvatar]) VALUES (34, N'Brochure4', N'Ảnh hiếu 1', CAST(0x0000ABA4015E7067 AS DateTime), N'superuser001', 1, 0, 1, 3, NULL, NULL, NULL, 13, N'jpg', NULL, NULL)
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [IsPublic], [PositionInFolder], [MaterialType], [FolderName], [MaterialMD5Encrypt], [PostId], [MIMEType], [DeleteTime], [ImageAvatar]) VALUES (35, N'Brochure5', N'Ảnh hiếu 1', CAST(0x0000ABA4015E706D AS DateTime), N'superuser001', 1, 0, 1, 4, NULL, NULL, NULL, 13, N'jpg', NULL, NULL)
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [IsPublic], [PositionInFolder], [MaterialType], [FolderName], [MaterialMD5Encrypt], [PostId], [MIMEType], [DeleteTime], [ImageAvatar]) VALUES (36, N'Brochure6', N'Ảnh hiếu 1', CAST(0x0000ABA4015E7070 AS DateTime), N'superuser001', 1, 0, 1, 5, NULL, NULL, NULL, 13, N'jpg', NULL, NULL)
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [IsPublic], [PositionInFolder], [MaterialType], [FolderName], [MaterialMD5Encrypt], [PostId], [MIMEType], [DeleteTime], [ImageAvatar]) VALUES (37, N'Brochure7', N'Ảnh hiếu 1', CAST(0x0000ABA4015E7076 AS DateTime), N'superuser001', 1, 0, 1, 6, NULL, NULL, NULL, 13, N'jpg', NULL, NULL)
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [IsPublic], [PositionInFolder], [MaterialType], [FolderName], [MaterialMD5Encrypt], [PostId], [MIMEType], [DeleteTime], [ImageAvatar]) VALUES (38, N'Brochure8', N'Ảnh hiếu 1', CAST(0x0000ABA4015E707C AS DateTime), N'superuser001', 1, 0, 1, 7, NULL, NULL, NULL, 13, N'jpg', NULL, NULL)
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [IsPublic], [PositionInFolder], [MaterialType], [FolderName], [MaterialMD5Encrypt], [PostId], [MIMEType], [DeleteTime], [ImageAvatar]) VALUES (39, N'Brochure9', N'Ảnh hiếu 1', CAST(0x0000ABA4015E7080 AS DateTime), N'superuser001', 1, 0, 1, 8, NULL, NULL, NULL, 13, N'jpg', NULL, NULL)
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [IsPublic], [PositionInFolder], [MaterialType], [FolderName], [MaterialMD5Encrypt], [PostId], [MIMEType], [DeleteTime], [ImageAvatar]) VALUES (40, N'Brochure10', N'Ảnh hiếu 1', CAST(0x0000ABA4015E7082 AS DateTime), N'superuser001', 1, 0, 1, 9, NULL, NULL, NULL, 13, N'jpg', NULL, NULL)
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [IsPublic], [PositionInFolder], [MaterialType], [FolderName], [MaterialMD5Encrypt], [PostId], [MIMEType], [DeleteTime], [ImageAvatar]) VALUES (41, N'Brochure11', N'Ảnh hiếu 1', CAST(0x0000ABA4015E7085 AS DateTime), N'superuser001', 1, 0, 1, 10, NULL, NULL, NULL, 13, N'jpg', NULL, NULL)
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [IsPublic], [PositionInFolder], [MaterialType], [FolderName], [MaterialMD5Encrypt], [PostId], [MIMEType], [DeleteTime], [ImageAvatar]) VALUES (42, N'Brochure12', N'Ảnh hiếu 1', CAST(0x0000ABA4015E7088 AS DateTime), N'superuser001', 1, 0, 1, 11, NULL, NULL, NULL, 13, N'jpg', NULL, NULL)
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [IsPublic], [PositionInFolder], [MaterialType], [FolderName], [MaterialMD5Encrypt], [PostId], [MIMEType], [DeleteTime], [ImageAvatar]) VALUES (43, N'Brochure13', N'Ảnh hiếu 2', CAST(0x0000ABA4015E708A AS DateTime), N'superuser001', 1, 0, 1, 12, NULL, NULL, NULL, 13, N'png', NULL, NULL)
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [IsPublic], [PositionInFolder], [MaterialType], [FolderName], [MaterialMD5Encrypt], [PostId], [MIMEType], [DeleteTime], [ImageAvatar]) VALUES (44, N'Brochure2', N'Thanh niên chăm học', CAST(0x0000ABA4016C14DD AS DateTime), N'superuser001', 1, 0, 1, 2, NULL, NULL, NULL, 3, N'jpg', NULL, NULL)
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [IsPublic], [PositionInFolder], [MaterialType], [FolderName], [MaterialMD5Encrypt], [PostId], [MIMEType], [DeleteTime], [ImageAvatar]) VALUES (45, N'Video3', N'Video3.mp4', CAST(0x0000ABA500013C41 AS DateTime), N'superuser001', 1, 0, 1, 1, NULL, NULL, NULL, 8, N'mp4', NULL, NULL)
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [IsPublic], [PositionInFolder], [MaterialType], [FolderName], [MaterialMD5Encrypt], [PostId], [MIMEType], [DeleteTime], [ImageAvatar]) VALUES (46, N'Test2', N'Test2.jpg', CAST(0x0000ABA5010F7DEE AS DateTime), N'superuser001', 1, 0, 1, 1, NULL, NULL, NULL, 14, N'jpg', NULL, NULL)
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [IsPublic], [PositionInFolder], [MaterialType], [FolderName], [MaterialMD5Encrypt], [PostId], [MIMEType], [DeleteTime], [ImageAvatar]) VALUES (47, N'Test5', N'Test5.jpg', CAST(0x0000ABA5010F7DFB AS DateTime), N'superuser001', 1, 0, 1, 2, NULL, NULL, NULL, 14, N'jpg', NULL, NULL)
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [IsPublic], [PositionInFolder], [MaterialType], [FolderName], [MaterialMD5Encrypt], [PostId], [MIMEType], [DeleteTime], [ImageAvatar]) VALUES (48, N'Test7', N'Test7.png', CAST(0x0000ABA5010F7DFD AS DateTime), N'superuser001', 1, 0, 1, 3, NULL, NULL, NULL, 14, N'png', NULL, NULL)
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [IsPublic], [PositionInFolder], [MaterialType], [FolderName], [MaterialMD5Encrypt], [PostId], [MIMEType], [DeleteTime], [ImageAvatar]) VALUES (49, N'Brochure11', N'Tết dân gian _ Test', CAST(0x0000ABA5010FFEFE AS DateTime), N'superuser001', 1, 0, 1, 2, NULL, NULL, NULL, 3, N'jpg', NULL, NULL)
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [IsPublic], [PositionInFolder], [MaterialType], [FolderName], [MaterialMD5Encrypt], [PostId], [MIMEType], [DeleteTime], [ImageAvatar]) VALUES (53, N'1', N'1.jpg', CAST(0x0000ABAC014B954A AS DateTime), N'superuser001', 1, 0, 0, 2, NULL, NULL, N'07fe9c64ea99bb8ba760626de0992972', 9, N'jpg', NULL, NULL)
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [IsPublic], [PositionInFolder], [MaterialType], [FolderName], [MaterialMD5Encrypt], [PostId], [MIMEType], [DeleteTime], [ImageAvatar]) VALUES (54, N'1', N'1.jpg', CAST(0x0000ABAD00F991C2 AS DateTime), N'superuser001', 1, 0, 0, 1, N'Post', NULL, N'07fe9c64ea99bb8ba760626de0992972', 15, N'jpg', NULL, NULL)
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [IsPublic], [PositionInFolder], [MaterialType], [FolderName], [MaterialMD5Encrypt], [PostId], [MIMEType], [DeleteTime], [ImageAvatar]) VALUES (55, N'2', N'2.jpg', CAST(0x0000ABAD00F991C7 AS DateTime), N'superuser001', 1, 0, 0, 2, N'Post', NULL, N'702141971f81afb791ed88016bb29c0f', 15, N'jpg', NULL, NULL)
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [IsPublic], [PositionInFolder], [MaterialType], [FolderName], [MaterialMD5Encrypt], [PostId], [MIMEType], [DeleteTime], [ImageAvatar]) VALUES (56, N'3', N'3.jpg', CAST(0x0000ABAD00F991DB AS DateTime), N'superuser001', 1, 0, 0, 3, N'Post', NULL, N'ebe9c9afb60d26c478ceddd65448eee6', 15, N'jpg', NULL, NULL)
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [IsPublic], [PositionInFolder], [MaterialType], [FolderName], [MaterialMD5Encrypt], [PostId], [MIMEType], [DeleteTime], [ImageAvatar]) VALUES (57, N'4', N'4.jpg', CAST(0x0000ABAD00F991E0 AS DateTime), N'superuser001', 1, 0, 0, 4, N'Post', NULL, N'cd4dfaa4b5ff779c9157bd1731113643', 15, N'jpg', NULL, NULL)
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [IsPublic], [PositionInFolder], [MaterialType], [FolderName], [MaterialMD5Encrypt], [PostId], [MIMEType], [DeleteTime], [ImageAvatar]) VALUES (58, N'6', N'6.jpg', CAST(0x0000ABAD00F991E3 AS DateTime), N'superuser001', 1, 0, 0, 5, N'Post', NULL, N'2b0e159d846d4f99d0f91ab507cf6c3f', 15, N'jpg', NULL, NULL)
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [IsPublic], [PositionInFolder], [MaterialType], [FolderName], [MaterialMD5Encrypt], [PostId], [MIMEType], [DeleteTime], [ImageAvatar]) VALUES (59, N'7', N'7.jpg', CAST(0x0000ABAD00F991E6 AS DateTime), N'superuser001', 1, 0, 0, 6, N'Post', NULL, N'b81ca633f070fa12a14e3a236eda78bf', 15, N'jpg', NULL, NULL)
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [IsPublic], [PositionInFolder], [MaterialType], [FolderName], [MaterialMD5Encrypt], [PostId], [MIMEType], [DeleteTime], [ImageAvatar]) VALUES (60, N'1 (1)', N'1 (1).pdf', CAST(0x0000ABAD010A0FF3 AS DateTime), N'superuser001', 1, 0, 0, 7, N'Post', N'ABC', N'd016934133e9104c85ebed0311386296', 15, N'pdf', NULL, N'1 (1).jpg')
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [IsPublic], [PositionInFolder], [MaterialType], [FolderName], [MaterialMD5Encrypt], [PostId], [MIMEType], [DeleteTime], [ImageAvatar]) VALUES (61, N'1 (2)', N'1 (2).pdf', CAST(0x0000ABAD010A1F05 AS DateTime), N'superuser001', 1, 0, 0, 8, N'Post', N'ABC', N'd016934133e9104c85ebed0311386296', 15, N'pdf', NULL, N'1 (2).png')
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [IsPublic], [PositionInFolder], [MaterialType], [FolderName], [MaterialMD5Encrypt], [PostId], [MIMEType], [DeleteTime], [ImageAvatar]) VALUES (62, N'pdf', N'pdf.jpg', CAST(0x0000ABAD0173B7A0 AS DateTime), N'superuser001', 0, 0, 0, 2, N'Post', N'Chủ đề mới FPT', N'ee7823c01298ecafdb25e4e428791991', 16, N'jpg', NULL, NULL)
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [IsPublic], [PositionInFolder], [MaterialType], [FolderName], [MaterialMD5Encrypt], [PostId], [MIMEType], [DeleteTime], [ImageAvatar]) VALUES (63, N'1 (1)', N'Bản tiếng anh', CAST(0x0000ABAD0173CB62 AS DateTime), N'superuser001', 0, 0, 0, 3, N'Post', N'Chủ đề mới FPT', N'd016934133e9104c85ebed0311386296', 16, N'pdf', NULL, N'Brochure13.png')
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [IsPublic], [PositionInFolder], [MaterialType], [FolderName], [MaterialMD5Encrypt], [PostId], [MIMEType], [DeleteTime], [ImageAvatar]) VALUES (64, N'PMG201c-SamplePE-Guide', N'Bản tiếng Việt 2021', CAST(0x0000ABAD0174DB4F AS DateTime), N'superuser001', 1, 1, 0, 9, N'Post', N'ABC', N'78c93a07ff19c461d3a3c5d10cea5878', 15, N'pdf', NULL, N'TVQJGQCNAJWXVTYPAPRDJXTGBGTMLLRQ.jpg')
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [IsPublic], [PositionInFolder], [MaterialType], [FolderName], [MaterialMD5Encrypt], [PostId], [MIMEType], [DeleteTime], [ImageAvatar]) VALUES (65, N'Logo-Jetking', N'Logo-Jetking.ai', CAST(0x0000ABAD01759F46 AS DateTime), N'superuser001', 1, 0, 0, 1, N'Logo', NULL, N'548366a6e5298a5be03b4c9a7047ad24', 17, N'ai', NULL, NULL)
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [IsPublic], [PositionInFolder], [MaterialType], [FolderName], [MaterialMD5Encrypt], [PostId], [MIMEType], [DeleteTime], [ImageAvatar]) VALUES (66, N'Logo-Jetking', N'Logo-Jetking.png', CAST(0x0000ABAD01759FB2 AS DateTime), N'superuser001', 0, 0, 0, 2, N'Logo', NULL, N'82d0a483af238a8ede86f76f8970891f', 17, N'png', NULL, NULL)
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [IsPublic], [PositionInFolder], [MaterialType], [FolderName], [MaterialMD5Encrypt], [PostId], [MIMEType], [DeleteTime], [ImageAvatar]) VALUES (67, N'Logo-Jetking-view', N'Logo-Jetking-view.pdf', CAST(0x0000ABAD01759FB7 AS DateTime), N'superuser001', 0, 0, 0, 3, N'Logo', NULL, N'c64c8856345b2853a023939252e9f7f4', 17, N'pdf', NULL, NULL)
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [IsPublic], [PositionInFolder], [MaterialType], [FolderName], [MaterialMD5Encrypt], [PostId], [MIMEType], [DeleteTime], [ImageAvatar]) VALUES (68, N'GuidePE_DuongTB', N'GuidePE_DuongTB.pdf', CAST(0x0000ABAD01824901 AS DateTime), N'superuser001', 0, 0, 0, 2, N'Post', N'Brochure tổ chức giáo dục FPT', N'a1b69a28381240499194b96c951f0a79', 18, N'pdf', NULL, N'OORUOHQDXDDWOTJRPYTBFYMNEFTNFNFD.jpg')
INSERT [dbo].[Material] ([MaterialId], [MaterialName], [MaterialDisplayName], [LaunchedDate], [CreateBy], [IsDelete], [IsHilde], [IsPublic], [PositionInFolder], [MaterialType], [FolderName], [MaterialMD5Encrypt], [PostId], [MIMEType], [DeleteTime], [ImageAvatar]) VALUES (69, N'8VideoMP4', N'8VideoMP4.mp4', CAST(0x0000ABAD018260CB AS DateTime), N'superuser001', 0, 0, 0, 3, N'Post', N'Brochure tổ chức giáo dục FPT', N'c2533ab73bb1fefea46953187bd7dcdf', 18, N'mp4', NULL, NULL)
SET IDENTITY_INSERT [dbo].[Material] OFF
SET IDENTITY_INSERT [dbo].[Post] ON 

INSERT [dbo].[Post] ([PostId], [PostTitle], [PostEngTitle], [PostHashRealFolder], [LaunchedDate], [CreateBy], [IsDelete], [IsHide], [IsPublic], [IsInLogoPost], [Position], [PRSystemId], [DeleteTime]) VALUES (0, N'HỆ THỐNG LOGO TỔ CHỨC GIÁO DỤC Tiểu học', N'FPT Education Logo Primary School', NULL, CAST(0x0000AB9E00972174 AS DateTime), N'superuser001', 0, 0, 1, 0, 0, 0, NULL)
INSERT [dbo].[Post] ([PostId], [PostTitle], [PostEngTitle], [PostHashRealFolder], [LaunchedDate], [CreateBy], [IsDelete], [IsHide], [IsPublic], [IsInLogoPost], [Position], [PRSystemId], [DeleteTime]) VALUES (1, N'SỔ TAY THƯƠNG HIỆU TỔ CHỨC GIÁO DỤC FPT', NULL, N'LEBTRJULSPEISTNFNOEHWKHVPRINTAQARSSFXSECDSEKRNBDWWJDHCRAVFDABGRR', CAST(0x0000AB9E00972174 AS DateTime), N'superuser001', 1, 0, 1, 0, 4, 0, NULL)
INSERT [dbo].[Post] ([PostId], [PostTitle], [PostEngTitle], [PostHashRealFolder], [LaunchedDate], [CreateBy], [IsDelete], [IsHide], [IsPublic], [IsInLogoPost], [Position], [PRSystemId], [DeleteTime]) VALUES (2, N'BẢN TRÌNH CHIẾU GIỚI THIỆU TỔ CHỨC GIÁO DỤC FPT', N'FPT Education Presentation Presenttation Power Point', N'XFFYIURAKQYFNFXJRWMUYQDHAMMAQOMKYIRVYSRQOJPAPAMOXRCGCSMHBWXUIRJV', CAST(0x0000AB9E00972174 AS DateTime), N'superuser001', 1, 0, 1, 0, 2, 0, NULL)
INSERT [dbo].[Post] ([PostId], [PostTitle], [PostEngTitle], [PostHashRealFolder], [LaunchedDate], [CreateBy], [IsDelete], [IsHide], [IsPublic], [IsInLogoPost], [Position], [PRSystemId], [DeleteTime]) VALUES (3, N'BROCHURE TỔ CHỨC GIÁO DỤC FPT', N'FPT Education Brochure', N'WVLPDLINDYOYAXQPOEWFGGAAVNXGXNWRFRIORJVSOVRMUBBUQGTKBKNPVLTPMCOP', CAST(0x0000AB9E00972174 AS DateTime), N'superuser001', 1, 0, 1, 0, 1, 0, NULL)
INSERT [dbo].[Post] ([PostId], [PostTitle], [PostEngTitle], [PostHashRealFolder], [LaunchedDate], [CreateBy], [IsDelete], [IsHide], [IsPublic], [IsInLogoPost], [Position], [PRSystemId], [DeleteTime]) VALUES (4, N'FPT Education', N'', N'DONHMNTTNGODKYSOKRLWOGIOSEYTHHGGUDXJTNOFAHMOGOWIXYBJVEVVFXNHOALG', CAST(0x0000AB9F01605738 AS DateTime), N'superuser001', 0, 0, 1, 1, 1, 1, NULL)
INSERT [dbo].[Post] ([PostId], [PostTitle], [PostEngTitle], [PostHashRealFolder], [LaunchedDate], [CreateBy], [IsDelete], [IsHide], [IsPublic], [IsInLogoPost], [Position], [PRSystemId], [DeleteTime]) VALUES (5, N'FPT University', N'', N'UTDCWYUXUWATWVKVMFGKVXLLOIVYMTOBSONEXCQTYRVVEARWTEXAGEWWIRNODULB', CAST(0x0000AB9F01605738 AS DateTime), N'superuser001', 0, 0, 1, 1, 2, 1, NULL)
INSERT [dbo].[Post] ([PostId], [PostTitle], [PostEngTitle], [PostHashRealFolder], [LaunchedDate], [CreateBy], [IsDelete], [IsHide], [IsPublic], [IsInLogoPost], [Position], [PRSystemId], [DeleteTime]) VALUES (6, N'Nanoversity', N'', N'JSDTCBJXPHVXNAEJRXWONRUJWXLBFGUVUBDUIJIWFNLYUVOIFECIJTEQXSVEOIRI', CAST(0x0000AB9F01605738 AS DateTime), N'superuser001', 0, 0, 1, 1, 3, 1, NULL)
INSERT [dbo].[Post] ([PostId], [PostTitle], [PostEngTitle], [PostHashRealFolder], [LaunchedDate], [CreateBy], [IsDelete], [IsHide], [IsPublic], [IsInLogoPost], [Position], [PRSystemId], [DeleteTime]) VALUES (7, N'Alliance', N'', N'GRQHFGIHURMIYCXIDVQMQDQCQUDWWHYFCGEHPYNJBEGJKLWCWNJTAXGDBNPKCKJM', CAST(0x0000AB9F01605738 AS DateTime), N'superuser001', 0, 0, 1, 1, 2, 1, NULL)
INSERT [dbo].[Post] ([PostId], [PostTitle], [PostEngTitle], [PostHashRealFolder], [LaunchedDate], [CreateBy], [IsDelete], [IsHide], [IsPublic], [IsInLogoPost], [Position], [PRSystemId], [DeleteTime]) VALUES (8, N'Ảnh về đại học FPT', N'Image about FPTU', N'VOQAMSBHOUETMODIUVCLYWQSQYRHGJQJTOOVHUNAPWSJLDKADAXUDPFYXXINATBE', CAST(0x0000ABA2015CB9DD AS DateTime), N'superuser001', 1, 0, 1, 0, 3, 0, NULL)
INSERT [dbo].[Post] ([PostId], [PostTitle], [PostEngTitle], [PostHashRealFolder], [LaunchedDate], [CreateBy], [IsDelete], [IsHide], [IsPublic], [IsInLogoPost], [Position], [PRSystemId], [DeleteTime]) VALUES (9, N'AA', N'AA', N'TSYFLMSTHXKYAEWNAQAUGQRKVDMPCKAYVQHBTCUXXUGLIYVVNYIENEFCBNJIACQV', CAST(0x0000ABA301810DCF AS DateTime), N'superuser001', 1, 0, 1, 0, 5, 0, NULL)
INSERT [dbo].[Post] ([PostId], [PostTitle], [PostEngTitle], [PostHashRealFolder], [LaunchedDate], [CreateBy], [IsDelete], [IsHide], [IsPublic], [IsInLogoPost], [Position], [PRSystemId], [DeleteTime]) VALUES (10, N'Ảnh về hệ thống giáo dục FPT', N'Image about FPT Education', N'PUVXJQPUNEBLATYTWIKWUQWOFROPKSRCVGHDWGXOKWGMMAPYWGHLALCYWGRRCYJT', CAST(0x0000ABA400EF969D AS DateTime), N'superuser001', 1, 0, 1, 0, 6, 0, NULL)
INSERT [dbo].[Post] ([PostId], [PostTitle], [PostEngTitle], [PostHashRealFolder], [LaunchedDate], [CreateBy], [IsDelete], [IsHide], [IsPublic], [IsInLogoPost], [Position], [PRSystemId], [DeleteTime]) VALUES (11, N'Ảnh do sinh viên chụp', N'Image from student', N'JMKUQEKEVPQCAPITEIOTBTAVDHXCLNVORMMFUFFDPAOKDVOFMJCQXUVOMORIGHRH', CAST(0x0000ABA40101A1DA AS DateTime), N'superuser001', 1, 0, 1, 0, 7, 0, NULL)
INSERT [dbo].[Post] ([PostId], [PostTitle], [PostEngTitle], [PostHashRealFolder], [LaunchedDate], [CreateBy], [IsDelete], [IsHide], [IsPublic], [IsInLogoPost], [Position], [PRSystemId], [DeleteTime]) VALUES (12, N'Jetking', N'', N'TANBLKKTHSBRAEMPWPEYUIUDBOXHAERWXCXPVGXVJWXXBELDDKWPJFVLFJAVLDTD', CAST(0x0000ABA4015C6BA3 AS DateTime), N'superuser001', 0, 0, 1, 1, 4, 0, NULL)
INSERT [dbo].[Post] ([PostId], [PostTitle], [PostEngTitle], [PostHashRealFolder], [LaunchedDate], [CreateBy], [IsDelete], [IsHide], [IsPublic], [IsInLogoPost], [Position], [PRSystemId], [DeleteTime]) VALUES (13, N'Ảnh do hiếu đẹp trai chụp', N'Bisu ngok ngeck', N'WWYUBSRQOGAVTVPVVABSNTGCOVLFSHFMBPEFJQQNVPAHKAWPECFBVTCCPWFEHMXG', CAST(0x0000ABA4015E701F AS DateTime), N'superuser001', 1, 0, 1, 0, 8, 0, NULL)
INSERT [dbo].[Post] ([PostId], [PostTitle], [PostEngTitle], [PostHashRealFolder], [LaunchedDate], [CreateBy], [IsDelete], [IsHide], [IsPublic], [IsInLogoPost], [Position], [PRSystemId], [DeleteTime]) VALUES (14, N'Bài viết 1', N'Post 1', N'HAFCTHGYFAUDSMNDFUEEMCAXQPRKIEAYIPQFQSXFVYJYHFCGYSUJETDEYHKEOVPA', CAST(0x0000ABA5010F7DB2 AS DateTime), N'superuser001', 1, 0, 1, 0, 9, 0, NULL)
INSERT [dbo].[Post] ([PostId], [PostTitle], [PostEngTitle], [PostHashRealFolder], [LaunchedDate], [CreateBy], [IsDelete], [IsHide], [IsPublic], [IsInLogoPost], [Position], [PRSystemId], [DeleteTime]) VALUES (15, N'ABC', N'ABC E', N'ABC', CAST(0x0000ABAD00F99182 AS DateTime), N'superuser001', 1, 0, 1, 0, 10, 0, NULL)
INSERT [dbo].[Post] ([PostId], [PostTitle], [PostEngTitle], [PostHashRealFolder], [LaunchedDate], [CreateBy], [IsDelete], [IsHide], [IsPublic], [IsInLogoPost], [Position], [PRSystemId], [DeleteTime]) VALUES (16, N'Chủ đề mới FPT', N'New Title FPT', N'Chủ đề mới FPT', CAST(0x0000ABAD01739AA9 AS DateTime), N'superuser001', 0, 0, 1, 0, 11, 0, NULL)
INSERT [dbo].[Post] ([PostId], [PostTitle], [PostEngTitle], [PostHashRealFolder], [LaunchedDate], [CreateBy], [IsDelete], [IsHide], [IsPublic], [IsInLogoPost], [Position], [PRSystemId], [DeleteTime]) VALUES (17, N'Jetking', NULL, N'Jetking', CAST(0x0000ABAD01759F40 AS DateTime), N'superuser001', 0, 0, 1, 1, 5, 0, NULL)
INSERT [dbo].[Post] ([PostId], [PostTitle], [PostEngTitle], [PostHashRealFolder], [LaunchedDate], [CreateBy], [IsDelete], [IsHide], [IsPublic], [IsInLogoPost], [Position], [PRSystemId], [DeleteTime]) VALUES (18, N'Brochure tổ chức giáo dục FPT', N'', N'Brochure tổ chức giáo dục FPT', CAST(0x0000ABAD01822A04 AS DateTime), N'superuser001', 0, 0, 1, 0, 12, 0, NULL)
SET IDENTITY_INSERT [dbo].[Post] OFF
SET IDENTITY_INSERT [dbo].[PRSystem] ON 

INSERT [dbo].[PRSystem] ([PRSystemId], [PRSystemName], [PRSystemVName], [PRSystemIndependent], [PRIsDelete]) VALUES (0, N'FEHO', NULL, 1, 0)
INSERT [dbo].[PRSystem] ([PRSystemId], [PRSystemName], [PRSystemVName], [PRSystemIndependent], [PRIsDelete]) VALUES (1, N'FPT University', NULL, 1, 0)
INSERT [dbo].[PRSystem] ([PRSystemId], [PRSystemName], [PRSystemVName], [PRSystemIndependent], [PRIsDelete]) VALUES (2, N'FPT APTECH', NULL, 1, 0)
INSERT [dbo].[PRSystem] ([PRSystemId], [PRSystemName], [PRSystemVName], [PRSystemIndependent], [PRIsDelete]) VALUES (3, N'FPT Poly', NULL, 1, 0)
INSERT [dbo].[PRSystem] ([PRSystemId], [PRSystemName], [PRSystemVName], [PRSystemIndependent], [PRIsDelete]) VALUES (4, N'Jetking', N'Jetking', 0, 0)
SET IDENTITY_INSERT [dbo].[PRSystem] OFF
SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([RoleId], [RoleName]) VALUES (0, N'Su')
INSERT [dbo].[Role] ([RoleId], [RoleName]) VALUES (1, N'Admin')
INSERT [dbo].[Role] ([RoleId], [RoleName]) VALUES (2, N'SysAdmin')
INSERT [dbo].[Role] ([RoleId], [RoleName]) VALUES (3, N'Editor')
INSERT [dbo].[Role] ([RoleId], [RoleName]) VALUES (4, N'No Services')
SET IDENTITY_INSERT [dbo].[Role] OFF
INSERT [dbo].[Slider] ([SliderId], [SliderName], [IsDelete]) VALUES (1, N'Cover-01.jpg', 0)
INSERT [dbo].[Slider] ([SliderId], [SliderName], [IsDelete]) VALUES (2, N'header.jpg', 0)
INSERT [dbo].[Slider] ([SliderId], [SliderName], [IsDelete]) VALUES (3, N'Hinh5.jpg', 0)
INSERT [dbo].[Slider] ([SliderId], [SliderName], [IsDelete]) VALUES (4, N'Slide4.jpg', 0)
INSERT [dbo].[Slider] ([SliderId], [SliderName], [IsDelete]) VALUES (5, N'TestSlide1.jpg', 0)
INSERT [dbo].[User] ([UsernameId], [Password], [Email], [FullName], [IsActive], [RoleId], [PRSystemId]) VALUES (N'acctest001', N'AA/DYVIORgl+uCV6y3yA53pE5qDSOF0iZamWxmu/v7UEwmkJNW6ZLojX2QZCFmlXwA==', N'acctest001@fpt.edu.vn', N'acctest001', 1, 3, 0)
INSERT [dbo].[User] ([UsernameId], [Password], [Email], [FullName], [IsActive], [RoleId], [PRSystemId]) VALUES (N'acctest0010', N'AA/DYVIORgl+uCV6y3yA53pE5qDSOF0iZamWxmu/v7UEwmkJNW6ZLojX2QZCFmlXwA==', N'acctest0010@fpt.edu.vn', N'acctest0010', 1, 3, 0)
INSERT [dbo].[User] ([UsernameId], [Password], [Email], [FullName], [IsActive], [RoleId], [PRSystemId]) VALUES (N'acctest002', N'AA/DYVIORgl+uCV6y3yA53pE5qDSOF0iZamWxmu/v7UEwmkJNW6ZLojX2QZCFmlXwA==', N'acctest002@fpt.edu.vn', N'acctest002', 1, 3, 0)
INSERT [dbo].[User] ([UsernameId], [Password], [Email], [FullName], [IsActive], [RoleId], [PRSystemId]) VALUES (N'acctest003', N'AA/DYVIORgl+uCV6y3yA53pE5qDSOF0iZamWxmu/v7UEwmkJNW6ZLojX2QZCFmlXwA==', N'acctest003@fpt.edu.vn', N'acctest003', 1, 3, 0)
INSERT [dbo].[User] ([UsernameId], [Password], [Email], [FullName], [IsActive], [RoleId], [PRSystemId]) VALUES (N'acctest004', N'AA/DYVIORgl+uCV6y3yA53pE5qDSOF0iZamWxmu/v7UEwmkJNW6ZLojX2QZCFmlXwA==', N'acctest004@fpt.edu.vn', N'acctest004', 1, 3, 0)
INSERT [dbo].[User] ([UsernameId], [Password], [Email], [FullName], [IsActive], [RoleId], [PRSystemId]) VALUES (N'acctest005', N'AA/DYVIORgl+uCV6y3yA53pE5qDSOF0iZamWxmu/v7UEwmkJNW6ZLojX2QZCFmlXwA==', N'acctest005@fpt.edu.vn', N'acctest005', 1, 3, 0)
INSERT [dbo].[User] ([UsernameId], [Password], [Email], [FullName], [IsActive], [RoleId], [PRSystemId]) VALUES (N'acctest006', N'AA/DYVIORgl+uCV6y3yA53pE5qDSOF0iZamWxmu/v7UEwmkJNW6ZLojX2QZCFmlXwA==', N'acctest006@fpt.edu.vn', N'acctest006', 1, 3, 0)
INSERT [dbo].[User] ([UsernameId], [Password], [Email], [FullName], [IsActive], [RoleId], [PRSystemId]) VALUES (N'acctest007', N'AA/DYVIORgl+uCV6y3yA53pE5qDSOF0iZamWxmu/v7UEwmkJNW6ZLojX2QZCFmlXwA==', N'acctest007@fpt.edu.vn', N'acctest007', 1, 3, 0)
INSERT [dbo].[User] ([UsernameId], [Password], [Email], [FullName], [IsActive], [RoleId], [PRSystemId]) VALUES (N'acctest008', N'AA/DYVIORgl+uCV6y3yA53pE5qDSOF0iZamWxmu/v7UEwmkJNW6ZLojX2QZCFmlXwA==', N'acctest008@fpt.edu.vn', N'acctest008', 1, 3, 0)
INSERT [dbo].[User] ([UsernameId], [Password], [Email], [FullName], [IsActive], [RoleId], [PRSystemId]) VALUES (N'acctest009', N'AA/DYVIORgl+uCV6y3yA53pE5qDSOF0iZamWxmu/v7UEwmkJNW6ZLojX2QZCFmlXwA==', N'acctest009@fpt.edu.vn', N'acctest009', 1, 3, 0)
INSERT [dbo].[User] ([UsernameId], [Password], [Email], [FullName], [IsActive], [RoleId], [PRSystemId]) VALUES (N'hieuvdse05128', N'AA/DYVIORgl+uCV6y3yA53pE5qDSOF0iZamWxmu/v7UEwmkJNW6ZLojX2QZCFmlXwA==', N'hieuvdse05128@fpt.edu.vn', N'K11-FUG HN Vu Duc Hieu', 1, 1, 0)
INSERT [dbo].[User] ([UsernameId], [Password], [Email], [FullName], [IsActive], [RoleId], [PRSystemId]) VALUES (N'superuser001', N'AA0fisGSt5QDZNGWKR8TzVcnuwyeubq6RGlrCMXAcf1ND7cwa1Z3NY+wDVNIUvE50Q==', N'supperuser001@fpt.edu.vn', N'Supper User', 1, 0, 0)
ALTER TABLE [dbo].[Material] ADD  DEFAULT ((0)) FOR [IsDelete]
GO
ALTER TABLE [dbo].[Material] ADD  DEFAULT ((0)) FOR [IsHilde]
GO
ALTER TABLE [dbo].[Material] ADD  DEFAULT ((1)) FOR [IsPublic]
GO
ALTER TABLE [dbo].[Post] ADD  DEFAULT ((0)) FOR [IsDelete]
GO
ALTER TABLE [dbo].[Post] ADD  DEFAULT ((0)) FOR [IsHide]
GO
ALTER TABLE [dbo].[Post] ADD  DEFAULT ((1)) FOR [IsPublic]
GO
ALTER TABLE [dbo].[PRSystem] ADD  DEFAULT ((0)) FOR [PRIsDelete]
GO
ALTER TABLE [dbo].[Slider] ADD  DEFAULT ((0)) FOR [IsDelete]
GO
ALTER TABLE [dbo].[User] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[User] ADD  DEFAULT ((4)) FOR [RoleId]
GO
ALTER TABLE [dbo].[FileInDB]  WITH CHECK ADD  CONSTRAINT [FK_FILE_FOLDER] FOREIGN KEY([FolderId])
REFERENCES [dbo].[Folder] ([FolderId])
GO
ALTER TABLE [dbo].[FileInDB] CHECK CONSTRAINT [FK_FILE_FOLDER]
GO
ALTER TABLE [dbo].[FileInDB]  WITH CHECK ADD  CONSTRAINT [FK_FILE_USER] FOREIGN KEY([LaunchedBy])
REFERENCES [dbo].[User] ([UsernameId])
GO
ALTER TABLE [dbo].[FileInDB] CHECK CONSTRAINT [FK_FILE_USER]
GO
ALTER TABLE [dbo].[FileInDB]  WITH CHECK ADD  CONSTRAINT [FK_FILE_USER_LASTEDIT] FOREIGN KEY([LastEditBy])
REFERENCES [dbo].[User] ([UsernameId])
GO
ALTER TABLE [dbo].[FileInDB] CHECK CONSTRAINT [FK_FILE_USER_LASTEDIT]
GO
ALTER TABLE [dbo].[Folder]  WITH CHECK ADD  CONSTRAINT [FK_F_F] FOREIGN KEY([ParrentId])
REFERENCES [dbo].[Folder] ([FolderId])
GO
ALTER TABLE [dbo].[Folder] CHECK CONSTRAINT [FK_F_F]
GO
ALTER TABLE [dbo].[Folder]  WITH CHECK ADD  CONSTRAINT [FK_F_P] FOREIGN KEY([PRSystemId])
REFERENCES [dbo].[PRSystem] ([PRSystemId])
GO
ALTER TABLE [dbo].[Folder] CHECK CONSTRAINT [FK_F_P]
GO
ALTER TABLE [dbo].[Folder]  WITH CHECK ADD  CONSTRAINT [FK_F_U] FOREIGN KEY([CreateBy])
REFERENCES [dbo].[User] ([UsernameId])
GO
ALTER TABLE [dbo].[Folder] CHECK CONSTRAINT [FK_F_U]
GO
ALTER TABLE [dbo].[LogAction]  WITH CHECK ADD  CONSTRAINT [FK_LA_LAT] FOREIGN KEY([LogActionTypeId])
REFERENCES [dbo].[LogActionType] ([LogActionTypeId])
GO
ALTER TABLE [dbo].[LogAction] CHECK CONSTRAINT [FK_LA_LAT]
GO
ALTER TABLE [dbo].[LogoAvartarImage]  WITH CHECK ADD  CONSTRAINT [FK_LG_M] FOREIGN KEY([MaterialId])
REFERENCES [dbo].[Material] ([MaterialId])
GO
ALTER TABLE [dbo].[LogoAvartarImage] CHECK CONSTRAINT [FK_LG_M]
GO
ALTER TABLE [dbo].[LogoAvartarImage]  WITH CHECK ADD  CONSTRAINT [FK_LG_P] FOREIGN KEY([PostId])
REFERENCES [dbo].[Post] ([PostId])
GO
ALTER TABLE [dbo].[LogoAvartarImage] CHECK CONSTRAINT [FK_LG_P]
GO
ALTER TABLE [dbo].[LogoAvartarImage]  WITH CHECK ADD  CONSTRAINT [FK_LG_U] FOREIGN KEY([LastChangeBy])
REFERENCES [dbo].[User] ([UsernameId])
GO
ALTER TABLE [dbo].[LogoAvartarImage] CHECK CONSTRAINT [FK_LG_U]
GO
ALTER TABLE [dbo].[Material]  WITH CHECK ADD  CONSTRAINT [FK_M_F] FOREIGN KEY([PostId])
REFERENCES [dbo].[Post] ([PostId])
GO
ALTER TABLE [dbo].[Material] CHECK CONSTRAINT [FK_M_F]
GO
ALTER TABLE [dbo].[Material]  WITH CHECK ADD  CONSTRAINT [FK_M_U] FOREIGN KEY([CreateBy])
REFERENCES [dbo].[User] ([UsernameId])
GO
ALTER TABLE [dbo].[Material] CHECK CONSTRAINT [FK_M_U]
GO
ALTER TABLE [dbo].[Post]  WITH CHECK ADD  CONSTRAINT [FK_P_PR] FOREIGN KEY([PRSystemId])
REFERENCES [dbo].[PRSystem] ([PRSystemId])
GO
ALTER TABLE [dbo].[Post] CHECK CONSTRAINT [FK_P_PR]
GO
ALTER TABLE [dbo].[Post]  WITH CHECK ADD  CONSTRAINT [FK_P_U] FOREIGN KEY([CreateBy])
REFERENCES [dbo].[User] ([UsernameId])
GO
ALTER TABLE [dbo].[Post] CHECK CONSTRAINT [FK_P_U]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_PRSystem] FOREIGN KEY([PRSystemId])
REFERENCES [dbo].[PRSystem] ([PRSystemId])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_PRSystem]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_Role] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Role] ([RoleId])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_Role]
GO
USE [master]
GO
ALTER DATABASE [PRMMM] SET  READ_WRITE 
GO
