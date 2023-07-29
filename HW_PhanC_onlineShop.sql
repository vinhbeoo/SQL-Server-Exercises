--Hiển thị tất cả các mặt hàng có giảm giá <= 20%
SELECT
	[Id] AS [Mã sản phẩm],
	[Names] AS [Tên sản phẩm], 
	[Price] AS [Giá sản phẩm], 
	[Discount] AS [Giảm giá]
FROM Products
WHERE Discount <= 20;

--Hiện thị tất cả các mặt hàng không có giảm giá
SELECT
	[Id] AS [Mã sản phẩm],
	[Names] AS [Tên sản phẩm], 
	[Price] AS [Giá sản phẩm], 
	[Discount] AS [Giảm giá]
FROM Products
WHERE Discount = 0;

--Hiển thị tất cả các mặt hàng có số lượng tồn kho <= 20
SELECT
	[Id] AS [Mã sản phẩm],
	[Names] AS [Tên sản phẩm], 
	[Stock] AS [Tồn kho] 
FROM Products
WHERE Stock <= 20;

--Hiển thị tất cả các mặt hàng có Giá bán sau khi đã giảm giá <= 1000.000
SELECT
	[Id] AS [Mã sản phẩm],
	[Names] AS [Tên sản phẩm], 
	[Price] AS [Giá sản phẩm], 
	[Discount] AS [Giảm giá]
FROM Products
WHERE Price <= 1000.00;

--Hiện thị tất cả các mặt hàng thuộc danh mục Laptop, Screen
SELECT
	[Id] AS [Mã sản phẩm],
	[Names] AS [Tên sản phẩm], 
	[CategoryId] AS [Id]
FROM Products
WHERE CategoryId IN (1, 3); -- laptop có CategoryId = 1, Screen có CategoryId = 3

--Hiển thị tất cả các khách hàng có địa chỉ ở Hồ Chí Minh
SELECT
	[Id] AS [Mã Khách Hàng],
	[FirstName] AS [Họ], 
	[LastName] AS [Tên],
	[Addres] AS [Địa chỉ]
FROM Customers
WHERE [Addres] LIKE N'%Hồ Chí Minh%';

--Hiển thị tất cả các khách hàng có địa chỉ ở Hà Nội hoặc Hải Phòng;
SELECT *
FROM Customers
WHERE [Addres] LIKE N'%Hà Nội%' OR [Addres] LIKE N'%Hải Phòng%';

--Hiển thị tất cả các khách hàng có năm sinh 1990.
SELECT *
FROM Customers
WHERE YEAR(Birthday) = 1990;

--Hiển thị tất cả các khách hàng có tuổi trên 30.
SELECT *
FROM Customers
WHERE DATEDIFF(year, Birthday, GETDATE()) > 30;

--Hiển thị tất cả các khách hàng có tuổi từ 20 đến 30.
SELECT *
FROM Customers
WHERE DATEDIFF(year, Birthday, GETDATE()) BETWEEN 20 AND 30;

--Hiển thị tất cả các khách hàng có sinh nhật là hôm nay
SELECT *
FROM Customers
WHERE DAY(GETDATE()) = DAY(Birthday) AND MONTH(GETDATE()) = MONTH(Birthday);

--Hiển thị tất cả các đơn hàng có trạng thái là COMPLETED
SELECT *
FROM Orders
WHERE [Status] = 'COMPLETED';

--Hiển thị tất cả các đơn hàng có trạng thái là COMPLETED trong ngày hôm nay
SELECT *
FROM Orders
WHERE 
	[Status] = 'COMPLETED' 
	AND CONVERT(date, [CreatedDate]) = CONVERT(date, GETDATE());

--Hiển thị tất cả các đơn hàng chưa hoàn thành trong tháng này
SELECT *
FROM Orders
WHERE 
	[Status] <> 'COMPLETED' 
	AND MONTH(CreatedDate) = MONTH(GETDATE());

