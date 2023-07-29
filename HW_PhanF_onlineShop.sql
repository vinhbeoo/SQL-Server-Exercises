--1.Hiển thị tất cả các mặt hàng có giảm giá <= @MinDiscount
ALTER PROCEDURE usp_GetProductsMinDiscount
(
	@MinDiscount DECIMAL(18,2)
)
AS
BEGIN
	SELECT * FROM Products
	WHERE Discount <= @MinDiscount
END

EXECUTE usp_GetProductsMinDiscount 0.15

--2.Hiển thị tất cả các mặt hàng có số lượng tồn kho <= @MinStock
CREATE PROCEDURE usp_GetProductsMinStock
(
	@MinStock DECIMAL(18,2)
)
AS
BEGIN
	SELECT * FROM Products
	WHERE Stock <= @MinStock
END

EXECUTE usp_GetProductsMinStock 50

--3.Hiển thị tất cả các mặt hàng có Giá bán sau khi đã giảm giá <= @Total
CREATE PROCEDURE usp_GetProductsTotal
(
	@Total MONEY
)
AS
BEGIN
	SELECT * FROM Products
	WHERE (Price * (1-Discount)) <= @Total
END

EXECUTE usp_GetProductsTotal 5000000

--4.Hiển thị tất cả các khách hàng có địa chỉ ở @Address
ALTER PROCEDURE usp_GetCustomersAdress
(
	@Address NVARCHAR(500)
)
AS
BEGIN
	SELECT * FROM Customers
	WHERE Addres like @Address
END

EXECUTE usp_GetCustomersAdress N'%Hà Nội%'

--5.Hiển thị tất cả các khách hàng có năm sinh @YearOfBirth
CREATE PROCEDURE usp_GetCustomersYearOfBirth
(
	@YearOfBirth INT
)
AS
BEGIN
	SELECT * FROM Customers
	WHERE DATEPART(YEAR, Birthday) = @YearOfBirth
END

EXECUTE usp_GetCustomersYearOfBirth 1995

--6.Hiển thị tất cả các khách hàng có tuổi từ @MinAge đến @MaxAge.
CREATE PROCEDURE usp_GetCustomersYearoldMinMax
(
	@MinAge INT,
	@MaxAge INT
)
AS
BEGIN
	SELECT * FROM Customers
	WHERE DATEDIFF(YEAR, Birthday,GETDATE()) BETWEEN @MinAge AND @MaxAge
END

EXECUTE usp_GetCustomersYearoldMinMax 24,30

--7.Hiển thị tất cả các khách hàng có sinh nhật là @Date
CREATE PROCEDURE usp_GetCustomersBirthdayDate
(
	@Date DATETIME
)
AS
BEGIN
	SELECT * FROM Customers
	WHERE DATEPART(MONTH, Birthday) = DATEPART(MONTH, @Date)
		AND DATEPART(DAY, Birthday) = DATEPART(DAY, @Date)
END

EXECUTE usp_GetCustomersBirthdayDate '06-06-2023'

--8.Hiển thị tất cả các đơn hàng có trạng thái là @Status trong ngày @Date
ALTER PROCEDURE usp_GetOrdersStatus
(
	@Status VARCHAR(50),
	@Date DATETIME
)
AS
BEGIN
	SELECT * FROM Orders
	WHERE [Status] = @Status 
		AND DATEPART(DAY, [CreatedDate]) = DATEPART(DAY, @Date)
		AND DATEPART(MONTH, [CreatedDate]) = DATEPART(MONTH, @Date)
		AND DATEPART(YEAR, [CreatedDate]) = DATEPART(YEAR, @Date)
END

EXECUTE usp_GetOrdersStatus 'WAITING', '2023-05-27'

--9.Hiển thị tất cả các đơn hàng chưa hoàn thành trong tháng @Month của năm @Year
CREATE PROCEDURE usp_GetOrdersDontCompleted
(
	@Month INT,
	@Year INT
)
AS
BEGIN
	SELECT * FROM Orders
	WHERE [Status] != 'COMPLETED' 
		AND DATEPART(MONTH, [CreatedDate]) = @Month
		AND DATEPART(YEAR, [CreatedDate]) = @Year
END

EXECUTE usp_GetOrdersDontCompleted 5, 2023

--10.Hiển thị tất cả các đơn hàng có hình thức thanh toán là @PaymentMethod
CREATE PROCEDURE usp_GetOrdersPaymentMethod
(
	@PaymentMethod VARCHAR(20)
)
AS
BEGIN
	SELECT * FROM Orders
	WHERE PaymentType = @PaymentMethod
END

EXECUTE usp_GetOrdersPaymentMethod 'CREDIT CARD'

