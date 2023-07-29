USE onlineShop;
GO

CREATE TABLE Products
(
	[Id] INT PRIMARY KEY IDENTITY(1,1),
	[Names] NVARCHAR (50) NOT NULL,
	[Price] Money CHECK([Price] > 0) NOT NULL,
	[Discount] DECIMAL(18, 2) DEFAULT 0 CHECK([Discount] >= 0 AND [Discount] <= 90) NOT NULL,
	[Stock] DECIMAL(18, 2) NOT NULL CHECK([Stock] >= 0),
	[CategoryId] INT NOT NULL FOREIGN KEY REFERENCES Categories(Id),
	[SupplierId] INT NOT NULL FOREIGN KEY REFERENCES Suppliers(Id),
	[Descriptions] NVARCHAR(MAX) NOT NULL
)