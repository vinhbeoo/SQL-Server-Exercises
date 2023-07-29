--1.Hiển thị tất cả các mặt hàng cùng với CategoryName.
SELECT
	P.*, 
	C.Name AS [CatagoryName]
FROM
	Products AS P
	INNER JOIN Categories AS C ON P.CategoryId = C.Id;

--2.Hiển thị tất cả các mặt hàng cùng với SupplierName.
SELECT
	P.*,
	S.Names AS SupplierName
FROM
	Products AS P
	INNER JOIN Suppliers AS S ON P.SupplierId = S.Id;

--3.Hiển thị tất cả các mặt hàng cùng với thông tin chi tiết của Category và Supplier.
SELECT
	P.*, 
	C.Name AS [CatagoryName],
	S.Names AS SupplierName,
	S.Email AS SupplierEmail,
	S.Address AS SupplierAddress,
	S.PhoneNumber AS SupplierPhoneNumber
FROM
	Products AS P
	INNER JOIN Categories AS C ON P.CategoryId = C.Id
	INNER JOIN Suppliers AS S ON P.SupplierId = S.Id;

--4.Hiển thị tất cả các đơn hàng cùng với thông tin chi tiết khách hàng Customer.
SELECT
	O.*, 
	CM.FirstName AS CustomerFirstName,
	CM.LastName AS CustomerLastName,
	CM.PhoneNumber AS CustomerPhoneNumber
FROM
	Orders AS O
	INNER JOIN Customers AS CM ON O.CustomerId = CM.Id

--5.Hiển thị tất cả các đơn hàng cùng với thông tin chi tiết nhân viên Employee.
SELECT
	O.*, 
	E.FirstName AS EmployeeFirstName,
	E.LastName AS EmployeeLastName,
	E.PhoneNumber AS EmployeePhoneNumber
FROM
	Orders AS O
	INNER JOIN Employees AS E ON O.EmployeeId = O.Id

--6.Hiển thị tất cả các đơn hàng cùng với thông tin chi tiết khách hàng Customer và nhân viên Employee.
SELECT
	O.*, 
	CM.FirstName AS CustomerFirstName,
	CM.LastName AS CustomerLastName,
	CM.PhoneNumber AS CustomerPhoneNumber,
	E.FirstName AS EmployeeFirstName,
	E.LastName AS EmployeeLastName,
	E.PhoneNumber AS EmployeePhoneNumber
FROM
	Orders AS O
	INNER JOIN Customers AS CM ON O.CustomerId = CM.Id
	INNER JOIN Employees AS E ON O.EmployeeId = O.Id

--7.Hiển thị tất cả danh mục (Categories) với số lượng hàng hóa trong mỗi danh mục

--a) Dùng INNER JOIN + GROUP BY với lệnh COUNT
SELECT
	C.Name,
	COUNT(P.CategoryId)
FROM
	Categories AS C
	INNER JOIN Products AS P ON C.Id = P.CategoryId
	GROUP BY C.Name

--b) Dùng SubQuery với lệnh COUNT
SELECT c.Name, 
	(
    SELECT 
		COUNT(*)
		FROM Products p
		WHERE p.CategoryId = c.Id
	) AS TotalProducts
FROM Categories c

--8.Hiển thị tất cả nhà cung cấp (Suppliers) với số lượng hàng hóa mỗi nhà cung cấp

--a) Dùng INNER JOIN + GROUP BY với lệnh COUNT
SELECT
	S.Names,
	COUNT(P.SupplierId) AS [Số lượng]
FROM
	Suppliers AS S
	INNER JOIN Products AS P ON S.Id = P.SupplierId
	GROUP BY S.Names

--b) Dùng SubQuery với lệnh COUNT
SELECT 
	S.Names, 
	(
    SELECT 
		COUNT(*)
		FROM Products AS P
		WHERE P.SupplierId = S.Id
	) AS TotalProducts
FROM Suppliers AS S

--9.Hiển thị tất cả các mặt hàng được bán trong khoảng từ ngày, đến ngày
SELECT 
	P.*,
	O.CreatedDate AS [NGÀY BÁN]