--11.Hiển thị tất cả đơn hàng theo trạng thái @Status với tổng số tiền của đơn hàng đó trong khoảng từ ngày @FromDate, đến ngày @ToDate
ALTER PROCEDURE usp_GetOrdersTotalMoney
(
	@Status VARCHAR(50),
	@FromDate DATETIME,
	@ToDate DATETIME
)
AS
BEGIN
	SELECT 
		O.Id,
		O.Status,
		O.PaymentType,
		SUM(OD.Quantity * P.Price * (1-OD.Discount)) AS TotalMoney
	FROM 
		Orders AS O
			INNER JOIN OrderDetails AS OD ON O.Id = OD.OrderId
			INNER JOIN Products AS P ON OD.ProductId = P.Id
	WHERE 
		O.Status = @Status 
		AND (DATEPART(DAY, O.CreatedDate) BETWEEN DATEPART(DAY, @FromDate) AND DATEPART(DAY, @ToDate))
		AND (DATEPART(MONTH, O.CreatedDate) BETWEEN DATEPART(MONTH, @FromDate) AND DATEPART(MONTH, @ToDate))
		AND (DATEPART(YEAR, O.CreatedDate) BETWEEN DATEPART(YEAR, @FromDate) AND DATEPART(YEAR, @ToDate))
	GROUP BY O.Id, O.Status, O.PaymentType
END

EXECUTE usp_GetOrdersTotalMoney 'WAITING','2023-05-23', '2023-05-30'

--12.Hiển thị tất cả các nhân viên bán hàng theo trạng thái @Status với tổng số tiền bán được trong khoảng từ ngày @FromDate, đến ngày @ToDate
CREATE PROCEDURE usp_GetCustomersTotalMoney
(
	@Status VARCHAR(50),
	@FromDate DATETIME,
	@ToDate DATETIME
)
AS
BEGIN
	SELECT 
		E.Id,
		E.FirstName,
		E.LastName,
		E.Addres,
		SUM(OD.Quantity * P.Price * (1-OD.Discount)) AS TotalMoney
	FROM 
		Employees AS E
			INNER JOIN Orders AS O ON E.Id = O.CustomerId
			INNER JOIN OrderDetails AS OD ON O.Id = OD.OrderId
			INNER JOIN Products AS P ON OD.ProductId = P.Id
	WHERE 
		O.Status = @Status 
		AND (DATEPART(DAY, O.CreatedDate) BETWEEN DATEPART(DAY, @FromDate) AND DATEPART(DAY, @ToDate))
		AND (DATEPART(MONTH, O.CreatedDate) BETWEEN DATEPART(MONTH, @FromDate) AND DATEPART(MONTH, @ToDate))
		AND (DATEPART(YEAR, O.CreatedDate) BETWEEN DATEPART(YEAR, @FromDate) AND DATEPART(YEAR, @ToDate))
	GROUP BY E.Id, E.FirstName, E.LastName, E.Addres
END

EXECUTE usp_GetCustomersTotalMoney 'WAITING','2023-05-23', '2023-05-30'

--13.Hiển thị tất cả các mặt hàng không bán được trong khoảng từ ngày @FromDate, đến ngày @ToDate
ALTER PROCEDURE usp_GetProductsDontSell
(
	@FromDate DATETIME,
	@ToDate DATETIME
)
AS
BEGIN
	SELECT 
	P.*
	FROM Products AS P
	WHERE 
		P.Id NOT IN (
			SELECT DISTINCT 
				OD.ProductId
			FROM 
				OrderDetails AS OD
					INNER JOIN Orders AS O ON OD.OrderId = O.Id
			WHERE O.CreatedDate >= @FromDate AND O.CreatedDate <= @ToDate
			)
END

EXECUTE usp_GetProductsDontSell '2023-05-01' , '2023-05-31'

--14.Hiển thị tất cả các nhà cung cấp không bán được trong khoảng từ ngày @FromDate, đến ngày @ToDate
CREATE PROCEDURE usp_GetSuppliersDontSell
(
	@FromDate DATETIME,
	@ToDate DATETIME
)
AS
BEGIN
	SELECT 
		S.*
	FROM Suppliers AS S
	WHERE 
		S.Id NOT IN (
			SELECT DISTINCT 
				P.SupplierId
			FROM 
				Products AS P
					INNER JOIN OrderDetails AS OD ON P.Id = OD.ProductId
					INNER JOIN Orders AS O ON OD.OrderId = O.Id
			WHERE O.CreatedDate >= @FromDate AND O.CreatedDate <= @ToDate
)
END

EXECUTE usp_GetSuppliersDontSell '2023-05-01' , '2023-05-31'

--15.Hiển thị tất cả các khách hàng mua hàng với tổng số tiền trong khoảng từ ngày @FromDate, đến ngày @ToDate
CREATE PROCEDURE usp_GetCustomerMoneyTotal
(
	@FromDate DATETIME,
	@ToDate DATETIME
)
AS
BEGIN
	SELECT 
		C.Id,
		C.FirstName,
		C.LastName,
		C.Addres,
		SUM(OD.Quantity * P.Price * (1-OD.Discount)) AS TotalMoney
	FROM
		Customers AS C
			INNER JOIN Orders AS O ON C.Id = O.CustomerId
			INNER JOIN OrderDetails AS OD ON O.Id = OD.OrderId
			INNER JOIN Products AS P ON OD.ProductId = P.Id
	WHERE O.CreatedDate >= @FromDate AND O.CreatedDate <= @ToDate
	GROUP BY C.Id, C.FirstName, C.LastName, C.Addres
END

EXECUTE usp_GetCustomerMoneyTotal '2023-05-01' , '2023-05-31'