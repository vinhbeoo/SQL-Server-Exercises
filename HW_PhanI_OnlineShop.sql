CREATE OR ALTER PROCEDURE usp_GetNewOrder
(
	@ProductId INT,
	@Quantity DECIMAL(18,2),
	@EmployeeId INT,
	@CustomerId INT,
	@ShippingAddress NVARCHAR(500),
	@ShippingCity NVARCHAR(50),
	@PaymentType VARCHAR(20),
	@OrderId INT
)
AS
BEGIN
	DECLARE @Stock INT, @Price MONEY, @Discount DECIMAL(18,2);
BEGIN TRANSACTION
	--Kiểm tra tồn kho
	SELECT @Stock = Stock, @Price = Price, @Discount = Discount 
	FROM Products 
	WHERE Id = @ProductId;

	IF @Stock < @Quantity
		BEGIN
			RAISERROR('Số lượng tồn kho không đủ', 16, 1); 
		RETURN;
	    END

    -- Tạo Order mới

	INSERT INTO Orders (CreatedDate, ShippedDate, Status, Description, ShippingAddress, ShippingCity, PaymentType, CustomerId, EmployeeId)
    VALUES (GETDATE(),NULL, 'WAITING', NULL,@ShippingAddress,@ShippingCity,@PaymentType, @CustomerId, @EmployeeId );

    SET @OrderId = SCOPE_IDENTITY();

	-- Tạo OrderDetail mới
    INSERT INTO OrderDetails (OrderId, ProductId, Quantity, Discount)
    VALUES (@OrderId, @ProductId, @Quantity, @Discount);

	-- Cập nhật tồn kho
    UPDATE Products 
    SET Stock = Stock - @Quantity 
    WHERE Id = @ProductId;

COMMIT TRANSACTION
END

EXEC usp_GetNewOrder 
	@EmployeeId = 1, 
	@CustomerId = 1, 
	@ProductId = 1, 
	@Quantity = 10,
	@ShippingAddress = N'45 Tôn Đức Thắng, Liên Chiểu',
	@ShippingCity = N'Đà Nẵng',
	@PaymentType = 'CASH',
	@OrderId = 22;