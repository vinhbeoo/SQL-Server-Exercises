INSERT INTO Categories ([Name], [Description])
VALUES ('Laptop', N'Các loại máy tính xách tay'),
       (N'Màn hình', N'Các loại màn hình cho laptop'),
       (N'Bàn phím', N'Các loại bàn phím cho laptop'),
       (N'Chuột', N'Các loại chuột cho laptop'),
       (N'Ổ cứng', N'Các loại ổ cứng cho laptop'),
       (N'RAM', N'Các loại RAM cho laptop'),
       (N'Card màn hình', N'Các loại card màn hình cho laptop'),
       (N'Mainboard', N'Các loại mainboard cho laptop'),
       (N'CPU', N'Các loại CPU cho laptop'),
       (N'Phụ kiện khác', N'Các phụ kiện phục vụ cho việc sử dụng laptop, như túi đựng, đế tản nhiệt, chuột không dây, ...')

DBCC CHECKIDENT ('Categories', RESEED, 0);

INSERT INTO Suppliers (Names, Email, PhoneNumber, Address)
	VALUES 
		(N'Công ty TNHH Thiết bị máy tính Dell', 'info@dell.com', '024-123-4567', N'123 Đường Lê Lợi, Quận Hoàn Kiếm, Hà Nội'),
		(N'Công ty TNHH Thiết bị máy tính HP', 'info@hp.com', '022-345-6789', N'456 Đường Trần Hưng Đạo, Quận Ngô Quyền, Hải Phòng'),
		(N'Công ty TNHH Thiết bị máytính Lenovo', 'info@lenovo.com', '023-456-7890', N'789 Đường Phạm Văn Đồng, Quận Sơn Trà, Đà Nẵng'),
		(N'Công ty TNHH Thiết bị máy tính Asus', 'info@asus.com', '028-901-2345', N'101 Đường Nguyễn Thị Minh Khai, Quận 1, Thành phố Hồ Chí Minh'),
		(N'Công ty TNHH Thiết bị máy tính Acer', 'info@acer.com', '028-567-8901', N'456 Đường Lê Văn Việt, Quận 9, Thành phố Hồ Chí Minh'),
		(N'Công ty TNHH Thiết bị điện tử Samsung', 'info@samsung.com', '024-567-8901', N'789 Đường Khuất Duy Tiến, Quận Thanh Xuân, Hà Nội'),
		(N'Công ty TNHH Thiết bị điện tử LG', 'info@lg.com', '028-234-5678', N'101 Đường Nguyễn Thị Định, Quận 2, Thành phố Hồ Chí Minh'),
		(N'Công ty TNHH Công nghệ Intel', 'info@intel.com', '028-345-6789', N'123 Đường Trần Quốc Vượng, Quận 7, Thành phố Hồ Chí Minh'),
		(N'Công ty TNHH Công nghệ AMD', 'info@amd.com', '024-901-2345', N'456 Đường Lý Thường Kiệt, Quận Hoàn Kiếm, Hà Nội'),
		(N'Công ty TNHH Công nghệ Apple', 'Apple@nvidia.com', '028-456-7890', N'789 Đường Nguyễn Hữu Thọ, Quận 7, Thành phố Hồ Chí Minh');

