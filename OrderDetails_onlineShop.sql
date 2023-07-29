USE onlineShop
GO

CREATE TABLE OrderDetails
(
	[OrderId] INT NOT NULL FOREIGN KEY REFERENCES Orders(Id),
	[ProductId] INT NOT NULL FOREIGN KEY REFERENCES Products(Id),
	[Quantity] DECIMAL(18, 2) NOT NULL CHECK ([Quantity] > 0),
	[Discount] DECIMAL(18, 2) NOT NULL CHECK ([Discount] >= 0 AND [Discount] <=90)
)