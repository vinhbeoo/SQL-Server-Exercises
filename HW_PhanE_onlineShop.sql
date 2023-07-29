--1.Hiển thị danh sách các mức giảm giá của cửa hàng cùng với số lượng mặt hàng được giảm giá đó, gồm các fields: Discount, NumberOfProducts, Total.
	--Tạo view hiển thị
CREATE  VIEW P_DiscountOfStore
AS
SELECT DISTINCT
	P.Discount,
	COUNT(P.Id) AS NumberProducts,
	COUNT(P.Stock) AS Total
FROM
	Products AS P
GROUP BY P.Discount

	--Sử dụng view
SELECT * FROM P_DiscountOfStore

--2.Hiển thị tất cả các mặt hàng cùng với thông tin chi tiết của Category và Supplier gồm các fields: Id, Name, Price, Discount, CategoryId, CategoryName, SupplierId, SupplierName.
	--Tạo view
CREATE VIEW V_CategorySupplierDetail
AS
SELECT
	P.Id,
	P.Names,
	P.Price,
	P.Discount,
	CA.Id AS CategoryId,
	CA.Name AS CategoryNames,
	S.Id AS SupplierId,
	S.Names AS SupplierName
FROM
	Products AS P
		INNER JOIN Suppliers AS S ON P.SupplierId = S.Id
		INNER JOIN Categories AS CA ON P.CategoryId = CA.Id

	--Sử dụng view
SELECT * FROM V_CategorySupplierDetail

--3.Hiển thị tất cả các đơn hàng cùng với thông tin chi tiết khách hàng Customer và Employee gồm các fields: Id, OrderDate, Status, CustomerId, CustomerName, CustomerAddress, CustomerPhone, EmployeeId, EmployeeName, EmployeeAddress, EmployeePhone, Total.
	--Tạo view
CREATE VIEW V_OderCustomerEmployee
AS
SELECT
	O.Id,
	O.CreatedDate,
	O.Status,
	C.Id AS CustomerId,
	CONCAT(C.FirstName, ' ', C.LastName) AS CustomerName,
	C.Addres AS CustomerAddress,
	C.PhoneNumber AS CustomerPhone,
	E.Id AS EmployeeId,
	CONCAT(E.FirstName, ' ', E.LastName) AS EmployeeName,
	E.Addres AS EmployeeAddress,
	E.PhoneNumber AS EmployeePhone,
	COUNT(O.Id) AS Total
FROM
	Orders AS O
		INNER JOIN Customers AS C ON O.CustomerId = C.Id
		INNER JOIN Employees AS E ON O.EmployeeId = E.Id
GROUP BY 
	O.Id,
	O.CreatedDate,
	O.Status,
	C.Id ,
	CONCAT(C.FirstName, ' ', C.LastName) ,
	C.Addres,
	C.PhoneNumber ,
	E.Id ,
	CONCAT(E.FirstName, ' ', E.LastName),
	E.Addres ,
	E.PhoneNumber

	--Sử dụng View
SELECT * FROM V_OderCustomerEmployee

--4.Hiển thị tất cả danh mục (Categories) với số lượng hàng hóa trong mỗi danh mục, gồm các fields: Id, Name, Description, NumberOfProducts.
--a.Dùng INNER JOIN + GROUP BY với lệnh COUNT
CREATE VIEW V_Categories
AS
SELECT
	C.Id,
	C.Name,
	C.Description,
	COUNT(P.CategoryId) AS NumberOfProducts
FROM 
	Categories AS C
		INNER JOIN Products AS P ON C.Id = P.CategoryId
GROUP BY C.Id, C.Name, C.Description

SELECT * FROM V_Categories

--b.Dùng SubQuery với lệnh COUNT
CREATE VIEW V_Categories1
AS
SELECT
	C.Id,
	C.Name,
	C.Description,
	(
		SELECT
			COUNT(P.CategoryId) AS NumberOfProducts
		FROM 
			Products AS P
		WHERE
			C.Id = P.CategoryId
	) AS NumberOfProducts
FROM
	Categories AS C
GROUP BY C.Id, C.Name, C.Description

SELECT * FROM V_Categories1

--5.Hiển thị tất cả nhà cung cấp (Suppliers) với số lượng hàng hóa mỗi nhà cung cấp, gồm các fields: Id, Name, Address, PhoneNumber, NumberOfProducts.
	--a.Dùng INNER JOIN + GROUP BY với lệnh COUNT
CREATE VIEW V_Suppliers
AS
SELECT
	S.Id,
	S.Names,
	S.Address,
	S.PhoneNumber,
	COUNT(P.SupplierId) AS NumberOfProducts
FROM
	Suppliers AS S
		INNER JOIN Products AS P ON S.Id = P.SupplierId
GROUP BY 
	S.Id,
	S.Names,
	S.Address,
	S.PhoneNumber

SELECT * FROM V_Suppliers

	--b.Dùng SubQuery với lệnh COUNT
CREATE VIEW V_Suppliers1
AS
SELECT
	S.Id,
	S.Names,
	S.Address,
	S.PhoneNumber,
	(
		SELECT
			COUNT(P.SupplierId) AS NumberOfProducts
		FROM
			Products AS P
		WHERE 
			P.SupplierId = S.Id
	) AS NumberOfProducts
FROM
	Suppliers AS S
GROUP BY 
	S.Id,
	S.Names,
	S.Address,
	S.PhoneNumber

SELECT * FROM V_Suppliers1