INSERT INTO Customers (FirstName, LastName, PhoneNumber, Addres, Email, Birthday)
	VALUES 
		(N'Nguyễn', N'Văn Anh', '0987654321', N'123 Đường Lê Lợi, Quận Hoàn Kiếm, Hà Nội', 'nguyenvana@gmail.com', '1990-01-01'),
       (N'Trần', N'Thị Bình', '0987654322', N'456 Đường Trần Hưng Đạo, Quận Ngô Quyền, Hải Phòng', 'tranthib@gmail.com', '1995-02-02'),
       (N'Lê', N'Văn Chương', '0987654323', N'789 Đường Phạm Văn Đồng, Quận Sơn Trà, Đà Nng', 'levvanc@gmail.com', '1987-03-03'),
       (N'Nguyễn', N'Thị Diên', '0987654324', N'101 Đường Nguyễn Thị Minh Khai, Quận 1, Tp. Hồ Chí Minh', 'nguyenthid@gmail.com', '1999-04-04'),
       (N'Đỗ', N'Thị Thảo', '0987654325', N'456 Đường Lê Văn Việt, Quận 9, Thành phố Hồ Chí Minh', 'dothie@gmail.com', '1992-05-05'),
       (N'Phạm', N'Văn Phong', '0987654326', N'789 Đường Khuất Duy Tiến, Quận Thanh Xuân, Hà Nội', 'phamvanf@gmail.com', '1986-06-06'),
       (N'Trịnh', N'Thị Giang', '0987654327', N'101 Đường Nguyễn Thị Định, Quận 2, Thành phố Hồ Chí Minh', 'trinhthig@gmail.com', '1994-07-07'),
       (N'Nguyễn', N'Thị Hiền', '0987654328', N'123 Đường Trần Quốc Vượng, Quận 7, Thành phố Hồ Chí Minh', 'nguyenthih@gmail.com', '1989-08-08'),
       (N'Hoàng', N'Văn Thái', '0987654329', N'456 Đường Lý Thường Kiệt, Quận Hoàn Kiếm, Hà Nội', 'hoangvani@gmail.com', '1993-09-09'),
       (N'Nguyễn', N'Văn Bạn', '0987654330', N'789 Đường Nguyễn Hữu Thọ, Quận 7, Thành phố Hồ Chí Minh', 'nguyenvanj@gmail.com', '1991-10-10');

INSERT INTO Employees (FirstName, LastName, PhoneNumber, Addres, Email, Birthday)
	VALUES
		('Nguyễn', 'Văn Tấn', '0123456789', '123 Nguyen Van Linh, Da Nang, Viet Nam', 'nguyenvantan@gmail.com', '1990-01-01'),
		('Trần', 'Thị Bình', '0234567890', '456 Tran Phu, Da Nang, Viet Nam', 'tranthibinh@gmail.com', '1995-05-10'),
		('Lê', 'Thanh Chương', '0345678901', '789 Le Duan, Da Nang, Viet Nam', 'lethanhchuong@gmail.com', '1985-11-21'),
		('Phạm', 'Đình Dương', '0456789012', '321 Pham Van Dong, Da Nang, Viet Nam', 'phamdinhduong@gmail.com', '1992-07-15'),
		('Hoang', 'Thi Én', '0567890123', '654 Hoang Dieu, Da Nang, Viet Nam', 'hoangthien@gmail.com', '1988-03-30');

