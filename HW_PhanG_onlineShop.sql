--1.Viết 1 scalar function ghép FirstName @FirstName và LastName @LastName, tên function là udf_GetFullName
CREATE FUNCTION udf_GetFullName
(
	@FirstName NVARCHAR(50),
	@LastName NVARCHAR(50)
)
RETURNS NVARCHAR(100)
AS
BEGIN
	 DECLARE @FullName NVARCHAR(100)
	 SET @FullName = @FirstName + ' ' + @LastName
	 RETURN @FullName
END

SELECT dbo.udf_GetFullName(FirstName, LastName) AS FullName
FROM Customers

--2.Viết 1 scalar funtion tính total price (@Price, @Discount, @Quantity), tên function là udf_Product_GetTotalPrice
CREATE FUNCTION udf_Product_GetTotalPrice
(
	@Price MONEY,
	@Discount DECIMAL(18,2),
	@Quantity DECIMAL(18,2)
)
RETURNS MONEY
AS
BEGIN
	DECLARE @PriceTotal MONEY
	SET @PriceTotal = (@Quantity * @Price * (1 - @Discount))
	RETURN @PriceTotal
END

SELECT dbo.udf_Product_GetTotalPrice(OD.Quantity, OD.Discount, P.Price) AS PriceTotal
FROM 
	OrderDetails AS OD
		INNER JOIN Products AS P ON OD.ProductId = P.Id

--3.Viết 1 scalar function tính total price của 1 Order (@OrderID), tên function là udf_Order_GetTotalPrice
CREATE FUNCTION	udf_Order_GetTotalPrice
(
	@OrderID INT
)
RETURNS MONEY
AS
BEGIN
	DECLARE @PriceTotalWithOrder MONEY
	SELECT @PriceTotalWithOrder = SUM(dbo.udf_Product_GetTotalPrice(OD.Quantity, OD.Discount, P.Price))
	FROM OrderDetails AS OD
			INNER JOIN Products AS P ON OD.ProductId = P.Id
	WHERE OD.OrderId = @OrderID
	RETURN @PriceTotalWithOrder
END

SELECT dbo.udf_Order_GetTotalPrice(2) AS PriceTotal

--4.Viết table function trả về table gồm các fields: OrderId, ProductId, ProductName, CategoryId, CategoryName, Quantity, Price, Discount, Total với tham số @OrderId, tên function là udf_Order_GetOrderDetails
ALTER FUNCTION udf_Order_GetOrderDetails
(
	@OrderId INT
)
RETURNS TABLE
AS
RETURN
(
	SELECT
		OD.OrderId,
		OD.ProductId,
		P.Names AS ProductName,
		P.CategoryId,
		C.Name AS CategoryName,
		OD.Quantity,
		P.Price,
		OD.Discount,
		SUM(OD.Quantity * P.Price * (1 - OD.Discount)) AS Total
	FROM
		OrderDetails AS OD
			INNER JOIN Products AS P ON OD.ProductId = P.Id
			INNER JOIN Categories AS C ON P.CategoryId = C.Id
	WHERE OD.OrderId = @OrderId
	GROUP BY 
		OD.OrderId,
		OD.ProductId,
		P.Names,
		P.CategoryId,
		C.Name,
		OD.Quantity,
		P.Price,
		OD.Discount
)

SELECT * FROM dbo.udf_Order_GetOrderDetails(2) 

--5.Viết table function trả về các mức giá của 1 danh mục loại sản phẩm, với tham số @CategoryId, tên function là udf_Category_GetCategoryPrices
CREATE FUNCTION udf_Category_GetCategoryPrices(@CategoryId INT)
RETURNS TABLE
AS
RETURN
(
	SELECT DISTINCT Price
	FROM Products
	WHERE CategoryId = @CategoryId
)

SELECT * FROM dbo.udf_Category_GetCategoryPrices(1)