FROM 
	Orders AS O
		INNER JOIN OrderDetails AS OD ON OD.OrderId = O.Id
		INNER JOIN Products AS P ON P.Id = OD.ProductId
WHERE 
	(O.CreatedDate BETWEEN '2023-05-20' AND '2023-05-30')
	AND (O.Status = 'COMPLETED')

--10.Hiển thị tất cả các khách hàng mua hàng trong khoảng từ ngày, đến ngày
SELECT 
	C.*,
	O.CreatedDate AS [NGÀY BÁN]
FROM 
	Customers AS C
		INNER JOIN Orders AS O ON O.CustomerId = C.Id
WHERE 
	(O.CreatedDate BETWEEN '2023-05-20' AND '2023-05-30')
	AND (O.Status = 'COMPLETED')

--11.Hiển thị tất cả các khách hàng mua hàng (với tổng số tiền) trong khoảng từ ngày, đến ngày
--Dùng INNER JOIN + GROUP BY với lệnh SUM
SELECT 
	C.FirstName,
	C.LastName,
	O.CreatedDate,
	SUM(OD.Quantity * P.Price * (1-OD.Discount)) AS MoneySum
FROM 
	Customers AS C
		INNER JOIN Orders AS O ON C.Id = O.CustomerId
		INNER JOIN OrderDetails AS OD ON O.Id = OD.OrderId
		INNER JOIN Products AS P ON OD.ProductId = P.Id
WHERE O.CreatedDate BETWEEN '2023-5-22' AND '2023-5-27'
GROUP BY
	C.FirstName, C.LastName, O.CreatedDate
	
--Dùng SubQuery với lệnh SUM
SELECT 
	C.FirstName,
	C.LastName,
	O.CreatedDate,
	(
		SELECT
			SUM(OD.Quantity * P.Price * (1-OD.Discount)) AS MoneySum
		FROM 
			OrderDetails AS OD
				INNER JOIN Products AS P ON OD.ProductId = P.Id
		WHERE 
			O.Id = OD.OrderId AND 
			O.CreatedDate BETWEEN '2023-5-22' AND '2023-5-27'
	) AS MoneySum
FROM
	Customers AS C
		INNER JOIN Orders AS O ON C.Id = O.CustomerId
WHERE 
	O.CreatedDate BETWEEN '2023-5-22' AND '2023-5-27'

--12.Hiển thị tất cả đơn hàng với tổng số tiền của đơn hàng đó
SELECT
	O.Id,
	O.Status,
	SUM(OD.Quantity * P.Price*(1-OD.Discount)) AS MoneySum
FROM
	Orders AS O
		INNER JOIN OrderDetails AS OD ON O.Id = OD.OrderId
		INNER JOIN Products AS P ON OD.ProductId = P.Id
GROUP BY O.Id, O.Status

SELECT 
	O.*,
	(
		SELECT
			SUM(OD.Quantity * P.Price * (1-OD.Discount))
		FROM
			OrderDetails AS OD
				INNER JOIN Products AS P ON OD.ProductId = P.Id
		WHERE
			OD.ProductId = P.Id 
			AND O.Id = OD.OrderId
	)
FROM
	Orders AS O
	
--13.Hiển thị tất cả các nhân viên bán hàng với tổng số tiền bán được
SELECT 
	E.FirstName,
	E.LastName,
	SUM(OD.Quantity * P.Price * (1-OD.Discount))
FROM
	Employees AS E
		INNER JOIN Orders AS O ON E.Id = O.EmployeeId
		INNER JOIN OrderDetails AS OD ON O.Id = OD.OrderId
		INNER JOIN Products AS P ON OD.ProductId = P.Id
GROUP BY E.FirstName, E.LastName

--14.Hiển thị tất cả các mặt hàng không bán được
--TH1: Tồn kho nhiều >= 100
SELECT
	*
FROM
	Products AS P
WHERE Stock >=100 
--TH2: Trạng thái đặt hàng bị Canceled
SELECT
	P.Names,
	O.Status
