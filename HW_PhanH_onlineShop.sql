--1.Tạo 1 trigger trên bảng Orders: chặn update bảng Orders khi các Orders có Status = 'COMPLETED' hoặc 'CANCELLED'.
CREATE OR ALTER TRIGGER trg_Order_Prevent_InsertUpdate
ON Orders
AFTER UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT * FROM inserted
        WHERE [Status] = 'COMPLETED' OR [Status] = 'CANCELLED'
    )
    BEGIN
        PRINT 'Cannot update orders having order''s status = COMPLETED or CANCELLED'
        ROLLBACK
    END
END


--2. Tạo 1 trigger trên bảng Orders: chặn delete bảng Orders khi các Orders có Status = 'COMPLETED' hoặc 'CANCELLED'.
CREATE OR ALTER TRIGGER trg_Orders_Prevent_UpdateDelete
ON Orders
AFTER  DELETE
AS
BEGIN
    IF EXISTS (SELECT * FROM inserted WHERE [Status] = 'COMPLETED' OR [Status] = 'CANCELED')
    BEGIN
        PRINT 'Cannot update order having status = COMPLETED or CANCELED.'
        ROLLBACK
    END

    IF EXISTS (SELECT * FROM deleted WHERE [Status] = 'COMPLETED' OR [Status] = 'CANCELED')
    BEGIN
        PRINT 'Cannot delete order having status = COMPLETED or CANCELED.'
        ROLLBACK
    END
END

--3.Tạo 1 trigger trên bảng OrderDetails: chặn update bảng OrderDetails khi các Orders có Status = 'COMPLETED' hoặc 'CANCELLED'.
CREATE OR ALTER TRIGGER trg_OrderDetails_PreventUpdate
ON OrderDetails
AFTER UPDATE
AS
BEGIN
	IF EXISTS (SELECT * FROM inserted AS OD INNER JOIN Orders AS O ON OD.OrderId = O.Id
				WHERE O.Status = 'COMPLETED' OR O.Status = 'CANCELED'
	)
    BEGIN
        PRINT 'Cannot update order having status = COMPLETED or CANCELED.'
        ROLLBACK
    END
END

--4.Tạo 1 trigger trên bảng OrderDetails: chặn delete bảng OrderDetails khi các Orders có Status = 'COMPLETED' hoặc 'CANCELLED'.
CREATE OR ALTER TRIGGER trg_OrderDetails_PreventDelete
ON OrderDetails
AFTER DELETE
AS
BEGIN
	IF EXISTS 
		(SELECT * FROM deleted AS OD INNER JOIN Orders AS O ON OD.OrderId = O.Id
		WHERE O.Status = 'COMPLETED' OR O.Status = 'CANCELED'
		)
	BEGIN
		PRINT 'Cannot Delete orderDetails having status = COMPLETED or CANCELED.'
		ROLLBACK
	END
END

--5.Tạo 1 trigger trên bảng Orders: cập nhật tồn kho (Stock), trừ đi số lượng đã bán (Quantity) khi Orders có Status = 'WAITING', cộng lại số lượng đã bán (Quantity) khi Orders có Status = 'CANCELED'.
CREATE OR ALTER TRIGGER trg_OrderDetails_Update_ProductStock
ON OrderDetails
AFTER INSERT
AS
BEGIN
    UPDATE Products
        SET Stock = Stock - I.Quantity
    FROM
        Products AS P
    INNER JOIN inserted AS I ON P.Id = I.ProductID
END

SELECT * FROM Products

--6.Tạo 1 trigger trên bảng Orders: ghi nhật ký khi Orders được giao hàng thành công (Status = 'COMPLETED'), Ghi vào bảng OrderLogs (Id, OrderId, Status, CreatedDate, EmployeeId, CustomerId)	

CREATE OR ALTER TRIGGER trg_Orders_LogAlterTable
ON Orders
AFTER UPDATE
AS
BEGIN
	DECLARE @OrderId INT
	DECLARE @Status VARCHAR(50)
	DECLARE @EmployeeId INT
	DECLARE @CustomerId INT

	SELECT
		@OrderId = inserted.Id,
		@Status = inserted.Status,
		@EmployeeId = inserted.EmployeeId,
		@CustomerId = inserted.CustomerId
	FROM
		inserted
	IF(@Status = 'COMPLETED') BEGIN
		INSERT INTO OrderLogs(OrderId, Status, CreatedDate, EmployeeId, CustomerId)
		VALUES 
			(
			@OrderId, @Status, GETDATE(), @EmployeeId, @CustomerId
			)
	END
END

SELECT * FROM OrderLogs
DROP TRIGGER IF EXISTS dbo.trg_Orders_LogAlterTable;
UPDATE Orders
SET Status = 'COMPLETED', ShippedDate = '2023-11-08'
WHERE Id = 10;

SELECT name, create_date, modify_date
FROM sys.triggers
WHERE parent_class_desc = 'OBJECT_OR_COLUMN' AND parent_id = OBJECT_ID('Orders')