--6.Viết table function trả về các mức giảm giá của 1 danh mục loại sản phẩm, với tham số @CategoryId, tên function là udf_Category_GetCategoryDiscounts
CREATE FUNCTION udf_Category_GetCategoryDiscounts(@CategoryId INT)
RETURNS TABLE
AS
RETURN
(
	SELECT Discount
	FROM Products 
	WHERE CategoryId = @CategoryId
)

SELECT * FROM dbo.udf_Category_GetCategoryDiscounts(2)

--7.Viết scalar function nhập vào năm sinh, trả về số tuổi, tên function là udf_CalculateAge
CREATE FUNCTION udf_CalculateAge(@YearBirthday INT)
RETURNS INT
AS
BEGIN
	DECLARE @Age INT
	SET @Age = YEAR(GETDATE()) - @YearBirthday
	RETURN @Age
END

SELECT dbo.udf_CalculateAge(1972) AS Age

--8.Viết scalar function chuyển đổi UNICODE có dấu sang không dấu, tên function là udf_ConvertUnicodeToNonUnicode, ví dụ: udf_ConvertUnicodeToNonUnicode(N'Ngô Thanh Tùng') -> 'Ngo Thanh Tung'.
ALTER FUNCTION udf_ConvertUnicodeToNonUnicode (@inputString NVARCHAR(MAX))
RETURNS NVARCHAR(MAX)
AS
BEGIN
    DECLARE @outputString NVARCHAR(MAX)
    SET @outputString = @inputString

    -- Chuyển đổi các ký tự có mã Unicode từ 192 đến 687 thành các ký tự không dấu
    SET @outputString = REPLACE(@outputString, N'Ạ', N'A')
	SET @outputString = REPLACE(@outputString, N'Á', N'A')
    SET @outputString = REPLACE(@outputString, N'À', N'A')
    SET @outputString = REPLACE(@outputString, N'Ã', N'A')
    SET @outputString = REPLACE(@outputString, N'Ả', N'A')

    SET @outputString = REPLACE(@outputString, N'Ầ', N'A')
	SET @outputString = REPLACE(@outputString, N'Â', N'A')
    SET @outputString = REPLACE(@outputString, N'Ấ', N'A')
    SET @outputString = REPLACE(@outputString, N'Ậ', N'A')
    SET @outputString = REPLACE(@outputString, N'Ẩ', N'A')
    SET @outputString = REPLACE(@outputString, N'Ẫ', N'A')

	SET @outputString = REPLACE(@outputString, N'Ặ', N'A')
	SET @outputString = REPLACE(@outputString, N'Ắ', N'A')
	SET @outputString = REPLACE(@outputString, N'Ằ', N'A')
	SET @outputString = REPLACE(@outputString, N'Ẵ', N'A')
	SET @outputString = REPLACE(@outputString, N'Ẳ', N'A')
	SET @outputString = REPLACE(@outputString, N'Ă', N'A')

    SET @outputString = REPLACE(@outputString, N'Ẹ', N'E')
    SET @outputString = REPLACE(@outputString, N'Ẻ', N'E')
	SET @outputString = REPLACE(@outputString, N'Ẽ', N'E')
	SET @outputString = REPLACE(@outputString, N'È', N'E')
	SET @outputString = REPLACE(@outputString, N'É', N'E')

    SET @outputString = REPLACE(@outputString, N'Ề', N'E')
    SET @outputString = REPLACE(@outputString, N'Ế', N'E')
    SET @outputString = REPLACE(@outputString, N'Ệ', N'E')
    SET @outputString = REPLACE(@outputString, N'Ể', N'E')
    SET @outputString = REPLACE(@outputString, N'Ễ', N'E')
	SET @outputString = REPLACE(@outputString, N'Ê', N'E')

    SET @outputString = REPLACE(@outputString, N'Ị', N'I')
    SET @outputString = REPLACE(@outputString, N'Ỉ', N'I')
	SET @outputString = REPLACE(@outputString, N'Ì', N'I')
	SET @outputString = REPLACE(@outputString, N'Í', N'I')
	SET @outputString = REPLACE(@outputString, N'Ĩ', N'I')

    SET @outputString = REPLACE(@outputString, N'Ố', N'o')
	SET @outputString = REPLACE(@outputString, N'Ồ', N'o')
	SET @outputString = REPLACE(@outputString, N'Ổ', N'o')
	SET @outputString = REPLACE(@outputString, N'Ỗ', N'o')
	SET @outputString = REPLACE(@outputString, N'Ộ', N'o')
	SET @outputString = REPLACE(@outputString, N'Ô', N'o')

    SET @outputString = REPLACE(@outputString, N'Ọ', N'O')
	SET @outputString = REPLACE(@outputString, N'Ò', N'O')
	SET @outputString = REPLACE(@outputString, N'Ó', N'O')
	SET @outputString = REPLACE(@outputString, N'Ỏ', N'O')
	SET @outputString = REPLACE(@outputString, N'Õ', N'O')

    SET @outputString = REPLACE(@outputString, N'Ơ', N'O')
    SET @outputString = REPLACE(@outputString, N'Ờ', N'O')
    SET @outputString = REPLACE(@outputString, N'Ớ', N'O')
    SET @outputString = REPLACE(@outputString, N'Ợ', N'O')
    SET @outputString = REPLACE(@outputString, N'Ở', N'O')
    SET @outputString = REPLACE(@outputString, N'Ỡ', N'O')

    SET @outputString = REPLACE(@outputString, N'Ụ', N'u')
    SET @outputString = REPLACE(@outputString, N'Ủ', N'u')
	SET @outputString = REPLACE(@outputString, N'Ũ', N'u')
	SET @outputString = REPLACE(@outputString, N'Ù', N'u')
	SET @outputString = REPLACE(@outputString, N'Ú', N'u')

    SET @outputString = REPLACE(@outputString, N'Ư', N'u')
    SET @outputString = REPLACE(@outputString, N'Ừ', N'u')
    SET @outputString = REPLACE(@outputString, N'Ứ', N'u')
    SET @outputString = REPLACE(@outputString, N'Ự', N'u')
    SET @outputString = REPLACE(@outputString, N'Ử', N'u')
    SET @outputString = REPLACE(@outputString, N'Ữ', N'u')

    SET @outputString = REPLACE(@outputString, N'Ỳ', N'Y')
	SET @outputString = REPLACE(@outputString, N'Ý', N'Y')
    SET @outputString = REPLACE(@outputString, N'Ỵ', N'Y')
    SET @outputString = REPLACE(@outputString, N'Ỷ', N'Y')
    SET @outputString = REPLACE(@outputString, N'Ỹ', N'Y') 

    RETURN @outputString