INSERT INTO Products (Names, Price, Discount, Stock, CategoryId, SupplierId, Descriptions)
	VALUES
		(N'Laptop Lenovo Thinkpad X1 Carbon', 26990000, 0.05, 100, 1, 3, N'Laptop Lenovo Thinkpad X1 Carbon (2018), CPU Intel Core i5-8250U, RAM 8GB, Ổ cứng SSD 512GB'),
		(N'Laptop DELL XPS 15', 28490000, 0.10, 50, 1, 1, N'Laptop DELL XPS 15, CPU Intel Core i7-8750H, RAM 16GB, Card màn hình NVIDIA GeForce GTX 1050Ti 4GB, Ổ cứng SSD 512GB'),
		(N'Laptop HP Spectre x360', 31990000, 0.20, 20, 1, 2, N'Laptop HP Spectre x360, CPU Intel Core i7-8565U, RAM 16GB, Ổ cứng SSD 1TB, màn hình cảm ứng 13.3 inch'),
		(N'Điện thoại Samsung Galaxy S10', 16490000, 0.15, 100, 2, 4, N'Điện thoại Samsung Galaxy S10, màn hình 6.1 inch, RAM 8GB, bộ nhớ trong 128GB, hệ điều hành Android 9.0 (Pie)'),
		(N'Tai nghe Airpods Pro', 8490000, 0.10, 50, 3, 5, N'Tai nghe Airpods Pro của Apple, âm thanh âm vòm, chống ồn, kháng nước'),
		(N'Ổ cứng HDD Seagate 1TB', 299000, 0.20, 200, 4, 6, N'Ổ cứng HDD Seagate Barracuda, dung lượng 1TB, giao tiếp SATA 3.0'),
		(N'Chuột không dây Logitech M170', 159000, 0.25, 500, 5, 7, N'Chuột không dây Logitech M170, kết nối 2.4 GHz, phản hồi tức thì, thời gian sử dụng pin kéo dài đến 12 tháng'),
		(N'Bàn phím cơ HyperX Alloy FPS Pro', 990000, 0.10, 100, 6, 8, N'Bàn phím cơ HyperX Alloy FPS Pro, công nghệ Cherry MX, đèn nền đỏ'),
		(N'Màn hình ASUS VG248QE 24', 4490000, 0.15, 50, 7, 9, N'Màn hình ASUS VG248QE 24 inch, độ phân giải Full HD 1920x1080, tần số qué0t 144Hz, thời gian đáp ứng 1ms'),
		(N'Bộ vi xử lý Intel Core i5-9400F', 4490000, 0.20, 20, 8, 10, N'Bộ vi xử lý Intel thế hệ thứ 9 Core i5-9400F, 6 nhân 6 luồng, tốc độ xung nhịp 2.9GHz')

INSERT INTO [Orders] (CreatedDate, ShippedDate, [Status], [Description], ShippingAddress, ShippingCity, PaymentType, CustomerId, EmployeeId)
	VALUES
		('2023-05-20 10:00:00', '2023-05-28 10:00:00', 'COMPLETED', N'Đơn hàng số 1', '123 Đường A, Quận 1', 'TP.HCM', 'CREDIT CARD', 1, 2),
		('2023-05-21 11:00:00', NULL, 'WAITING', 'Đơn hàng số 2', N'456 Đường B, Quận 2', 'TP.HCM', 'CASH', 2, 3),
		('2023-05-22 12:00:00', '2023-05-27 12:00:00', 'COMPLETED', N'Đơn hàng số 3', '789 Đường C, Quận 3', 'TP.HCM', 'CASH', 3, 1),
		('2023-05-24 14:00:00', NULL, 'WAITING', 'Đơn hàng số 5', N'1213 Đường E, Quận 5', 'TP.HCM', 'CREDIT CARD', 1, 2),
		('2023-05-25 15:00:00', NULL, 'WAITING', 'Đơn hàng số 6', N'1415 Đường F, Quận 6', 'TP.HCM', 'CASH', 2, 3),
		('2023-05-26 16:00:00', NULL, 'WAITING', 'Đơn hàng số 7', N'1617 Đường G, Quận 7', 'TP.HCM', 'CASH', 3, 1),
		('2023-05-27 17:00:00', NULL, 'WAITING', 'Đơn hàng số 8', N'1819 Đường H, Quận 8', 'TP.HCM', 'CREDIT CARD', 1, 2),
		('2023-05-28 18:00:00', NULL, 'WAITING', 'Đơn hàng số 9', N'2021 Đường I, Quận9', 'TP.HCM', 'CASH', 2, 3),
		('2023-05-29 19:00:00', NULL, 'WAITING', 'Đơn hàng số 10', N'2223 Đường J, Quận 10', 'TP.HCM', 'CASH', 3, 1);

INSERT INTO OrderDetails (OrderId, ProductId, Quantity, Price, Discount)
	VALUES
		(2, 3, 2, 6400000, 0.05),
		(3, 5, 1, 8450000, 0.1),
		(5, 8, 3, 2700000, 0.1),
		(6, 7, 1, 159000, 0.25),
		(10, 9, 1, 4490000, 0.15);