--Hiển thị tất cả các đơn hàng có trạng thái là CANCELED
SELECT *
FROM Orders
WHERE [Status] = 'CANCELED';

--Hiển thị tất cả các đơn hàng có trạng thái là CANCELED trong ngày hôm nay
SELECT *
FROM Orders
WHERE 
	[Status] = 'CANCELED' 
	AND CONVERT(date, [CreatedDate]) = CONVERT(date, GETDATE());

--Hiển thị tất cả các đơn hàng có trạng thái là COMPLETED trong tháng này
SELECT *
FROM Orders
WHERE 
	[Status] = 'COMPLETED' 
	AND MONTH(CreatedDate) = MONTH(GETDATE());

--Hiển thị tất cả các đơn hàng có trạng thái là COMPLETED trong tháng 1 năm 2021
SELECT *
FROM Orders
WHERE 
	[Status] = 'COMPLETED' 
	AND MONTH(CreatedDate) = 1
	AND YEAR(CreatedDate) = 2021;
	--AND CreatedDate >= DATEFROMPARTS(2021, 1, 1)
	--AND CreatedDate < DATEFROMPARTS(2021, 2, 1); hàm DATEFROMPARTS để tạo ra một ngày bất kỳ trong tháng đó để so sánh với trường CreatedDate.

--Hiển thị tất cả các đơn hàng có trạng thái là COMPLETED trong năm 2021
SELECT *
FROM Orders
WHERE 
	[Status] = 'COMPLETED' 
	AND YEAR(CreatedDate) = 2021;
	--AND CreatedDate >= DATEFROMPARTS(2021, 1, 1)
	--AND CreatedDate < DATEFROMPARTS(2022, 1, 1);

--Hiển thị tất cả các đơn hàng có hình thức thanh toán là CASH
SELECT *
FROM Orders
WHERE 
	[PaymentType] = 'CASH';

--Hiển thị tất cả các đơn hàng có hình thức thanh toán là CREADIT CARD
SELECT *
FROM Orders
WHERE 
	[PaymentType] = 'CREDIT CARD';

--Hiển thị tất cả các đơn hàng có địa chỉ giao hàng là HCM
SELECT *
FROM Orders
WHERE 
	[ShippingCity] like '%HCM%';

--Hiển thị tất cả các nhân viên có sinh nhật là tháng này
SELECT *
FROM Employees
WHERE 
	DAY(GETDATE()) = DAY(Birthday) 
	AND MONTH(GETDATE()) = MONTH(Birthday);

--Hiển thị tất cả các nhà cung cấp có tên là: (Dell, Samsung, LG, Apple)
SELECT *
FROM Suppliers
WHERE [Names] LIKE '%Dell%' OR [Names] LIKE '%Samsung%' OR [Names] LIKE '%LG%' OR [Names] LIKE '%Apple%';

--Hiển thị tất cả các nhà cung cấp không có tên là: (Samsung, Apple)
SELECT *
FROM Suppliers
WHERE [Names] NOT LIKE '%Samsung%' AND [Names] NOT LIKE '%Apple%';

--Hiển thị tất cả các nhà cung cấp có địa chỉ ở Quận Hải Châu và Quận Thanh Khê.
SELECT *
FROM Suppliers
WHERE [Address] LIKE N'%Hải Châu%' AND [Address] LIKE N'%Sơn Trà%';

--Hiển thị tất cả các nhà cung cấp có địa chỉ ở Quận Hải Châu hoặc Quận Thanh Khê.
SELECT *
FROM Suppliers
WHERE [Address] LIKE N'%Hải Châu%' OR [Address] LIKE N'%Sơn Trà%';

--Hiển thị tất cả các khách hàng có sinh nhật là ngày hôm nay.
SELECT *
FROM Customers
WHERE 
	DAY(GETDATE()) = DAY(Birthday) 
	AND MONTH(GETDATE()) = MONTH(Birthday);