END

SELECT dbo.udf_ConvertUnicodeToNonUnicode(N'Ngô Thanh Tùng') -- Kết quả: Ngo Thanh Tung

--9.Viết scalar function chuyển đổi tên sản phẩm thành SEO Url, tên function là udf_ConvertToSeoUrl, ví dụ: udf_ConvertToSeoUrl(N'Điện thoại iPhone 12 Pro Max 256GB') -> 'dien-thoai-iphone-12-pro-max-256gb'.
CREATE OR ALTER FUNCTION dbo.udf_ConvertToSeoUrl (@inputString NVARCHAR(255))
RETURNS NVARCHAR(255)
BEGIN
    DECLARE @outputString NVARCHAR(MAX)
    SET @outputString = @inputString

    -- Chuyển đổi các ký tự có mã Unicode từ 192 đến 687 thành các ký tự không dấu
    SET @outputString = REPLACE(LOWER(@outputString), N'ạ', N'a')
SET @outputString = REPLACE(LOWER(@outputString), N'á', N'a')
SET @outputString = REPLACE(LOWER(@outputString), N'à', N'a')
SET @outputString = REPLACE(LOWER(@outputString), N'ã', N'a')
SET @outputString = REPLACE(LOWER(@outputString), N'ả', N'a')

SET @outputString = REPLACE(LOWER(@outputString), N'đ', N'd')

