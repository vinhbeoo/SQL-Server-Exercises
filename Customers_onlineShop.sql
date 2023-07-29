USE onlineShop;
GO

CREATE TABLE Customers
(
	[Id] INT PRIMARY KEY IDENTITY(1,1),
	[FirstName] NVARCHAR (50) NOT NULL,
	[LastName] NVARCHAR (50) NOT NULL,
	[PhoneNumber] VARCHAR (50) UNIQUE NOT NULL,
	[Addres] NVARCHAR (500) NOT NULL,
	[Email] VARCHAR (50) UNIQUE NOT NULL,
	[Birthday] DATETIME Null
)

EXEC sp_rename 'Customers.Addres', 'Address', 'COLUMN';