FROM
	Products AS P
		INNER JOIN OrderDetails AS OD ON P.Id = OD.ProductId
		INNER JOIN Orders AS O ON OD.OrderId = O.Id
WHERE O.Status = 'CANCELED' OR O.Status = 'WAITING'
--TH3: Sản phẩm không được đặt hàng
SELECT 
	*
FROM 
	Products
WHERE 
	Id NOT IN 
		(
			SELECT DISTINCT ProductId
			FROM OrderDetails
		)
--15.Hiển thị tất cả các nhà cung cấp không bán được trong khoảng từ ngày, đến ngày
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
    WHERE O.CreatedDate >= '2023-05-01' AND O.CreatedDate <= '2023-05-31'
)

--16.Hiển thị top 3 các nhân viên bán hàng với tổng số tiền bán được từ cao đến thấp trong khoảng từ ngày, đến ngày
SELECT
	TOP 3
		E.Id,
		E.FirstName, 
		E.LastName,
		SUM(OD.Quantity * P.Price * (1-OD.Discount)) AS MoneySum
FROM 
	Employees AS E
		INNER JOIN Orders AS O ON E.Id = O.EmployeeId
		INNER JOIN OrderDetails AS OD ON O.Id = OD.OrderId
		INNER JOIN Products AS P ON OD.ProductId = P.Id
WHERE
	E.Id IN 
	(
		SELECT DISTINCT 
			O.EmployeeId
		FROM 
			Orders
		WHERE 
			(O.CreatedDate >= '2023-05-01' AND O.CreatedDate <= '2023-05-31') 
			AND Status = 'COMPLETED'
	)
GROUP BY E.Id, E.FirstName, E.LastName
ORDER BY MoneySum DESC

--17.Hiển thị top 5 các khách hàng mua hàng với tổng số tiền mua được từ cao đến thấp trong khoảng từ ngày, đến ngày
SELECT TOP 5
	C.Id,
	C.FirstName,
	C.LastName,
	SUM(OD.Quantity * P.Price * (1-OD.Discount)) AS MoneySum
FROM
	Customers AS C
		INNER JOIN Orders AS O ON C.Id = O.CustomerId
		INNER JOIN OrderDetails AS OD ON O.Id = OD.OrderId
		INNER JOIN Products AS P ON OD.ProductId = P.Id
WHERE
	C.Id IN 
	(
		SELECT DISTINCT 
			O.CustomerId
		FROM 
			Orders
		WHERE O.CreatedDate >= '2023-05-01' AND O.CreatedDate <= '2023-05-31'
	)
GROUP BY C.Id, C.FirstName, C.LastName
ORDER BY MoneySum DESC

--18.Hiển thị danh sách các mức giảm giá của cửa hàng
SELECT DISTINCT 
	P.Discount
FROM
	Products AS P
ORDER BY P.Discount ASC

--19. Hiển thị tất cả danh mục (Categories) với tổng số tiền bán được trong mỗi danh mục
--Dùng INNER JOIN + GROUP BY với lệnh SUM
SELECT
	C.Name,
	C.Description,
	SUM(OD.Quantity * P.Price * (1-OD.Discount)) AS MoneySum
FROM
	Categories AS C
		INNER JOIN Products AS P ON C.Id = P.CategoryId
		INNER JOIN OrderDetails AS OD ON P.Id = OD.ProductId
GROUP BY C.Name, C.Description

--Dùng SubQuery với lệnh SUM
SELECT 
	C.Name,
	C.Description,
	(
		SELECT
			SUM(OD.Quantity * P.Price * (1-OD.Discount)) 
		FROM 
			Products AS P
				INNER JOIN OrderDetails AS OD ON P.Id = OD.ProductId
		WHERE  P.CategoryId = C.Id
	) AS MoneySum
FROM
	Categories AS C

--25.Hiển thị tất cả đơn hàng với tổng số tiền mà đã được giao hàng thành công trong khoảng từ ngày, đến ngày
SELECT
	O.Id,
	O.CreatedDate,
	O.Status,
	SUM(OD.Quantity * P.Price * (1-OD.Discount)) AS MoneySum