SET @outputString = REPLACE(LOWER(@outputString), N'ầ', N'a')
SET @outputString = REPLACE(LOWER(@outputString), N'â', N'a')
SET @outputString = REPLACE(LOWER(@outputString), N'ấ', N'a')
SET @outputString = REPLACE(LOWER(@outputString), N'ậ', N'a')
SET @outputString = REPLACE(LOWER(@outputString), N'ẩ', N'a')
SET @outputString = REPLACE(LOWER(@outputString), N'ẫ', N'a')

SET @outputString = REPLACE(LOWER(@outputString), N'ặ', N'a')
SET @outputString = REPLACE(LOWER(@outputString), N'ắ', N'a')
SET @outputString = REPLACE(LOWER(@outputString), N'ằ', N'a')
SET @outputString = REPLACE(LOWER(@outputString), N'ẵ', N'a')
SET @outputString = REPLACE(LOWER(@outputString), N'ẳ', N'a')
SET @outputString = REPLACE(LOWER(@outputString), N'ă', N'a')

SET @outputString = REPLACE(LOWER(@outputString), N'ẹ', N'e')
SET @outputString = REPLACE(LOWER(@outputString), N'ẻ', N'e')
SET @outputString = REPLACE(LOWER(@outputString), N'ẽ', N'e')
SET @outputString = REPLACE(LOWER(@outputString), N'è', N'e')
SET @outputString = REPLACE(LOWER(@outputString), N'é', N'e')

SET @outputString = REPLACE(LOWER(@outputString), N'ề', N'e')
SET @outputString = REPLACE(LOWER(@outputString), N'ế', N'e')
SET @outputString = REPLACE(LOWER(@outputString), N'ệ', N'e')
SET @outputString = REPLACE(LOWER(@outputString), N'ể', N'e')
SET @outputString = REPLACE(LOWER(@outputString), N'ễ', N'e')
SET @outputString = REPLACE(LOWER(@outputString), N'ê', N'e')

SET @outputString = REPLACE(LOWER(@outputString), N'ị', N'i')
SET @outputString = REPLACE(LOWER(@outputString), N'ỉ', N'i')
SET @outputString = REPLACE(LOWER(@outputString), N'ì', N'i')
SET @outputString = REPLACE(LOWER(@outputString), N'í', N'i')
SET @outputString = REPLACE(LOWER(@outputString), N'ĩ', N'i')

SET @outputString = REPLACE(LOWER(@outputString), N'ố', N'o')
SET @outputString = REPLACE(LOWER(@outputString), N'ồ', N'o')
SET @outputString = REPLACE(LOWER(@outputString), N'ổ', N'o')
SET @outputString = REPLACE(LOWER(@outputString), N'ỗ', N'o')
SET @outputString = REPLACE(LOWER(@outputString), N'ộ', N'o')
SET @outputString = REPLACE(LOWER(@outputString), N'ô', N'o')

SET @outputString = REPLACE(LOWER(@outputString), N'ọ', N'o')
SET @outputString = REPLACE(LOWER(@outputString), N'ò', N'o')
SET @outputString = REPLACE(LOWER(@outputString), N'ó', N'o')
SET @outputString = REPLACE(LOWER(@outputString), N'ỏ', N'o')
SET @outputString = REPLACE(LOWER(@outputString), N'õ', N'o')

SET @outputString = REPLACE(LOWER(@outputString), N'ơ', N'o')
SET @outputString = REPLACE(LOWER(@outputString), N'ờ', N'o')
SET @outputString = REPLACE(LOWER(@outputString), N'ớ', N'o')
SET @outputString = REPLACE(LOWER(@outputString), N'ợ', N'o')
SET @outputString = REPLACE(LOWER(@outputString), N'ở', N'o')
SET @outputString = REPLACE(LOWER(@outputString), N'ỡ', N'o')

