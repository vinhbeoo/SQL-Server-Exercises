USE onlineShop
GO

CREATE TABLE [Orders]
(
	[Id] INT PRIMARY KEY IDENTITY(1,1),
	[CreatedDate] DATETIME DEFAULT GETDATE(),
	[ShippedDate] DATETIME NULL CHECK ([ShippedDate] >= GETDATE()),
	[Status] VARCHAR(50) DEFAULT 'WAITING' CHECK ([Status] = 'WAITING' OR [Status] = 'COMPLETED' OR [Status] = 'CANCELED') NOT NULL,
	[Description] NVARCHAR(MAX) NULL,
	[ShippingAddress] NVARCHAR(500) NOT NULL,
	[ShippingCity] NVARCHAR(50) NOT NULL,
	[PaymentType] VARCHAR(20) DEFAULT 'CASH' CHECK ([PaymentType] = 'CREDIT CARD' OR [PaymentType] = 'CASH') NOT NULL,
	[CustomerId] INT NOT NULL FOREIGN KEY REFERENCES Customers(Id),
	[EmployeeId] INT NOT NULL FOREIGN KEY REFERENCES Employees(Id)
)
