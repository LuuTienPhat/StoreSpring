USE [Store]
GO
/****** Object:  Table [dbo].[Account]    Script Date: 13-Dec-21 03:13:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[admin_id] [nvarchar](10) NOT NULL,
	[username] [nvarchar](50) NOT NULL,
	[password] [nvarchar](50) NOT NULL,
	[recovery] [nchar](10) NULL,
 CONSTRAINT [PK_Admin] PRIMARY KEY CLUSTERED 
(
	[admin_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Admin]    Script Date: 13-Dec-21 03:13:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Admin](
	[id] [nvarchar](10) NOT NULL,
	[firstname] [nvarchar](50) NULL,
	[lastname] [nvarchar](50) NULL,
	[birthday] [date] NULL,
	[gender] [nvarchar](50) NULL,
	[email] [nvarchar](50) NULL,
	[phone] [nvarchar](10) NULL,
	[address] [nvarchar](50) NULL,
	[photo] [nvarchar](50) NULL,
	[cover] [nvarchar](50) NULL,
 CONSTRAINT [PK_AdminInfo_1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CartDetail]    Script Date: 13-Dec-21 03:13:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CartDetail](
	[customer_id] [nvarchar](5) NOT NULL,
	[product_id] [nvarchar](5) NOT NULL,
	[quantity] [nvarchar](50) NULL,
 CONSTRAINT [PK_CartDetail] PRIMARY KEY CLUSTERED 
(
	[customer_id] ASC,
	[product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 13-Dec-21 03:13:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[id] [nvarchar](5) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[description] [nvarchar](255) NULL,
	[date_added] [datetime] NOT NULL,
	[image] [nvarchar](255) NULL,
 CONSTRAINT [PK_ProductType] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 13-Dec-21 03:13:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[id] [nvarchar](5) NOT NULL,
	[username] [nvarchar](50) NULL,
	[password] [nvarchar](50) NULL,
	[first_name] [nvarchar](50) NULL,
	[last_name] [nvarchar](50) NULL,
	[telephone] [nvarchar](50) NULL,
	[address] [nvarchar](max) NULL,
	[date_added] [datetime] NULL,
	[email] [nvarchar](50) NULL,
	[recovery] [nchar](10) NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FavoriteProduct]    Script Date: 13-Dec-21 03:13:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FavoriteProduct](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[customer_id] [nvarchar](5) NOT NULL,
	[product_id] [nvarchar](5) NOT NULL,
 CONSTRAINT [PK_FavoriteProduct] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Image]    Script Date: 13-Dec-21 03:13:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Image](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[product_id] [nvarchar](5) NOT NULL,
	[image] [nvarchar](255) NULL,
 CONSTRAINT [PK_Image] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Invoice]    Script Date: 13-Dec-21 03:13:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Invoice](
	[id] [nvarchar](10) NOT NULL,
	[date] [date] NULL,
	[time] [time](7) NULL,
	[admin_id] [nvarchar](10) NOT NULL,
	[invoice_type_id] [int] NOT NULL,
 CONSTRAINT [PK_Invoice] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InvoiceDetail]    Script Date: 13-Dec-21 03:13:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InvoiceDetail](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[invoice_id] [nvarchar](10) NOT NULL,
	[product_id] [nvarchar](5) NOT NULL,
	[quantity] [int] NOT NULL,
	[price] [float] NULL,
 CONSTRAINT [PK_InvoiceDetail] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InvoiceType]    Script Date: 13-Dec-21 03:13:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InvoiceType](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NULL,
 CONSTRAINT [PK_InvoiceType] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Order]    Script Date: 13-Dec-21 03:13:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order](
	[id] [nvarchar](10) NOT NULL,
	[customer_id] [nvarchar](5) NULL,
	[order_date] [datetime] NULL,
	[shipped_date] [date] NULL,
	[ship_name] [nvarchar](50) NULL,
	[ship_phone] [nvarchar](10) NULL,
	[ship_address] [nvarchar](max) NULL,
	[ship_note] [nvarchar](50) NULL,
	[state] [int] NULL,
 CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetail]    Script Date: 13-Dec-21 03:13:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetail](
	[order_id] [nvarchar](10) NOT NULL,
	[product_id] [nvarchar](5) NOT NULL,
	[quantity] [int] NULL,
 CONSTRAINT [PK_OrderDetail] PRIMARY KEY CLUSTERED 
(
	[order_id] ASC,
	[product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 13-Dec-21 03:13:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[id] [nvarchar](5) NOT NULL,
	[name] [nvarchar](max) NULL,
	[quantity] [int] NULL,
	[unit] [nvarchar](50) NULL,
	[price] [float] NULL,
	[description] [nvarchar](max) NULL,
	[date_added] [datetime] NULL,
	[views] [int] NULL,
	[category_id] [nvarchar](5) NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[Account] ([admin_id], [username], [password], [recovery]) VALUES (N'A1234', N'Phat', N'12345', N'A2372     ')
GO
INSERT [dbo].[Admin] ([id], [firstname], [lastname], [birthday], [gender], [email], [phone], [address], [photo], [cover]) VALUES (N'A1234', N'Phát', N'Lưu Tiến', CAST(N'2000-12-11' AS Date), N'0', N't01684599820@gmail.com', N'0908164739', N'hcm', NULL, NULL)
GO
INSERT [dbo].[CartDetail] ([customer_id], [product_id], [quantity]) VALUES (N'U1344', N'P1004', N'2')
INSERT [dbo].[CartDetail] ([customer_id], [product_id], [quantity]) VALUES (N'U1344', N'P2008', N'2')
INSERT [dbo].[CartDetail] ([customer_id], [product_id], [quantity]) VALUES (N'U1344', N'P3257', N'1')
INSERT [dbo].[CartDetail] ([customer_id], [product_id], [quantity]) VALUES (N'U1345', N'P0006', N'1')
GO
INSERT [dbo].[Category] ([id], [name], [description], [date_added], [image]) VALUES (N'C0001', N'Kẹp ảnh', N'Kẹp ảnh', CAST(N'2021-11-09T00:00:00.000' AS DateTime), N'resources/uploads/categories/C0001.jpg')
INSERT [dbo].[Category] ([id], [name], [description], [date_added], [image]) VALUES (N'C0002', N'Quà tặng', N'Quà tặng dịp đặc biệt, ngày đặc biệt, ngày lễ trong năm', CAST(N'2021-11-03T00:00:00.000' AS DateTime), N'resources/uploads/categories/C0002.jpg')
INSERT [dbo].[Category] ([id], [name], [description], [date_added], [image]) VALUES (N'C0003', N'Giày/ thắt lưng', N'Giày dép đi chơi, đi trong nhà', CAST(N'2021-11-03T00:00:00.000' AS DateTime), N'resources/uploads/categories/C0003.jpg')
INSERT [dbo].[Category] ([id], [name], [description], [date_added], [image]) VALUES (N'C0004', N'Khẩu trang', N'Khẩu trang dễ thương', CAST(N'2021-11-03T00:00:00.000' AS DateTime), N'resources/uploads/categories/C0004.jpg')
INSERT [dbo].[Category] ([id], [name], [description], [date_added], [image]) VALUES (N'C0005', N'Kính mắt, gọng kính', N'Kính mắt cho phái đẹp', CAST(N'2021-11-03T00:00:00.000' AS DateTime), N'resources/uploads/categories/C0005.jpg')
INSERT [dbo].[Category] ([id], [name], [description], [date_added], [image]) VALUES (N'C0006', N'Mũ nón/mũ len', N'hello4', CAST(N'2021-11-03T00:00:00.000' AS DateTime), N'resources/uploads/categories/C0006.jpg')
INSERT [dbo].[Category] ([id], [name], [description], [date_added], [image]) VALUES (N'C0007', N'Văn phòng phẩm', N'hello2', CAST(N'2021-11-03T00:00:00.000' AS DateTime), N'resources/uploads/categories/C0007.jpg')
INSERT [dbo].[Category] ([id], [name], [description], [date_added], [image]) VALUES (N'C4872', N'Đồ gia dụng', N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), N'resources/uploads/categories/C4872.jpg')
GO
INSERT [dbo].[Customer] ([id], [username], [password], [first_name], [last_name], [telephone], [address], [date_added], [email], [recovery]) VALUES (N'U1223', N'phat', N'123', N'phat', N'luu', N'088888888', N'tphcm     ', NULL, N'luutienphat@gmail.com', N'A1241     ')
INSERT [dbo].[Customer] ([id], [username], [password], [first_name], [last_name], [telephone], [address], [date_added], [email], [recovery]) VALUES (N'U1224', N'phuong', N'123', N'phat', N'luu', N'088888888', N'tphcm     ', NULL, N'luutienphat@gmail.com', N'A1231     ')
INSERT [dbo].[Customer] ([id], [username], [password], [first_name], [last_name], [telephone], [address], [date_added], [email], [recovery]) VALUES (N'U1225', N'quang', N'123', N'phat', N'luu', N'088888888', N'tphcm     ', NULL, N'luutienphat@gmail.com', N'A1111     ')
INSERT [dbo].[Customer] ([id], [username], [password], [first_name], [last_name], [telephone], [address], [date_added], [email], [recovery]) VALUES (N'U1226', N'thanh', N'123', N'phat', N'luu', N'088888888', N'tphcm     ', NULL, N'luutienphat@gmail.com', N'A8725     ')
INSERT [dbo].[Customer] ([id], [username], [password], [first_name], [last_name], [telephone], [address], [date_added], [email], [recovery]) VALUES (N'U1344', N'tuanbui', N'12345', N'Tuan', N'Bui', N'0333333333', N'man thi   ', NULL, N't01684599820@gmail.com', N'07294     ')
INSERT [dbo].[Customer] ([id], [username], [password], [first_name], [last_name], [telephone], [address], [date_added], [email], [recovery]) VALUES (N'U1345', N'buiquoctuan', N'12345', N'Bùi', N'Tuấn', N'0392322444', N'123, Phường Hiệp Thành, Quận 12, Thành phố Hồ Chí Minh', CAST(N'2021-12-10T00:00:00.000' AS DateTime), N't01684599820@gmail.com', N'62807     ')
INSERT [dbo].[Customer] ([id], [username], [password], [first_name], [last_name], [telephone], [address], [date_added], [email], [recovery]) VALUES (N'U1346', N'tuan_123', N'12345', N'12321', N'Trang', N'0987665511', N'123, Phường Hiệp Thành, Quận 12, Thành phố Hồ Chí Minh', CAST(N'2021-12-10T00:00:00.000' AS DateTime), N't01684599820@gmail.com', N'A5403     ')
GO
SET IDENTITY_INSERT [dbo].[FavoriteProduct] ON 

INSERT [dbo].[FavoriteProduct] ([id], [customer_id], [product_id]) VALUES (2, N'U1223', N'P0006')
INSERT [dbo].[FavoriteProduct] ([id], [customer_id], [product_id]) VALUES (3, N'U1223', N'P0058')
INSERT [dbo].[FavoriteProduct] ([id], [customer_id], [product_id]) VALUES (4, N'U1223', N'P0287')
INSERT [dbo].[FavoriteProduct] ([id], [customer_id], [product_id]) VALUES (7, N'U1223', N'P0297')
INSERT [dbo].[FavoriteProduct] ([id], [customer_id], [product_id]) VALUES (8, N'U1224', N'P0006')
INSERT [dbo].[FavoriteProduct] ([id], [customer_id], [product_id]) VALUES (9, N'U1224', N'P0058')
INSERT [dbo].[FavoriteProduct] ([id], [customer_id], [product_id]) VALUES (10, N'U1224', N'P0287')
INSERT [dbo].[FavoriteProduct] ([id], [customer_id], [product_id]) VALUES (11, N'U1224', N'P0297')
INSERT [dbo].[FavoriteProduct] ([id], [customer_id], [product_id]) VALUES (12, N'U1225', N'P0006')
INSERT [dbo].[FavoriteProduct] ([id], [customer_id], [product_id]) VALUES (13, N'U1225', N'P0058')
INSERT [dbo].[FavoriteProduct] ([id], [customer_id], [product_id]) VALUES (14, N'U1225', N'P0287')
INSERT [dbo].[FavoriteProduct] ([id], [customer_id], [product_id]) VALUES (15, N'U1223', N'P0297')
INSERT [dbo].[FavoriteProduct] ([id], [customer_id], [product_id]) VALUES (27, N'U1344', N'P1470')
INSERT [dbo].[FavoriteProduct] ([id], [customer_id], [product_id]) VALUES (30, N'U1344', N'P0287')
INSERT [dbo].[FavoriteProduct] ([id], [customer_id], [product_id]) VALUES (31, N'U1344', N'P4414')
INSERT [dbo].[FavoriteProduct] ([id], [customer_id], [product_id]) VALUES (32, N'U1345', N'P1470')
INSERT [dbo].[FavoriteProduct] ([id], [customer_id], [product_id]) VALUES (33, N'U1345', N'P1004')
INSERT [dbo].[FavoriteProduct] ([id], [customer_id], [product_id]) VALUES (35, N'U1345', N'P0326')
INSERT [dbo].[FavoriteProduct] ([id], [customer_id], [product_id]) VALUES (36, N'U1345', N'P0476')
INSERT [dbo].[FavoriteProduct] ([id], [customer_id], [product_id]) VALUES (37, N'U1345', N'P0287')
INSERT [dbo].[FavoriteProduct] ([id], [customer_id], [product_id]) VALUES (38, N'U1344', N'P1303')
INSERT [dbo].[FavoriteProduct] ([id], [customer_id], [product_id]) VALUES (39, N'U1344', N'P0058')
INSERT [dbo].[FavoriteProduct] ([id], [customer_id], [product_id]) VALUES (40, N'U1344', N'P0987')
INSERT [dbo].[FavoriteProduct] ([id], [customer_id], [product_id]) VALUES (41, N'U1344', N'P1152')
INSERT [dbo].[FavoriteProduct] ([id], [customer_id], [product_id]) VALUES (42, N'U1344', N'P7668')
INSERT [dbo].[FavoriteProduct] ([id], [customer_id], [product_id]) VALUES (43, N'U1344', N'P0326')
INSERT [dbo].[FavoriteProduct] ([id], [customer_id], [product_id]) VALUES (44, N'U1344', N'P0433')
SET IDENTITY_INSERT [dbo].[FavoriteProduct] OFF
GO
SET IDENTITY_INSERT [dbo].[Image] ON 

INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (81, N'P8446', N'resources/uploads/products/P8446/P8446_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (83, N'P1943', N'resources/uploads/products/P1943/P1943_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (84, N'P1944', N'resources/uploads/products/P1944/P1944_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (85, N'P1944', N'resources/uploads/products/P1944/P1944_2.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (86, N'P1945', N'resources/uploads/products/P1945/P1945_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (91, N'P5902', N'resources/uploads/products/P5902/P5902_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (146, N'P0987', N'resources/uploads/products/P0987/P0987_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (147, N'P1986', N'resources/uploads/products/P1986/P1986_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (148, N'P8283', N'resources/uploads/products/P8283/P8283_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (149, N'P8325', N'resources/uploads/products/P8325/P8325_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (150, N'P2244', N'resources/uploads/products/P2244/P2244_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (151, N'P2978', N'resources/uploads/products/P2978/P2978_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (152, N'P2008', N'resources/uploads/products/P2008/P2008_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (153, N'P7357', N'resources/uploads/products/P7357/P7357_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (154, N'P7720', N'resources/uploads/products/P7720/P7720_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (155, N'P6102', N'resources/uploads/products/P6102/P6102_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (156, N'P7682', N'resources/uploads/products/P7682/P7682_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (157, N'P1708', N'resources/uploads/products/P1708/P1708_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (158, N'P1808', N'resources/uploads/products/P1808/P1808_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (159, N'P6586', N'resources/uploads/products/P6586/P6586_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (160, N'P6263', N'resources/uploads/products/P6263/P6263_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (161, N'P2469', N'resources/uploads/products/P2469/P2469_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (162, N'P4175', N'resources/uploads/products/P4175/P4175_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (163, N'P6601', N'resources/uploads/products/P6601/P6601_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (164, N'P2640', N'resources/uploads/products/P2640/P2640_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (165, N'P4287', N'resources/uploads/products/P4287/P4287_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (166, N'P7111', N'resources/uploads/products/P7111/P7111_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (167, N'P4414', N'resources/uploads/products/P4414/P4414_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (168, N'P0297', N'resources/uploads/products/P0297/P0297_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (169, N'P3547', N'resources/uploads/products/P3547/P3547_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (170, N'P5751', N'resources/uploads/products/P5751/P5751_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (171, N'P4491', N'resources/uploads/products/P4491/P4491_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (172, N'P6359', N'resources/uploads/products/P6359/P6359_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (173, N'P1563', N'resources/uploads/products/P1563/P1563_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (174, N'P6449', N'resources/uploads/products/P6449/P6449_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (175, N'P1510', N'resources/uploads/products/P1510/P1510_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (176, N'P3032', N'resources/uploads/products/P3032/P3032_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (177, N'P4636', N'resources/uploads/products/P4636/P4636_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (178, N'P3257', N'resources/uploads/products/P3257/P3257_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (179, N'P5358', N'resources/uploads/products/P5358/P5358_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (180, N'P5561', N'resources/uploads/products/P5561/P5561_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (182, N'P0433', N'resources/uploads/products/P0433/P0433_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (183, N'P7859', N'resources/uploads/products/P7859/P7859_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (184, N'P9679', N'resources/uploads/products/P9679/P9679_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (185, N'P1812', N'resources/uploads/products/P1812/P1812_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (186, N'P1303', N'resources/uploads/products/P1303/P1303_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (187, N'P6517', N'resources/uploads/products/P6517/P6517_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (188, N'P6421', N'resources/uploads/products/P6421/P6421_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (189, N'P7013', N'resources/uploads/products/P7013/P7013_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (190, N'P1152', N'resources/uploads/products/P1152/P1152_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (191, N'P9289', N'resources/uploads/products/P9289/P9289_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (192, N'P8341', N'resources/uploads/products/P8341/P8341_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (193, N'P9614', N'resources/uploads/products/P9614/P9614_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (194, N'P6456', N'resources/uploads/products/P6456/P6456_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (195, N'P4828', N'resources/uploads/products/P4828/P4828_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (196, N'P9865', N'resources/uploads/products/P9865/P9865_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (197, N'P5686', N'resources/uploads/products/P5686/P5686_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (198, N'P2203', N'resources/uploads/products/P2203/P2203_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (199, N'P7970', N'resources/uploads/products/P7970/P7970_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (200, N'P3585', N'resources/uploads/products/P3585/P3585_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (201, N'P7221', N'resources/uploads/products/P7221/P7221_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (202, N'P0476', N'resources/uploads/products/P0476/P0476_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (203, N'P3226', N'resources/uploads/products/P3226/P3226_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (204, N'P8545', N'resources/uploads/products/P8545/P8545_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (205, N'P4334', N'resources/uploads/products/P4334/P4334_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (206, N'P0907', N'resources/uploads/products/P0907/P0907_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (207, N'P2124', N'resources/uploads/products/P2124/P2124_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (208, N'P0287', N'resources/uploads/products/P0287/P0287_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (209, N'P6803', N'resources/uploads/products/P6803/P6803_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (210, N'P6641', N'resources/uploads/products/P6641/P6641_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (211, N'P3238', N'resources/uploads/products/P3238/P3238_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (212, N'P6576', N'resources/uploads/products/P6576/P6576_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (213, N'P5820', N'resources/uploads/products/P5820/P5820_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (214, N'P5255', N'resources/uploads/products/P5255/P5255_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (215, N'P2496', N'resources/uploads/products/P2496/P2496_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (216, N'P1004', N'resources/uploads/products/P1004/P1004_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (217, N'P8410', N'resources/uploads/products/P8410/P8410_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (218, N'P1470', N'resources/uploads/products/P1470/P1470_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (219, N'P4335', N'resources/uploads/products/P4335/P4335_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (220, N'P0326', N'resources/uploads/products/P0326/P0326_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (221, N'P4158', N'resources/uploads/products/P4158/P4158_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (222, N'P2385', N'resources/uploads/products/P2385/P2385_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (223, N'P9868', N'resources/uploads/products/P9868/P9868_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (224, N'P4134', N'resources/uploads/products/P4134/P4134_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (225, N'P8416', N'resources/uploads/products/P8416/P8416_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (226, N'P7295', N'resources/uploads/products/P7295/P7295_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (227, N'P9746', N'resources/uploads/products/P9746/P9746_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (228, N'P6062', N'resources/uploads/products/P6062/P6062_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (229, N'P5052', N'resources/uploads/products/P5052/P5052_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (230, N'P5318', N'resources/uploads/products/P5318/P5318_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (231, N'P3141', N'resources/uploads/products/P3141/P3141_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (232, N'P9891', N'resources/uploads/products/P9891/P9891_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (233, N'P6159', N'resources/uploads/products/P6159/P6159_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (234, N'P7640', N'resources/uploads/products/P7640/P7640_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (235, N'P9996', N'resources/uploads/products/P9996/P9996_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (236, N'P2786', N'resources/uploads/products/P2786/P2786_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (237, N'P7668', N'resources/uploads/products/P7668/P7668_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (238, N'P9329', N'resources/uploads/products/P9329/P9329_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (239, N'P4564', N'resources/uploads/products/P4564/P4564_1.jpg')
GO
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (240, N'P1483', N'resources/uploads/products/P1483/P1483_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (241, N'P5459', N'resources/uploads/products/P5459/P5459_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (242, N'P2692', N'resources/uploads/products/P2692/P2692_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (243, N'P2482', N'resources/uploads/products/P2482/P2482_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (244, N'P7184', N'resources/uploads/products/P7184/P7184_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (245, N'P0006', N'resources/uploads/products/P0006/P0006_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (246, N'P1875', N'resources/uploads/products/P1875/P1875_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (247, N'P0058', N'resources/uploads/products/P0058/P0058_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (248, N'P6440', N'resources/uploads/products/P6440/P6440_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (249, N'P9147', N'resources/uploads/products/P9147/P9147_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (250, N'P7913', N'resources/uploads/products/P7913/P7913_1.jpg')
INSERT [dbo].[Image] ([id], [product_id], [image]) VALUES (251, N'P6029', N'resources/uploads/products/P6029/P6029_1.jpg')
SET IDENTITY_INSERT [dbo].[Image] OFF
GO
INSERT [dbo].[Invoice] ([id], [date], [time], [admin_id], [invoice_type_id]) VALUES (N'I1234', CAST(N'2021-11-11' AS Date), CAST(N'21:47:33' AS Time), N'A1234', 1)
INSERT [dbo].[Invoice] ([id], [date], [time], [admin_id], [invoice_type_id]) VALUES (N'I1235', CAST(N'2021-11-09' AS Date), CAST(N'08:41:56' AS Time), N'A1234', 1)
INSERT [dbo].[Invoice] ([id], [date], [time], [admin_id], [invoice_type_id]) VALUES (N'I1236', CAST(N'2021-11-15' AS Date), CAST(N'15:03:12' AS Time), N'A1234', 1)
INSERT [dbo].[Invoice] ([id], [date], [time], [admin_id], [invoice_type_id]) VALUES (N'I124456', CAST(N'2021-11-02' AS Date), CAST(N'12:12:00' AS Time), N'A1234', 1)
INSERT [dbo].[Invoice] ([id], [date], [time], [admin_id], [invoice_type_id]) VALUES (N'I570226943', CAST(N'2021-11-02' AS Date), CAST(N'12:12:00' AS Time), N'A1234', 1)
GO
SET IDENTITY_INSERT [dbo].[InvoiceDetail] ON 

INSERT [dbo].[InvoiceDetail] ([id], [invoice_id], [product_id], [quantity], [price]) VALUES (4, N'I1234', N'P1943', 3, 103000)
INSERT [dbo].[InvoiceDetail] ([id], [invoice_id], [product_id], [quantity], [price]) VALUES (5, N'I1234', N'P1944', 3, 26000)
INSERT [dbo].[InvoiceDetail] ([id], [invoice_id], [product_id], [quantity], [price]) VALUES (6, N'I570226943', N'P0987', 12, 100000)
SET IDENTITY_INSERT [dbo].[InvoiceDetail] OFF
GO
SET IDENTITY_INSERT [dbo].[InvoiceType] ON 

INSERT [dbo].[InvoiceType] ([id], [name]) VALUES (1, N'nhập      ')
INSERT [dbo].[InvoiceType] ([id], [name]) VALUES (2, N'xuất      ')
SET IDENTITY_INSERT [dbo].[InvoiceType] OFF
GO
INSERT [dbo].[Order] ([id], [customer_id], [order_date], [shipped_date], [ship_name], [ship_phone], [ship_address], [ship_note], [state]) VALUES (N'O211024000', N'U1223', CAST(N'2021-11-14T00:00:00.000' AS DateTime), NULL, N'phat luu', N'0796919429', N'tphcm     ', N'', 0)
INSERT [dbo].[Order] ([id], [customer_id], [order_date], [shipped_date], [ship_name], [ship_phone], [ship_address], [ship_note], [state]) VALUES (N'O211024001', N'U1345', CAST(N'2021-11-16T22:59:02.750' AS DateTime), NULL, N'Bùi Tuấn', N'0392322444', N'123, Phường Hiệp Thành, Quận 12, Thành phố Hồ Chí Minh', N'', 3)
INSERT [dbo].[Order] ([id], [customer_id], [order_date], [shipped_date], [ship_name], [ship_phone], [ship_address], [ship_note], [state]) VALUES (N'O211024002', N'U1345', CAST(N'2021-11-16T23:05:50.180' AS DateTime), NULL, N'Bùi Tuấn', N'0392322444', N'123, Phường Hiệp Thành, Quận 12, Thành phố Hồ Chí Minh', N'', 0)
INSERT [dbo].[Order] ([id], [customer_id], [order_date], [shipped_date], [ship_name], [ship_phone], [ship_address], [ship_note], [state]) VALUES (N'O211024003', N'U1345', CAST(N'2021-11-16T23:09:02.680' AS DateTime), NULL, N'Bùi Tuấn', N'0392322444', N'123, Phường Hiệp Thành, Quận 12, Thành phố Hồ Chí Minh', N'', 0)
INSERT [dbo].[Order] ([id], [customer_id], [order_date], [shipped_date], [ship_name], [ship_phone], [ship_address], [ship_note], [state]) VALUES (N'O211024005', N'U1223', CAST(N'2021-11-14T00:00:00.000' AS DateTime), NULL, N'phat luu', N'0796919429', N'tphcm     ', N'', 0)
INSERT [dbo].[Order] ([id], [customer_id], [order_date], [shipped_date], [ship_name], [ship_phone], [ship_address], [ship_note], [state]) VALUES (N'O211024006', N'U1223', CAST(N'2021-10-24T00:00:00.000' AS DateTime), NULL, N'phat luu', N'0796919429', N'tphcm     ', N'', 3)
INSERT [dbo].[Order] ([id], [customer_id], [order_date], [shipped_date], [ship_name], [ship_phone], [ship_address], [ship_note], [state]) VALUES (N'O211024007', N'U1344', CAST(N'2021-11-27T17:11:13.703' AS DateTime), NULL, N'tuan bui', N'0333333333', N'man thi   ', N'', 0)
INSERT [dbo].[Order] ([id], [customer_id], [order_date], [shipped_date], [ship_name], [ship_phone], [ship_address], [ship_note], [state]) VALUES (N'O211024008', N'U1344', CAST(N'2021-12-02T11:24:36.187' AS DateTime), NULL, N'tuan bui', N'0333333333', N'man thi   ', N'', 0)
GO
INSERT [dbo].[OrderDetail] ([order_id], [product_id], [quantity]) VALUES (N'O211024000', N'P1944', 1)
INSERT [dbo].[OrderDetail] ([order_id], [product_id], [quantity]) VALUES (N'O211024000', N'P1945', 2)
INSERT [dbo].[OrderDetail] ([order_id], [product_id], [quantity]) VALUES (N'O211024001', N'P0433', 1)
INSERT [dbo].[OrderDetail] ([order_id], [product_id], [quantity]) VALUES (N'O211024001', N'P0476', 2)
INSERT [dbo].[OrderDetail] ([order_id], [product_id], [quantity]) VALUES (N'O211024002', N'P1470', 1)
INSERT [dbo].[OrderDetail] ([order_id], [product_id], [quantity]) VALUES (N'O211024002', N'P2469', 1)
INSERT [dbo].[OrderDetail] ([order_id], [product_id], [quantity]) VALUES (N'O211024003', N'P0287', 1)
INSERT [dbo].[OrderDetail] ([order_id], [product_id], [quantity]) VALUES (N'O211024006', N'P0476', 1)
INSERT [dbo].[OrderDetail] ([order_id], [product_id], [quantity]) VALUES (N'O211024007', N'P1004', 1)
INSERT [dbo].[OrderDetail] ([order_id], [product_id], [quantity]) VALUES (N'O211024007', N'P1563', 1)
INSERT [dbo].[OrderDetail] ([order_id], [product_id], [quantity]) VALUES (N'O211024008', N'P0287', 1)
INSERT [dbo].[OrderDetail] ([order_id], [product_id], [quantity]) VALUES (N'O211024008', N'P0433', 1)
INSERT [dbo].[OrderDetail] ([order_id], [product_id], [quantity]) VALUES (N'O211024008', N'P0476', 1)
INSERT [dbo].[OrderDetail] ([order_id], [product_id], [quantity]) VALUES (N'O211024008', N'P4491', 1)
GO
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P0006', N'Kính mát gọng nhựa dày basic color', 12, N'cái', 100000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 132, N'C0005')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P0058', N'Kính mát gọng nhựa Double B', 12, N'cái', 100000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 412, N'C0005')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P0287', N'Gối sưởi Baby bear gấu bịt mắt sạc điện 27X17', 15, N'cái', 270000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 185, N'C4872')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P0297', N'Thắt lưng dây nịt da Two Daisy Flowers 100cm', 12, N'cái', 50000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 861, N'C0003')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P0326', N'Kẹp gỗ Dinosaur Owl Frog Penguin mập set8', 0, N'cái', 20000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 366, N'C0001')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P0433', N'Thắt lưng dây nịt da khóa vòng xoắn 107cm', 413, N'cái', 60000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 415, N'C0003')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P0476', N'Ly cốc thuỷ tinh Geometry 300ml', 9, N'cái', 80000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 115, N'C4872')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P0907', N'Chai làm sạch giày trắng Little girl oh tiger 100ml', 12, N'lọ', 30000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 701, N'C4872')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P0987', N'Hộp quà MZ Lookii nắp rời Vintage polaroid constellation 8x20x25', 12, N'hộp', 35000, N'', CAST(N'2021-11-14T00:00:00.000' AS DateTime), 193, N'C0002')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P1004', N'Kẹp gỗ Mèo nằm cuộn tròn set10', 20, N'cái', 20000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 266, N'C0001')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P1152', N'Giày sandal Blue and white', 0, N'đôi', 200000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 81, N'C0003')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P1303', N'Thắt lưng dây nịt da móc cài lỗ trái tim basic 100cm', 2, N'cái', 50000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 888, N'C0003')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P1470', N'Kẹp gỗ Thỏ lông xù happy day set10', 22, N'cái', 25000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 522, N'C0001')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P1483', N'Kính gọng kim loại viền ép phẳng chân bọc nhựa', 20, N'cái', 90000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 440, N'C0005')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P1510', N'Miếng lót giày tăng chiều cao Fruit summer set2', 0, N'đôi', 70000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 780, N'C0003')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P1563', N'Thắt lưng dây nịt da khóa khối chữ nhật gold bản nhỏ 100cm', 17, N'cái', 50000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 416, N'C0003')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P1708', N'Thắt lưng dây nịt da nhiều lỗ phối móc xích 105cm', 12, N'cái', 65000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 654, N'C0003')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P1808', N'Thắt lưng dây nịt da A Daisy Flower 102cm', 17, N'cái', 50000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 181, N'C0003')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P1812', N'Dây giày dạ quang 1 màu', 5, N'đôi', 20000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 908, N'C0003')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P1875', N'Kính mát mắt bầu dục basic', 12, N'cái', 135000, N'Kính mát mắt bầu dục basic', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 746, N'C0005')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P1943', N'Thắt lưng dây nịt da viền chỉ khóa vuông basic 106cm - Đen', 13, N'chiếc', 45000, N'Thắt lưng da', CAST(N'2021-10-20T00:00:00.000' AS DateTime), 219, N'C0007')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P1944', N'Thắt lưng dây nịt kim loại mắt xích basic 110cm - Gold', 9, N'chiếc', 70000, N'Thắt lưng kim loại', CAST(N'2021-10-20T00:00:00.000' AS DateTime), 327, N'C0002')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P1945', N'Khẩu trang MJ Astronaut space happy', 8, N'cái', 40000, N'Thắt lưng kim loại', CAST(N'2021-10-20T00:00:00.000' AS DateTime), 834, N'C0004')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P1986', N'Dây giày basic một màu', 100, N'cái', 15000, N'Dây giày', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 754, N'C0003')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P2008', N'Thắt lưng dây nịt da trơn viền chỉ đồng màu 105cm', 14, N'cái', 45000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 986, N'C0003')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P2124', N'Gối sưởi Khủng long baby dinosaur sạc điện 21x29', 21, N'cái', 160000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 320, N'C4872')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P2203', N'Ly cốc sứ Duck peach fruit sweet life 420ml', 9, N'cái', 100000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 1, N'C4872')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P2244', N'Dây giày Daisy Flowers', 30, N'đôi', 25000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 643, N'C0003')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P2385', N'Đựng bút đa năng nhựa Cute duck 9x10', 9, N'cái', 35000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 797, N'C0007')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P2469', N'Thắt lưng dây nịt da trơn móc Tròn basic 105cm', 11, N'cái', 60000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 587, N'C0003')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P2482', N'Kính mát gọng nhựa dày mắt vuông basic', 24, N'cái', 100000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 292, N'C0005')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P2496', N'Kẹp gỗ Mèo NB text set10', 24, N'cái', 20000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 667, N'C0001')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P2640', N'Thắt lưng dây nịt dây da Basic đầu vuông 105cm', 7, N'cái', 40000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 689, N'C0003')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P2692', N'Kính mát gọng nhựa chữ nhật cắt cạnh basic', 21, N'cái', 90000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 192, N'C0005')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P2786', N'Khẩu trang MJ Cáo cục bông cartoon', 22, N'cái', 55000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 688, N'C0004')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P2978', N'Thắt lưng dây nịt da bản nhỏ móc chữ nhật basic', 21, N'cái', 40000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 36, N'C0003')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P3032', N'Miếng lót giày tăng chiều cao Basic color đường kẻ set2', 5, N'đôi', 70000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 359, N'C0003')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P3141', N'Khẩu trang MJ Astronaut space happy', 20, N'cái', 40000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 373, N'C0004')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P3226', N'Ly cốc thuỷ tinh Cat and cloud NB text 500ml', 24, N'cái', 60000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 2, N'C4872')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P3238', N'Kẹp gỗ Cat mermaid caticorn set10', 12, N'cái', 200000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 834, N'C0001')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P3257', N'Thắt lưng dây nịt da vòng tròn móc nối 105cm', 3, N'cái', 50000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 401, N'C0003')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P3547', N'Thắt lưng dây nịt da nứt móc vuông basic 106cm', 4, N'cái', 50000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 823, N'C0003')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P3585', N'Ly cốc sứ Baby bear astronaut cao cấp 470ml', 22, N'cái', 170000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 202, N'C4872')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P4134', N'Sticker túi Flowers and plants set30', 12, N'cái', 30000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 179, N'C0007')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P4158', N'Sổ vở A5 MZ Xmas Lookii Kat The christmas songs 80 trang', 20, N'quyển', 20000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 20, N'C0007')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P4175', N'Thắt lưng dây nịt da trơn không lỗ 105cm', 22, N'cái', 70000, N'mô tả', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 359, N'C0003')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P4287', N'Thắt lưng dây nịt da A Little PM Daisy Flower móc chữ nhật', 17, N'cái', 40000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 850, N'C0003')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P4334', N'Túi chườm giữ nhiệt bọc vải Baby bear', 16, N'cái', 110000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 970, N'C4872')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P4335', N'Kẹp gỗ Earth space thunder set10', 12, N'cái', 20000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 326, N'C0001')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P4414', N'Giày sneaker đạp gót rách Stamp viền trắng', 0, N'đôi', 270000, N'giày đạp gót', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 469, N'C0003')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P4491', N'Thắt lưng dây nịt da Gold Triangle 105cm', 5, N'cái', 45000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 385, N'C0003')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P4564', N'Khẩu trang Ninja 1 màu', 0, N'cái', 30000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 48, N'C0004')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P4636', N'Thắt lưng dây nịt da trơn chữ U basic 100cm', 0, N'cái', 50000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 2, N'C0003')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P4828', N'Ly cốc sứ Smile face sọc nổi 350ml', 9, N'cái', 95000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 939, N'C4872')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P5052', N'Recycle bin Cute pet 11x15', 10, N'cái', 80000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 811, N'C0007')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P5255', N'Kẹp gỗ Cat color emotion set10', 20, N'cái', 20000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 344, N'C0001')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P5318', N'Khẩu trang MJ Gradient pastel color set10', 200, N'set', 30000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 138, N'C0004')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P5358', N'Thắt lưng dây nịt da vòng tròn móc nối 105cm', 7, N'cái', 50000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 329, N'C0003')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P5459', N'Kính gọng nhựa Letter T', 20, N'cái', 80000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 148, N'C0005')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P5561', N'Thắt lưng dây nịt da mảnh vuông đường chéo cạnh 105cm', 7, N'cái', 50000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 391, N'C0003')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P5686', N'Ly cốc sứ Today is a lucky day sọc nổi 280ml', 0, N'cái', 100000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 729, N'C4872')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P5751', N'Thắt lưng dây nịt da nứt móc elip 107cm', 0, N'cái', 55000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 680, N'C0003')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P5820', N'Kẹp gỗ Mèo trái cây fruit set10', 12, N'cái', 20000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 465, N'C0001')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P5902', N'Dây đeo khẩu trang Smile dây sọc', 12, N'dây', 50000, N'', CAST(N'2021-11-14T00:00:00.000' AS DateTime), 621, N'C0002')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P6029', N'Kính mát gọng nhựa mắt mèo 2 chấm', 12, N'cái', 100000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 732, N'C0005')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P6062', N'Washi tape Scenery painting 3mx50mm', 9, N'cái', 25000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 976, N'C0007')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P6102', N'Thắt lưng dây nịt da móc trái tim 115cm', 9, N'cái', 55000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 886, N'C0003')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P6159', N'Bảo vệ khẩu trang Animals line hey guy', 20, N'cái', 5000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 518, N'C0004')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P6263', N'Thắt lưng dây nịt da trơn basic bản nhỏ 106cm', 12, N'cái', 45000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 283, N'C0003')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P6359', N'Thắt lưng dây nịt da khóa gold unique bản nhỏ 100cm', 6, N'cái', 50000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 600, N'C0003')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P6421', N'Thắt lưng dây nịt kim loại mắt xích basic 110cm', 7, N'cái', 80000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 940, N'C0003')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P6440', N'Kính mát gọng nhựa mắt mèo cắt góc', 12, N'cái', 80000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 680, N'C0005')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P6449', N'Thắt lưng dây nịt da khóa khối tròn gold bản nhỏ 100cm', 12, N'cái', 50000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 319, N'C0003')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P6456', N'Gối sưởi Baby bear gấu cún má hồng ngó đầu sạc điện 27x19', 8, N'cái', 150000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 332, N'C4872')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P6517', N'Thắt lưng dây nịt da móc tròn khoét chữ nhật 102cm', 5, N'cái', 50000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 955, N'C0003')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P6576', N'Kẹp gỗ Chân mèo cute set10', 12, N'cái', 20000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 447, N'C0001')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P6586', N'Thắt lưng dây nịt da trơn móc tròn bản lớn 107cm', 18, N'cái', 55000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 419, N'C0003')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P6601', N'Thắt lưng dây nịt da móc tròn bản to 105cm', 9, N'cái', 55000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 844, N'C0003')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P6641', N'Túi chườm giữ nhiệt bọc vải Cún thỏ vịt sweet things', 21, N'cái', 40000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 361, N'C4872')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P6803', N'Túi chườm giữ nhiệt bọc vải Rabbit and cat', 12, N'cái', 40000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 665, N'C4872')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P7013', N'Thắt lưng dây nịt da viền chỉ khóa vuông basic 106cm', 4, N'cái', 60000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 13, N'C0003')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P7111', N'Giày sneaker đạp gót Daisy Flower', 0, N'đôi', 210000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 752, N'C0003')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P7184', N'Kính mát gọng nhựa mắt cắt phẳng viền trên', 12, N'cái', 60000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 814, N'C0005')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P7221', N'Ly cốc sứ Baby bear phao bơi vịt vàng 450ml', 21, N'cái', 135000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 658, N'C4872')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P7295', N'Hộp bút nhựa Little girl oh tiger 21X3', 21, N'hộp', 70000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 820, N'C0007')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P7357', N'Thắt lưng dây nịt vải OFF-WHITE HOTTREND', 24, N'cái', 60000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 524, N'C0003')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P7640', N'Khẩu trang MJ Rabbit tai dài cục bông', 15, N'cái', 45000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 667, N'C0004')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P7668', N'Khẩu trang MJ trơn basic sợi đàn hồi set3', 22, N'set', 45000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 395, N'C0004')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P7682', N'Giày sneaker rách Stamp viền trắng', 14, N'đôi', 270000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 303, N'C0003')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P7720', N'Thắt lưng dây nịt da nhiều lỗ móc Trái tim 105cm', 12, N'cái', 0, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 120, N'C0003')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P7859', N'Thắt lưng dây nịt da Double C 105cm', 6, N'cái', 50000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 194, N'C0003')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P7913', N'Kính mát gọng nhựa chữ nhật viền càng kính dày', 25, N'cái', 80000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 59, N'C0005')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P7970', N'Ly cốc sứ Bright stars 450ml', 20, N'cái', 160000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 434, N'C4872')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P8283', N'Giày sneaker đạp gót lượn sóng basic', 20, N'đôi', 200000, N'GIày', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 673, N'C0003')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P8325', N'Thắt lưng dây nịt da móc vuông xoắn 105cm', 18, N'cái', 50000, N'Thắt lưng', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 958, N'C0003')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P8341', N'Ly cốc sứ Cute cat claw happy time 500ml', 12, N'cái', 100000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 620, N'C4872')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P8410', N'Kẹp gỗ Daisy Duck cosplay cute animal set10', 21, N'cái', 25000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 471, N'C0001')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P8416', N'Bút viết Cute animal', 20, N'cái', 25000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 990, N'C0007')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P8446', N'Hoa sáp bó hướng dương 3 bông 33cm - Vàng', 76, N'bó', 95000, N'', CAST(N'2021-11-14T00:00:00.000' AS DateTime), 629, N'C0002')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P8545', N'Túi chườm giữ nhiệt bọc vải Bé trái cây cute 14x19', 21, N'', 100000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 715, N'C4872')
GO
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P9147', N'Kính mát gọng nhựa mắt chữ nhật chân cắt vòng', 12, N'cái', 80000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 424, N'C0005')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P9289', N'Thắt lưng dây nịt da khóa vuông chạm khắc 107cm', 0, N'cái', 55000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 137, N'C0003')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P9329', N'Khẩu trang MJ cún mèo alone nền màu', 0, N'cái', 60000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 123, N'C0004')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P9614', N'Ly cốc thuỷ tinh xmas Tree snowflake cao cấp 500ml', 12, N'cái', 300000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 10, N'C4872')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P9679', N'Thắt lưng dây nịt kim loại nhiều trái tim', 4, N'cái', 50000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 437, N'C0003')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P9746', N'Sticker bảng MJ Alphabet number series', 20, N'cái', 10000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 319, N'C0007')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P9865', N'Ly cốc sứ Butter Rue d'' Saint Bernard 500ml', 7, N'cái', 95000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 35, N'C4872')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P9868', N'Lịch 2022 MJ để bàn The little prince dream space', 20, N'quyển', 60000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 51, N'C0007')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P9891', N'Khẩu trang MJ Cute animal cosplay fruit', 20, N'cái', 35000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 948, N'C0004')
INSERT [dbo].[Product] ([id], [name], [quantity], [unit], [price], [description], [date_added], [views], [category_id]) VALUES (N'P9996', N'Khẩu trang MJ Animals cục bông color', 25, N'cái', 55000, N'', CAST(N'2021-11-16T00:00:00.000' AS DateTime), 58, N'C0004')
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Admin]    Script Date: 13-Dec-21 03:13:56 PM ******/
ALTER TABLE [dbo].[Account] ADD  CONSTRAINT [IX_Admin] UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Customer]    Script Date: 13-Dec-21 03:13:56 PM ******/
ALTER TABLE [dbo].[Customer] ADD  CONSTRAINT [IX_Customer] UNIQUE NONCLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Admin]  WITH CHECK ADD  CONSTRAINT [FK_AdminInfo_Admin] FOREIGN KEY([id])
REFERENCES [dbo].[Account] ([admin_id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Admin] CHECK CONSTRAINT [FK_AdminInfo_Admin]
GO
ALTER TABLE [dbo].[CartDetail]  WITH CHECK ADD  CONSTRAINT [FK_CartDetail_Customer] FOREIGN KEY([customer_id])
REFERENCES [dbo].[Customer] ([id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[CartDetail] CHECK CONSTRAINT [FK_CartDetail_Customer]
GO
ALTER TABLE [dbo].[CartDetail]  WITH CHECK ADD  CONSTRAINT [FK_CartDetail_Product] FOREIGN KEY([product_id])
REFERENCES [dbo].[Product] ([id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[CartDetail] CHECK CONSTRAINT [FK_CartDetail_Product]
GO
ALTER TABLE [dbo].[FavoriteProduct]  WITH CHECK ADD  CONSTRAINT [FK_FavoriteProduct_Customer] FOREIGN KEY([customer_id])
REFERENCES [dbo].[Customer] ([id])
GO
ALTER TABLE [dbo].[FavoriteProduct] CHECK CONSTRAINT [FK_FavoriteProduct_Customer]
GO
ALTER TABLE [dbo].[FavoriteProduct]  WITH CHECK ADD  CONSTRAINT [FK_FavoriteProduct_Product] FOREIGN KEY([product_id])
REFERENCES [dbo].[Product] ([id])
GO
ALTER TABLE [dbo].[FavoriteProduct] CHECK CONSTRAINT [FK_FavoriteProduct_Product]
GO
ALTER TABLE [dbo].[Image]  WITH CHECK ADD  CONSTRAINT [FK_Image_Product] FOREIGN KEY([product_id])
REFERENCES [dbo].[Product] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Image] CHECK CONSTRAINT [FK_Image_Product]
GO
ALTER TABLE [dbo].[Invoice]  WITH CHECK ADD  CONSTRAINT [FK_Invoice_Admin] FOREIGN KEY([admin_id])
REFERENCES [dbo].[Admin] ([id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Invoice] CHECK CONSTRAINT [FK_Invoice_Admin]
GO
ALTER TABLE [dbo].[Invoice]  WITH CHECK ADD  CONSTRAINT [FK_Invoice_InvoiceType] FOREIGN KEY([invoice_type_id])
REFERENCES [dbo].[InvoiceType] ([id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Invoice] CHECK CONSTRAINT [FK_Invoice_InvoiceType]
GO
ALTER TABLE [dbo].[InvoiceDetail]  WITH CHECK ADD  CONSTRAINT [FK_InvoiceDetail_Invoice] FOREIGN KEY([invoice_id])
REFERENCES [dbo].[Invoice] ([id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[InvoiceDetail] CHECK CONSTRAINT [FK_InvoiceDetail_Invoice]
GO
ALTER TABLE [dbo].[InvoiceDetail]  WITH CHECK ADD  CONSTRAINT [FK_InvoiceDetail_Product] FOREIGN KEY([product_id])
REFERENCES [dbo].[Product] ([id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[InvoiceDetail] CHECK CONSTRAINT [FK_InvoiceDetail_Product]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_hcrvktmjtd8cc6109sfwea09m] FOREIGN KEY([customer_id])
REFERENCES [dbo].[Customer] ([id])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_hcrvktmjtd8cc6109sfwea09m]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_47rfwue5buamcenofjv8m1j6w] FOREIGN KEY([order_id])
REFERENCES [dbo].[Order] ([id])
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK_47rfwue5buamcenofjv8m1j6w]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_Product] FOREIGN KEY([product_id])
REFERENCES [dbo].[Product] ([id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK_OrderDetail_Product]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Category] FOREIGN KEY([category_id])
REFERENCES [dbo].[Category] ([id])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Category]
GO