--6.Hiển thị tất cả các khách hàng mua hàng với tổng số tiền mua hàng, gồm các fields: Id, Name, Address, PhoneNumber, Total
	--a.Dùng INNER JOIN + GROUP BY với lệnh SUM
CREATE VIEW V_CustomerMoneySum
AS
SELECT
	C.Id,
	C.FirstName + ' ' +C.LastName AS FullName,
	C.Addres,
	C.PhoneNumber,
	SUM(OD.Quantity * P.Price * (1-OD.Discount)) AS TotalMoney
FROM
	Customers AS C
		INNER JOIN Orders AS O ON C.Id = O.CustomerId
		INNER JOIN OrderDetails AS OD ON O.Id = OD.OrderId
		INNER JOIN Products AS P ON OD.ProductId = P.Id
GROUP BY 
	C.Id,
	C.FirstName + ' ' +C.LastName,
	C.Addres, 
	C.PhoneNumber

SELECT * FROM V_CustomerMoneySum
	--b.Dùng SubQuery với lệnh SUM
CREATE VIEW V_CustomerMoneySum1
AS
SELECT 
	C.Id,
	C.FirstName,
	C.LastName,
	C.Addres,
	C.PhoneNumber,
	(
		SELECT
			SUM(OD.Quantity * P.Price * (1-OD.Discount)) AS Total
		FROM
			OrderDetails AS OD
				INNER JOIN Orders AS O ON OD.OrderId = O.Id
				INNER JOIN Products AS P ON OD.ProductId = P.Id
		WHERE C.Id = O.CustomerId
	) AS TotalMoney
FROM
	Customers AS C
GROUP BY
	C.Id,
	C.FirstName,
	C.LastName,
	C.Addres,
	C.PhoneNumber

SELECT * FROM V_CustomerMoneySum1

--7.Hiển thị tất cả các nhân viên bán hàng với tổng số tiền bán được, gồm các fields: Id, Name, Address, PhoneNumber, Total.
	--a.Dùng INNER JOIN + GROUP BY với lệnh SUM
CREATE VIEW V_EmployeeMoneySum
AS
SELECT
	E.Id,
	E.FirstName,
	E.LastName,
	E.Addres,
	E.PhoneNumber,
	SUM(OD.Quantity * P.Price * (1-OD.Discount)) AS TotalMoney
FROM
	Employees AS E
		INNER JOIN Orders AS O ON E.Id = O.EmployeeId
		INNER JOIN OrderDetails AS OD ON O.Id = OD.OrderId
		INNER JOIN Products AS P ON OD.ProductId = P.Id
GROUP BY E.Id,E.FirstName, E.LastName, E.Addres, E.PhoneNumber

SELECT * FROM V_EmployeeMoneySum
	--b.Dùng SubQuery với lệnh SUM
CREATE VIEW V_EmployeeMoneySum1
AS
SELECT 
	E.Id,
	E.FirstName,
	E.LastName,
	E.Addres,
	E.PhoneNumber,
	(
		SELECT
			SUM(OD.Quantity * P.Price * (1-OD.Discount)) AS Total
		FROM
			OrderDetails AS OD
				INNER JOIN Orders AS O ON OD.OrderId = O.Id
				INNER JOIN Products AS P ON OD.ProductId = P.Id
		WHERE E.Id = O.EmployeeId
	) AS TotalMoney
FROM
	Employees AS E
GROUP BY E.Id, E.FirstName, E.LastName, E.Addres, E.PhoneNumber

SELECT * FROM V_CustomerMoneySum1

--8.Hiển thị tất cả các mặt hàng không bán được, gồm các fields: Id, Name, Price, Discount, CategoryId, CategoryName, SupplierId, SupplierName.
CREATE VIEW V_Product
AS
SELECT
	P.Id,
	P.Names,
	P.Price,
	P.Discount,
	C.Id AS CategoryId,
	C.Name AS CategoryName,
	S.Id AS SupplierId,
	S.Names AS SupplierName
FROM 
	Products AS P
		INNER JOIN Categories AS C ON P.CategoryId = C.Id
		INNER JOIN Suppliers AS S ON P.SupplierId = S.Id
		INNER JOIN OrderDetails AS OD ON P.Id = OD.ProductId
		INNER JOIN Orders AS O ON OD.OrderId = O.Id
WHERE 
	O.Status IN ('COMPLETED' , 'WAITING')

SELECT * FROM V_Product

--9.Hiển thị tất cả các nhà cung cấp không bán được, gồm các fields: Id, Name, Address, PhoneNumber.
CREATE VIEW V_Suppliercantnotsell
AS
SELECT
	S.Id,
	S.Names,
	S.Address,
	S.PhoneNumber
FROM
	Suppliers AS S
		INNER JOIN Products AS P ON S.Id = P.SupplierId
		INNER JOIN OrderDetails AS OD ON P.Id = OD.ProductId
		INNER JOIN Orders AS O ON OD.OrderId = O.Id
WHERE 
	O.Status IN ('COMPLETED' , 'WAITING')

SELECT * FROM V_Suppliercantnotsell

--10.Hiển thị tất cả các nhân viên không bán được hàng, gồm các fields: Id, Name, Address, PhoneNumber.Hiển thị tất cả các nhân viên không bán được hàng, gồm các fields: Id, Name, Address, PhoneNumber.
ALTER VIEW V_EmployeeCannotsell
AS
SELECT 
	*
FROM Employees
WHERE NOT EXISTS (
	SELECT DISTINCT
		O.EmployeeId
	FROM
		Orders AS O
	)

SELECT * FROM V_EmployeeCannotsell

	