FROM
	Orders AS O
	INNER JOIN OrderDetails AS OD ON O.Id = OD.OrderId
	INNER JOIN Products AS P ON OD.ProductId = P.Id
WHERE 
	O.Status = 'COMPLETED' 
	AND O.CreatedDate BETWEEN '2023-05-01' AND '2023-05-31'
GROUP BY O.Id, O.CreatedDate, O.Status

--21.Hiển thị tất cả đơn hàng có tổng số tiền bán hàng nhiều nhất trong khoảng từ ngày, đến ngày
SELECT TOP 3
	O.Id,
	O.CreatedDate,
	O.Status,
	SUM(OD.Quantity * P.Price * (1-OD.Discount)) AS MoneySum
FROM
	Orders AS O
	INNER JOIN OrderDetails AS OD ON O.Id = OD.OrderId
	INNER JOIN Products AS P ON OD.ProductId = P.Id
WHERE 
	O.CreatedDate BETWEEN '2023-05-01' AND '2023-05-31'
GROUP BY O.Id, O.CreatedDate, O.Status

--22.Hiển thị tất cả đơn hàng có tổng số tiền bán hàng ít nhất trong khoảng từ ngày, đến ngày
SELECT TOP 3
	O.Id,
	O.CreatedDate,
	O.Status,
	SUM(OD.Quantity * P.Price * (1-OD.Discount)) AS MoneySum
FROM
	Orders AS O
	INNER JOIN OrderDetails AS OD ON O.Id = OD.OrderId
	INNER JOIN Products AS P ON OD.ProductId = P.Id
WHERE 
	O.CreatedDate BETWEEN '2023-05-01' AND '2023-05-31'
GROUP BY O.Id, O.CreatedDate, O.Status
ORDER BY MoneySum ASC

--23.Hiển thị trung bình cộng giá trị các đơn hàng trong khoảng từ ngày, đến ngày
SELECT 
	AVG(TotalAmount) AS AverageAmount
FROM (
	SELECT 
		SUM(OD.Quantity * P.Price * (1-OD.Discount)) AS TotalAmount
	FROM 
		Orders AS O
			INNER JOIN OrderDetails AS OD ON O.Id = OD.OrderId
			INNER JOIN Products AS P ON OD.ProductId = P.Id
	WHERE 
		O.CreatedDate BETWEEN '2023-05-01' AND '2023-05-31'
	GROUP BY O.Id
) AS OrderAmounts

--24.Hiển thị các đơn hàng có giá trị cao nhất
	SELECT TOP 1
		OD.OrderId,
		SUM(OD.Quantity * P.Price * (1 - OD.Discount)) AS Total
	FROM 
		OrderDetails AS OD
			INNER JOIN Products AS P ON OD.ProductId = P.Id
	GROUP BY 
		OD.OrderId
	ORDER BY Total DESC

SELECT 
	MAX(TotalAmount) AS MaxAmount
FROM (
SELECT 
		SUM(OD.Quantity * P.Price * (1-OD.Discount)) AS TotalAmount
	FROM 
		Orders AS O
			INNER JOIN OrderDetails AS OD ON O.Id = OD.OrderId
			INNER JOIN Products AS P ON OD.ProductId = P.Id
	WHERE 
		O.CreatedDate BETWEEN '2023-05-01' AND '2023-05-31'
	GROUP BY O.Id
	) AS OrderAmounts

--25.Hiển thị các đơn hàng có giá trị thấp nhất
SELECT 
	MIN(TotalAmount) AS MinAmount
FROM (
SELECT 
		SUM(OD.Quantity * P.Price * (1-OD.Discount)) AS TotalAmount
	FROM 
		Orders AS O
			INNER JOIN OrderDetails AS OD ON O.Id = OD.OrderId
			INNER JOIN Products AS P ON OD.ProductId = P.Id
	WHERE 
		O.CreatedDate BETWEEN '2023-05-01' AND '2023-05-31'
	GROUP BY O.Id
	) AS OrderAmounts