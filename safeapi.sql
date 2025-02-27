USE [master]
GO
/****** Object:  Database [safeapi]    Script Date: 14-01-2025 13:15:03 ******/
CREATE DATABASE [safeapi]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'safeapi', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\safeapi.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'safeapi_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\safeapi_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [safeapi] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [safeapi].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [safeapi] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [safeapi] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [safeapi] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [safeapi] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [safeapi] SET ARITHABORT OFF 
GO
ALTER DATABASE [safeapi] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [safeapi] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [safeapi] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [safeapi] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [safeapi] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [safeapi] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [safeapi] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [safeapi] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [safeapi] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [safeapi] SET  DISABLE_BROKER 
GO
ALTER DATABASE [safeapi] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [safeapi] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [safeapi] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [safeapi] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [safeapi] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [safeapi] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [safeapi] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [safeapi] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [safeapi] SET  MULTI_USER 
GO
ALTER DATABASE [safeapi] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [safeapi] SET DB_CHAINING OFF 
GO
ALTER DATABASE [safeapi] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [safeapi] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [safeapi] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [safeapi] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [safeapi] SET QUERY_STORE = OFF
GO
USE [safeapi]
GO
/****** Object:  Table [dbo].[failed_jobs]    Script Date: 14-01-2025 13:15:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[failed_jobs](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[uuid] [nvarchar](255) NOT NULL,
	[connection] [nvarchar](max) NOT NULL,
	[queue] [nvarchar](max) NOT NULL,
	[payload] [nvarchar](max) NOT NULL,
	[exception] [nvarchar](max) NOT NULL,
	[failed_at] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[migrations]    Script Date: 14-01-2025 13:15:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[migrations](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[migration] [nvarchar](255) NOT NULL,
	[batch] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[password_resets]    Script Date: 14-01-2025 13:15:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[password_resets](
	[email] [nvarchar](255) NOT NULL,
	[token] [nvarchar](255) NOT NULL,
	[created_at] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[personal_access_tokens]    Script Date: 14-01-2025 13:15:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[personal_access_tokens](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[tokenable_type] [nvarchar](255) NOT NULL,
	[tokenable_id] [bigint] NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[token] [nvarchar](64) NOT NULL,
	[abilities] [nvarchar](max) NULL,
	[last_used_at] [datetime] NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users]    Script Date: 14-01-2025 13:15:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[email] [nvarchar](255) NOT NULL,
	[password] [nvarchar](255) NOT NULL,
	[estado] [nvarchar](255) NOT NULL,
	[rol] [nvarchar](255) NOT NULL,
	[ultima_conexion] [datetime] NULL,
	[telefono] [nvarchar](255) NULL,
	[email_verified_at] [datetime] NULL,
	[remember_token] [nvarchar](100) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
	[deleted_at] [datetime] NULL,
	[admin] [int] NOT NULL,
	[anexo] [nvarchar](8) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [failed_jobs_uuid_unique]    Script Date: 14-01-2025 13:15:04 ******/
CREATE UNIQUE NONCLUSTERED INDEX [failed_jobs_uuid_unique] ON [dbo].[failed_jobs]
(
	[uuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [password_resets_email_index]    Script Date: 14-01-2025 13:15:04 ******/
CREATE NONCLUSTERED INDEX [password_resets_email_index] ON [dbo].[password_resets]
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [personal_access_tokens_token_unique]    Script Date: 14-01-2025 13:15:04 ******/
CREATE UNIQUE NONCLUSTERED INDEX [personal_access_tokens_token_unique] ON [dbo].[personal_access_tokens]
(
	[token] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [personal_access_tokens_tokenable_type_tokenable_id_index]    Script Date: 14-01-2025 13:15:04 ******/
CREATE NONCLUSTERED INDEX [personal_access_tokens_tokenable_type_tokenable_id_index] ON [dbo].[personal_access_tokens]
(
	[tokenable_type] ASC,
	[tokenable_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [users_email_unique]    Script Date: 14-01-2025 13:15:04 ******/
CREATE UNIQUE NONCLUSTERED INDEX [users_email_unique] ON [dbo].[users]
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[failed_jobs] ADD  DEFAULT (getdate()) FOR [failed_at]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT ('activo') FOR [estado]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT ('usuario') FOR [rol]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT ('0') FOR [admin]
GO
ALTER TABLE [dbo].[users]  WITH CHECK ADD CHECK  (([estado]=N'inactivo' OR [estado]=N'activo'))
GO
USE [master]
GO
ALTER DATABASE [safeapi] SET  READ_WRITE 
GO