SET @outputString = REPLACE(LOWER(@outputString), N'ụ', N'u')
SET @outputString = REPLACE(LOWER(@outputString), N'ủ', N'u')
SET @outputString = REPLACE(LOWER(@outputString), N'ũ', N'u')
SET @outputString = REPLACE(LOWER(@outputString), N'ù', N'u')
SET @outputString = REPLACE(LOWER(@outputString), N'ú', N'u')

SET @outputString = REPLACE(LOWER(@outputString), N'ư', N'u')
SET @outputString = REPLACE(LOWER(@outputString), N'ừ', N'u')
SET @outputString = REPLACE(LOWER(@outputString), N'ứ', N'u')
SET @outputString = REPLACE(LOWER(@outputString), N'ự', N'u')
SET @outputString = REPLACE(LOWER(@outputString), N'ử', N'u')
SET @outputString = REPLACE(LOWER(@outputString), N'ữ', N'u')

SET @outputString = REPLACE(LOWER(@outputString), N'ỳ', N'y')
SET @outputString = REPLACE(LOWER(@outputString), N'ý', N'y')
SET @outputString = REPLACE(LOWER(@outputString), N'ỵ', N'y')
SET @outputString = REPLACE(LOWER(@outputString), N'ỷ', N'y')
SET @outputString = REPLACE(LOWER(@outputString), N'ỹ', N'y')

	SET @outputString = REPLACE(@outputString, ' ', '-')
	SET @outputString = REPLACE(@outputString, '&', '-')
	SET @outputString = REPLACE(@outputString, ':', '-')
	SET @outputString = REPLACE(@outputString, ';', '-')
	SET @outputString = REPLACE(@outputString, ',', '-')
	SET @outputString = REPLACE(@outputString, '.', '-')
	SET @outputString = REPLACE(@outputString, '"', '-')
	SET @outputString = REPLACE(@outputString, '''', '-')
	SET @outputString = REPLACE(@outputString, '<', '-')
	SET @outputString = REPLACE(@outputString, '>', '-')
	SET @outputString = REPLACE(@outputString, '?', '-')
	SET @outputString = REPLACE(@outputString, '/', '-')
	SET @outputString = REPLACE(@outputString, '`', '-')
	SET @outputString = REPLACE(@outputString, '!', '-')
	SET @outputString = REPLACE(@outputString, '@', '-')
	SET @outputString = REPLACE(@outputString, '#', '-')
	SET @outputString = REPLACE(@outputString, '$', '-')
	SET @outputString = REPLACE(@outputString, '%', '-')
	SET @outputString = REPLACE(@outputString, '^', '-')
	SET @outputString = REPLACE(@outputString, '&', '-')
	SET @outputString = REPLACE(@outputString, '*', '-')
	SET @outputString = REPLACE(@outputString, '(', '-')
	SET @outputString = REPLACE(@outputString, ')', '-')
	SET @outputString = REPLACE(@outputString, '_', '-')
	SET @outputString = REPLACE(@outputString, '+', '-')
	SET @outputString = REPLACE(@outputString, '=', '-')
	
	WHILE CHARINDEX('--', @outputString) > 0
    BEGIN
        SET @outputString = REPLACE(@outputString, '--', '-')
    END

	SET @outputString = CASE 
                    WHEN LEFT(@outputString, 1) = '-' THEN RIGHT(@outputString, LEN(@outputString) - 1) 
                    ELSE @outputString 
                  END
    SET @outputString = CASE 
                    WHEN RIGHT(@outputString, 1) = '-' THEN LEFT(@outputString, LEN(@outputString) - 1) 
                    ELSE @outputString 
                  END

    RETURN @outputString
	END


SELECT dbo.udf_ConvertToSeoUrl(N'Điện thoại iPhone 12 Pro Max 256GB')