--Hiển thị xem có bao nhiêu mức giảm giá khác nhau.
SELECT COUNT(DISTINCT [Discount]) AS NumberOfDiscounts
FROM Products

--Hiển thị xem có bao nhiêu mức giảm giá khác nhau và số lượng mặt hàng có mức giảm giá đó.
SELECT 
	Discount AS [Giảm giá],  
	COUNT(*) AS [Số lượng sp có mức giảm giá đó],
	SUM(Stock) AS [Số lượng mặt hàng tồn kho]
FROM Products
GROUP BY Discount;

--Hiển thị xem có bao nhiêu mức giảm giá khác nhau và số lượng mặt hàng có mức giảm giá đó, sắp xếp theo số lượng giảm giá giảm dần.
SELECT 
	Discount AS [Giảm giá],  
	COUNT(*) AS [Số lượng sp có mức giảm giá đó],
	SUM(Stock) AS [Số lượng mặt hàng tồn kho]
FROM Products
GROUP BY Discount
ORDER BY Discount DESC;

--Hiển thị xem có bao nhiêu mức giảm giá khác nhau và số lượng mặt hàng có mức giảm giá đó, 
--sắp xếp theo số lượng giảm giá tăng dần, chỉ hiển thị các mức giảm giá có số lượng mặt hàng >= 5
SELECT 
	Discount AS [Giảm giá],  
	COUNT(*) AS [Số lượng sp có mức giảm giá đó],
	SUM(Stock) AS [Số lượng mặt hàng tồn kho]
FROM Products
GROUP BY Discount
HAVING SUM(Stock) >= 150
ORDER BY COUNT(*) ASC;

--Hiển thị xem có bao nhiêu mức tuổi khác nhau của khách hàng và số lượng khách hàng có mức tuổi đó, sắp xếp theo số lượng khách hàng tăng dần.
SELECT 
	DATEDIFF(YEAR, Birthday, GETDATE()) AS [Tuổi],  
	COUNT(*) AS [Số lượng khách hàng]
FROM Customers
GROUP BY DATEDIFF(YEAR, Birthday, GETDATE())
ORDER BY DATEDIFF(YEAR, Birthday, GETDATE()) ASC;

--Hiển thị xem có bao nhiêu mức tuổi khác nhau của nhân viên và số lượng nhân viên có mức tuổi đó, sắp xếp theo số lượng nhân viên giảm dần.
SELECT 
	DATEDIFF(YEAR, Birthday, GETDATE()) AS [Tuổi],  
	COUNT(*) AS [Số lượng nhân viên]
FROM Employees
GROUP BY DATEDIFF(YEAR, Birthday, GETDATE())
ORDER BY DATEDIFF(YEAR, Birthday, GETDATE()) ASC;

--Hiển thị số lượng đơn hàng theo từng ngày khác nhau sắp xếp theo số lượng đơn hàng giảm dần.
SELECT 
    CAST(CreatedDate AS DATE) AS OrderDate, 
    COUNT(*) AS NumberOfOrders
FROM 
    Orders
GROUP BY 
    CAST(CreatedDate AS DATE)
ORDER BY 
    COUNT(*) DESC;

--Hiển thị số lượng đơn hàng theo từng tháng khác nhau sắp xếp theo số lượng đơn hàng giảm dần.
SELECT 
    YEAR(CreatedDate) AS OrderYear,
    MONTH(CreatedDate) AS OrderMonth,
    COUNT(*) AS NumberOfOrders
FROM 
    Orders
GROUP BY 
    YEAR(CreatedDate),
    MONTH(CreatedDate)
ORDER BY 
    COUNT(*) DESC;
--Hiển thị số lượng đơn hàng theo từng năm khác nhau sắp xếp theo số lượng đơn hàng giảm dần.
SELECT 
    YEAR(CreatedDate) AS OrderYear,
    COUNT(*) AS NumberOfOrders
FROM 
    Orders
GROUP BY 
    YEAR(CreatedDate)
ORDER BY 
    COUNT(*) DESC;