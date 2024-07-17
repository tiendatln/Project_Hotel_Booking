USE [master]
GO
/****** Object:  Database [Room_Booking_website]    Script Date: 7/17/2024 2:21:05 PM ******/
CREATE DATABASE [Room_Booking_website]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Room_Booking_website', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.DAT_LE\MSSQL\DATA\Room_Booking_website.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Room_Booking_website_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.DAT_LE\MSSQL\DATA\Room_Booking_website_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Room_Booking_website] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Room_Booking_website].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Room_Booking_website] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Room_Booking_website] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Room_Booking_website] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Room_Booking_website] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Room_Booking_website] SET ARITHABORT OFF 
GO
ALTER DATABASE [Room_Booking_website] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Room_Booking_website] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Room_Booking_website] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Room_Booking_website] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Room_Booking_website] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Room_Booking_website] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Room_Booking_website] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Room_Booking_website] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Room_Booking_website] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Room_Booking_website] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Room_Booking_website] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Room_Booking_website] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Room_Booking_website] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Room_Booking_website] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Room_Booking_website] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Room_Booking_website] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Room_Booking_website] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Room_Booking_website] SET RECOVERY FULL 
GO
ALTER DATABASE [Room_Booking_website] SET  MULTI_USER 
GO
ALTER DATABASE [Room_Booking_website] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Room_Booking_website] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Room_Booking_website] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Room_Booking_website] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Room_Booking_website] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Room_Booking_website] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Room_Booking_website', N'ON'
GO
ALTER DATABASE [Room_Booking_website] SET QUERY_STORE = ON
GO
ALTER DATABASE [Room_Booking_website] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Room_Booking_website]
GO
/****** Object:  Table [dbo].[Account]    Script Date: 7/17/2024 2:21:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[username] [nvarchar](50) NOT NULL,
	[password] [nvarchar](32) NULL,
	[is_owner] [bit] NULL,
	[is_manager] [bit] NULL,
	[is_admin] [bit] NULL,
	[ban_status] [bit] NULL,
	[report_count] [int] NULL,
	[email] [varchar](100) NULL,
	[name] [nvarchar](50) NULL,
	[age] [int] NULL,
	[phone] [varchar](10) NULL,
	[id_number] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Feedback]    Script Date: 7/17/2024 2:21:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Feedback](
	[feedback_id] [int] IDENTITY(1,1) NOT NULL,
	[comment] [nvarchar](200) NULL,
	[username] [nvarchar](50) NULL,
	[hotel_id] [int] NULL,
	[room_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[feedback_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Hotel]    Script Date: 7/17/2024 2:21:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Hotel](
	[hotel_id] [int] IDENTITY(1,1) NOT NULL,
	[hotel_name] [nvarchar](50) NULL,
	[hotel_address] [nvarchar](300) NULL,
	[hotel_img] [varchar](100) NULL,
	[hotel_description] [nvarchar](200) NULL,
	[username] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[hotel_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reservation]    Script Date: 7/17/2024 2:21:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reservation](
	[re_id] [int] IDENTITY(1,1) NOT NULL,
	[status] [int] NULL,
	[re_date] [date] NULL,
	[quantity] [int] NULL,
	[check_in_date] [date] NULL,
	[check_out_date] [date] NULL,
	[list_price] [money] NULL,
	[room_id] [int] NULL,
	[service_id] [int] NULL,
	[username] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[re_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Room]    Script Date: 7/17/2024 2:21:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Room](
	[room_id] [int] IDENTITY(1,1) NOT NULL,
	[room_name] [varchar](50) NULL,
	[room_price] [money] NULL,
	[room_img] [varchar](100) NULL,
	[room_status] [bit] NULL,
	[room_description] [nvarchar](500) NULL,
	[room_type_id] [int] NULL,
	[room_capacity] [int] NULL,
	[hotel_id] [int] NULL,
 CONSTRAINT [PK__Room__19675A8A6D592CE9] PRIMARY KEY CLUSTERED 
(
	[room_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RoomType]    Script Date: 7/17/2024 2:21:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoomType](
	[room_type_id] [int] IDENTITY(1,1) NOT NULL,
	[name_type] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[room_type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Service]    Script Date: 7/17/2024 2:21:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Service](
	[service_id] [int] IDENTITY(1,1) NOT NULL,
	[service_name] [varchar](50) NULL,
	[service_price] [money] NULL,
	[hotel_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[service_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UpdateRole]    Script Date: 7/17/2024 2:21:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UpdateRole](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[hotel_name] [nvarchar](50) NULL,
	[hotel_address] [nvarchar](300) NULL,
	[business_licens_img] [varchar](100) NULL,
	[username] [nvarchar](50) NULL,
	[status] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Account] ([username], [password], [is_owner], [is_manager], [is_admin], [ban_status], [report_count], [email], [name], [age], [phone], [id_number]) VALUES (N'dat', N'202cb962ac59075b964b07152d234b70', 0, 0, 0, 0, 0, N'tiendatle2212@gmail.com', N'TIEN DAT', 22, N'0933616727', N'125154762235')
INSERT [dbo].[Account] ([username], [password], [is_owner], [is_manager], [is_admin], [ban_status], [report_count], [email], [name], [age], [phone], [id_number]) VALUES (N'janedoe22', N'96B33694C4BB7DBD07391E0BE54745FB', 0, 1, 0, 0, 0, N'janedoe@example.com', N'Jane Doe', 28, N'0987654321', N'ID0987654321')
INSERT [dbo].[Account] ([username], [password], [is_owner], [is_manager], [is_admin], [ban_status], [report_count], [email], [name], [age], [phone], [id_number]) VALUES (N'johndoe', N'482C811DA5D5B4BC6D497FFA98491E38', 1, 0, 0, 0, 0, N'johndoe@example.com', N'John Doe', 30, N'1234567890', N'ID1234567890')
INSERT [dbo].[Account] ([username], [password], [is_owner], [is_manager], [is_admin], [ban_status], [report_count], [email], [name], [age], [phone], [id_number]) VALUES (N'nya', N'202cb962ac59075b964b07152d234b70', 0, 0, 1, 0, 0, N'tiendatle2@gmail.com', N'TIEN DAT', 22, N'0933616727', N'125154762235')
GO
SET IDENTITY_INSERT [dbo].[Feedback] ON 

INSERT [dbo].[Feedback] ([feedback_id], [comment], [username], [hotel_id], [room_id]) VALUES (1, N'Great stay!', N'johndoe', 1, 1)
INSERT [dbo].[Feedback] ([feedback_id], [comment], [username], [hotel_id], [room_id]) VALUES (2, N'Very spooky!', N'janedoe22', 2, 1)
SET IDENTITY_INSERT [dbo].[Feedback] OFF
GO
SET IDENTITY_INSERT [dbo].[Hotel] ON 

INSERT [dbo].[Hotel] ([hotel_id], [hotel_name], [hotel_address], [hotel_img], [hotel_description], [username]) VALUES (1, N'Vinpearl Resort Nha Trang', N'Hon Tre Island, Vinh Nguyen, Nha Trang, Khanh Hoa, Vietnam', N'Screenshot 2023-06-23 063845.png', N'A luxurious resort located on the beautiful Hon Tre Island.', N'johndoe')
INSERT [dbo].[Hotel] ([hotel_id], [hotel_name], [hotel_address], [hotel_img], [hotel_description], [username]) VALUES (2, N'InterContinental Danang Sun Peninsula Resort', N'Bai Bac, Son Tra Peninsula, Da Nang, Vietnam', N'Screenshot 2023-06-23 063845.png', N'A five-star beach resort nestled in the heart of the Son Tra Peninsula nature reserve.', N'johndoe')
INSERT [dbo].[Hotel] ([hotel_id], [hotel_name], [hotel_address], [hotel_img], [hotel_description], [username]) VALUES (3, N'The Reverie Saigon', N'22-36 Nguyen Hue Boulevard, District 1, Ho Chi Minh City, Vietnam', N'Screenshot 2023-06-23 063845.png', N'An opulent hotel located in the heart of Ho Chi Minh City.', N'johndoe')
INSERT [dbo].[Hotel] ([hotel_id], [hotel_name], [hotel_address], [hotel_img], [hotel_description], [username]) VALUES (4, N'Furama Resort Danang', N'105 Vo Nguyen Giap Street, Khue My Ward, Ngu Hanh Son District, Da Nang, Vietnam', N'Screenshot 2023-06-23 063845.png', N'A stunning beachfront resort in Da Nang.', N'johndoe')
INSERT [dbo].[Hotel] ([hotel_id], [hotel_name], [hotel_address], [hotel_img], [hotel_description], [username]) VALUES (5, N'JW Marriott Phu Quoc Emerald Bay Resort & Spa', N'Bai Khem, Phu Quoc, Kien Giang, Vietnam', N'Screenshot 2023-06-23 063845.png', N'A luxurious resort located on the pristine beach of Bai Khem.', N'johndoe')
INSERT [dbo].[Hotel] ([hotel_id], [hotel_name], [hotel_address], [hotel_img], [hotel_description], [username]) VALUES (6, N'Amanoi', N'Vinh Hy Village, Vinh Hai Commune, Ninh Hai District, Ninh Thuan Province, Vietnam', N'Screenshot 2023-06-23 063845.png', N'A serene retreat overlooking Vinh Hy Bay.', N'johndoe')
INSERT [dbo].[Hotel] ([hotel_id], [hotel_name], [hotel_address], [hotel_img], [hotel_description], [username]) VALUES (7, N'Hyatt Regency Danang Resort and Spa', N'05 Truong Sa Street, Hoa Hai Ward, Ngu Hanh Son District, Da Nang, Vietnam', N'Screenshot 2023-06-23 063845.png', N'A luxurious resort offering stunning views of the East Sea.', N'johndoe')
INSERT [dbo].[Hotel] ([hotel_id], [hotel_name], [hotel_address], [hotel_img], [hotel_description], [username]) VALUES (8, N'Six Senses Con Dao', N'Dat Doc Beach, Con Dao District, Ba Ria-Vung Tau Province, Vietnam', N'Screenshot 2023-06-23 063845.png', N'A five-star eco-friendly resort on Con Dao Island.', N'johndoe')
INSERT [dbo].[Hotel] ([hotel_id], [hotel_name], [hotel_address], [hotel_img], [hotel_description], [username]) VALUES (9, N'Pullman Danang Beach Resort', N'101 Vo Nguyen Giap Street, Khue My Ward, Ngu Hanh Son District, Da Nang, Vietnam', N'Screenshot 2023-06-23 063845.png', N'A contemporary beachfront resort in Da Nang.', N'johndoe')
INSERT [dbo].[Hotel] ([hotel_id], [hotel_name], [hotel_address], [hotel_img], [hotel_description], [username]) VALUES (10, N'Sofitel Legend Metropole Hanoi', N'15 Ngo Quyen Street, Hoan Kiem District, Hanoi, Vietnam', N'Screenshot 2023-06-23 063845.png', N'A historic luxury hotel in the heart of Hanoi.', N'johndoe')
INSERT [dbo].[Hotel] ([hotel_id], [hotel_name], [hotel_address], [hotel_img], [hotel_description], [username]) VALUES (13, N'a', N'af', N'Screenshot 2023-06-23 063845.png', N'aas', N'johndoe')
INSERT [dbo].[Hotel] ([hotel_id], [hotel_name], [hotel_address], [hotel_img], [hotel_description], [username]) VALUES (15, N'á', N'dsb', N'Screenshot 2023-06-23 063845.png', N'bsb', N'johndoe')
SET IDENTITY_INSERT [dbo].[Hotel] OFF
GO
SET IDENTITY_INSERT [dbo].[Reservation] ON 

INSERT [dbo].[Reservation] ([re_id], [status], [re_date], [quantity], [check_in_date], [check_out_date], [list_price], [room_id], [service_id], [username]) VALUES (11, 0, CAST(N'2024-07-17' AS Date), 1, CAST(N'2024-07-17' AS Date), CAST(N'2024-07-18' AS Date), 475.0000, 1, 1, N'dat')
INSERT [dbo].[Reservation] ([re_id], [status], [re_date], [quantity], [check_in_date], [check_out_date], [list_price], [room_id], [service_id], [username]) VALUES (32, 0, CAST(N'2024-07-17' AS Date), 1, CAST(N'2024-07-17' AS Date), CAST(N'2024-07-18' AS Date), 475.0000, 1, 1, N'dat')
INSERT [dbo].[Reservation] ([re_id], [status], [re_date], [quantity], [check_in_date], [check_out_date], [list_price], [room_id], [service_id], [username]) VALUES (33, 0, CAST(N'2024-07-17' AS Date), 1, CAST(N'2024-07-17' AS Date), CAST(N'2024-07-19' AS Date), 950.0000, 1, 1, N'dat')
INSERT [dbo].[Reservation] ([re_id], [status], [re_date], [quantity], [check_in_date], [check_out_date], [list_price], [room_id], [service_id], [username]) VALUES (34, 0, CAST(N'2024-07-17' AS Date), 1, CAST(N'2024-07-17' AS Date), CAST(N'2024-07-19' AS Date), 950.0000, 1, 1, N'dat')
INSERT [dbo].[Reservation] ([re_id], [status], [re_date], [quantity], [check_in_date], [check_out_date], [list_price], [room_id], [service_id], [username]) VALUES (35, 0, CAST(N'2024-07-17' AS Date), 1, CAST(N'2024-07-17' AS Date), CAST(N'2024-07-18' AS Date), 475.0000, 1, 1, N'dat')
SET IDENTITY_INSERT [dbo].[Reservation] OFF
GO
SET IDENTITY_INSERT [dbo].[Room] ON 

INSERT [dbo].[Room] ([room_id], [room_name], [room_price], [room_img], [room_status], [room_description], [room_type_id], [room_capacity], [hotel_id]) VALUES (1, N'Deluxe Ocean View', 300.0000, N'117062300_p0.jpg', 1, N'A room with a stunning view of the ocean.', 1, 8, 1)
INSERT [dbo].[Room] ([room_id], [room_name], [room_price], [room_img], [room_status], [room_description], [room_type_id], [room_capacity], [hotel_id]) VALUES (2, N'Suite with Balcony', 500.0000, N'Screenshot 2023-06-23 063845.png', 1, N'A spacious suite with a private balcony.', 2, 6, 1)
INSERT [dbo].[Room] ([room_id], [room_name], [room_price], [room_img], [room_status], [room_description], [room_type_id], [room_capacity], [hotel_id]) VALUES (3, N'Standard Room', 150.0000, N'standard_room.jpg', 1, N'A comfortable room with all basic amenities.', 1, 7, 2)
INSERT [dbo].[Room] ([room_id], [room_name], [room_price], [room_img], [room_status], [room_description], [room_type_id], [room_capacity], [hotel_id]) VALUES (4, N'Presidential Suite', 1000.0000, N'presidential_suite.jpg', 1, N'The most luxurious suite in the hotel.', 2, 4, 3)
INSERT [dbo].[Room] ([room_id], [room_name], [room_price], [room_img], [room_status], [room_description], [room_type_id], [room_capacity], [hotel_id]) VALUES (5, N'Family Suite', 600.0000, N'family_suite.jpg', 1, N'A large suite suitable for families.', 2, 8, 4)
INSERT [dbo].[Room] ([room_id], [room_name], [room_price], [room_img], [room_status], [room_description], [room_type_id], [room_capacity], [hotel_id]) VALUES (6, N'Junior Suite', 400.0000, N'junior_suite.jpg', 1, N'A small but luxurious suite.', 2, 9, 5)
INSERT [dbo].[Room] ([room_id], [room_name], [room_price], [room_img], [room_status], [room_description], [room_type_id], [room_capacity], [hotel_id]) VALUES (7, N'Garden View Room', 250.0000, N'garden_view.jpg', 1, N'A room with a beautiful view of the garden.', 1, 7, 6)
INSERT [dbo].[Room] ([room_id], [room_name], [room_price], [room_img], [room_status], [room_description], [room_type_id], [room_capacity], [hotel_id]) VALUES (8, N'Penthouse Suite', 1200.0000, N'penthouse_suite.jpg', 1, N'An extravagant suite on the top floor.', 2, 7, 7)
INSERT [dbo].[Room] ([room_id], [room_name], [room_price], [room_img], [room_status], [room_description], [room_type_id], [room_capacity], [hotel_id]) VALUES (9, N'Beachfront Room', 350.0000, N'beachfront_room.jpg', 1, N'A room right on the beach.', 1, 8, 8)
INSERT [dbo].[Room] ([room_id], [room_name], [room_price], [room_img], [room_status], [room_description], [room_type_id], [room_capacity], [hotel_id]) VALUES (10, N'City View Room', 200.0000, N'city_view.jpg', 1, N'A room with a view of the city skyline.', 1, 9, 9)
INSERT [dbo].[Room] ([room_id], [room_name], [room_price], [room_img], [room_status], [room_description], [room_type_id], [room_capacity], [hotel_id]) VALUES (11, N'Historic Room', 450.0000, N'historic_room.jpg', 1, N'A room with a touch of history.', 1, 4, 10)
INSERT [dbo].[Room] ([room_id], [room_name], [room_price], [room_img], [room_status], [room_description], [room_type_id], [room_capacity], [hotel_id]) VALUES (12, N'asfa', 222.0000, N'wallpaperflare.com_wallpaper.jpg', 1, N'asdasd', 1, 6, 1)
SET IDENTITY_INSERT [dbo].[Room] OFF
GO
SET IDENTITY_INSERT [dbo].[RoomType] ON 

INSERT [dbo].[RoomType] ([room_type_id], [name_type]) VALUES (1, N'Single')
INSERT [dbo].[RoomType] ([room_type_id], [name_type]) VALUES (2, N'Double')
SET IDENTITY_INSERT [dbo].[RoomType] OFF
GO
SET IDENTITY_INSERT [dbo].[Service] ON 

INSERT [dbo].[Service] ([service_id], [service_name], [service_price], [hotel_id]) VALUES (1, N'Room Service', 50.0000, 1)
INSERT [dbo].[Service] ([service_id], [service_name], [service_price], [hotel_id]) VALUES (2, N'Spa', 100.0000, 1)
INSERT [dbo].[Service] ([service_id], [service_name], [service_price], [hotel_id]) VALUES (3, N'Laundry Service', 20.0000, 2)
INSERT [dbo].[Service] ([service_id], [service_name], [service_price], [hotel_id]) VALUES (4, N'Airport Shuttle', 30.0000, 3)
INSERT [dbo].[Service] ([service_id], [service_name], [service_price], [hotel_id]) VALUES (5, N'Breakfast Buffet', 15.0000, 4)
INSERT [dbo].[Service] ([service_id], [service_name], [service_price], [hotel_id]) VALUES (6, N'Gym Access', 25.0000, 5)
INSERT [dbo].[Service] ([service_id], [service_name], [service_price], [hotel_id]) VALUES (7, N'Wi-Fi Access', 10.0000, 6)
INSERT [dbo].[Service] ([service_id], [service_name], [service_price], [hotel_id]) VALUES (8, N'Parking', 15.0000, 7)
INSERT [dbo].[Service] ([service_id], [service_name], [service_price], [hotel_id]) VALUES (9, N'Swimming Pool Access', 20.0000, 8)
INSERT [dbo].[Service] ([service_id], [service_name], [service_price], [hotel_id]) VALUES (10, N'Concierge Service', 50.0000, 9)
INSERT [dbo].[Service] ([service_id], [service_name], [service_price], [hotel_id]) VALUES (11, N'Daily Housekeeping', 30.0000, 10)
INSERT [dbo].[Service] ([service_id], [service_name], [service_price], [hotel_id]) VALUES (12, N'Mini Bar', 25.0000, 1)
INSERT [dbo].[Service] ([service_id], [service_name], [service_price], [hotel_id]) VALUES (13, N'In-room Dining', 40.0000, 2)
INSERT [dbo].[Service] ([service_id], [service_name], [service_price], [hotel_id]) VALUES (14, N'Massage Therapy', 70.0000, 3)
INSERT [dbo].[Service] ([service_id], [service_name], [service_price], [hotel_id]) VALUES (15, N'Conference Room Access', 100.0000, 4)
INSERT [dbo].[Service] ([service_id], [service_name], [service_price], [hotel_id]) VALUES (16, N'wif', 444.0000, 13)
SET IDENTITY_INSERT [dbo].[Service] OFF
GO
SET IDENTITY_INSERT [dbo].[UpdateRole] ON 

INSERT [dbo].[UpdateRole] ([id], [hotel_name], [hotel_address], [business_licens_img], [username], [status]) VALUES (3, N'aaaaa', N'aaaaa', N'102892177_p0.jpg', N'dat', NULL)
SET IDENTITY_INSERT [dbo].[UpdateRole] OFF
GO
ALTER TABLE [dbo].[Feedback]  WITH CHECK ADD FOREIGN KEY([hotel_id])
REFERENCES [dbo].[Hotel] ([hotel_id])
GO
ALTER TABLE [dbo].[Feedback]  WITH CHECK ADD  CONSTRAINT [FK__Feedback__room_i__49C3F6B7] FOREIGN KEY([room_id])
REFERENCES [dbo].[Room] ([room_id])
GO
ALTER TABLE [dbo].[Feedback] CHECK CONSTRAINT [FK__Feedback__room_i__49C3F6B7]
GO
ALTER TABLE [dbo].[Feedback]  WITH CHECK ADD FOREIGN KEY([username])
REFERENCES [dbo].[Account] ([username])
GO
ALTER TABLE [dbo].[Hotel]  WITH CHECK ADD FOREIGN KEY([username])
REFERENCES [dbo].[Account] ([username])
GO
ALTER TABLE [dbo].[Reservation]  WITH CHECK ADD  CONSTRAINT [FK__Reservati__room___4CA06362] FOREIGN KEY([room_id])
REFERENCES [dbo].[Room] ([room_id])
GO
ALTER TABLE [dbo].[Reservation] CHECK CONSTRAINT [FK__Reservati__room___4CA06362]
GO
ALTER TABLE [dbo].[Reservation]  WITH CHECK ADD FOREIGN KEY([service_id])
REFERENCES [dbo].[Service] ([service_id])
GO
ALTER TABLE [dbo].[Reservation]  WITH CHECK ADD FOREIGN KEY([username])
REFERENCES [dbo].[Account] ([username])
GO
ALTER TABLE [dbo].[Service]  WITH CHECK ADD FOREIGN KEY([hotel_id])
REFERENCES [dbo].[Hotel] ([hotel_id])
GO
USE [master]
GO
ALTER DATABASE [Room_Booking_website] SET  READ_WRITE 
GO
