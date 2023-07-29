CREATE DATABASE Education

--TẠO BẢNG
USE Education
GO

CREATE TABLE Teachers
(
	Id INT PRIMARY KEY IDENTITY(1,1),
	FirstName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL,
	Gender 	BIT NOT NULL,
	Email VARCHAR(50) UNIQUE NOT NULL,
	PhoneNumber VARCHAR(50) UNIQUE NULL,
	[Address] NVARCHAR(500) NULL,
	DateOfBirth DATETIME NULL
)

CREATE TABLE Students
(
	Id INT PRIMARY KEY IDENTITY(1,1),
	FirstName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL,
	Gender 	BIT NOT NULL,
	Email VARCHAR(50) UNIQUE NOT NULL,
	PhoneNumber VARCHAR(50) UNIQUE NULL,
	[Address] NVARCHAR(500) NULL,
	DateOfBirth DATETIME NULL
)

CREATE TABLE Employees
(
	Id INT PRIMARY KEY IDENTITY(1,1),
	FirstName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL,
	Gender 	BIT NOT NULL,
	Email VARCHAR(50) UNIQUE NOT NULL,
	PhoneNumber VARCHAR(50) UNIQUE NULL,
	[Address] NVARCHAR(500) NULL,
	DateOfBirth DATETIME NULL
)

CREATE TABLE Classes
(
	Id INT PRIMARY KEY IDENTITY(1,1),
	[Name] NVARCHAR(50) UNIQUE NOT NULL,
	[Description] NVARCHAR(500) NULL,
	StartDate DATETIME NOT NULL,
	EndDate DATETIME NOT NULL,
	CONSTRAINT CHK_Date CHECK (StartDate <= EndDate)
)

CREATE TABLE Classes_Students
(
	ClassId INT FOREIGN KEY (ClassId) REFERENCES Classes(Id),
	StudentId INT FOREIGN KEY (StudentId) REFERENCES Students(Id)
)

CREATE TABLE Classes_Teachers
(
	ClassId INT FOREIGN KEY (ClassId) REFERENCES Classes(Id),
	TeacherId INT FOREIGN KEY (TeacherId) REFERENCES Teachers(Id)
)

CREATE TABLE Subjects
(
	Id INT PRIMARY KEY IDENTITY(1,1),
	[Name] NVARCHAR(100) UNIQUE NOT NULL,
	[Description] NVARCHAR(500) NULL
)

CREATE TABLE Subjects_Teachers
(
	SubjectId INT FOREIGN KEY (SubjectId) REFERENCES Subjects(Id),
	TeacherId INT FOREIGN KEY (TeacherId) REFERENCES Teachers(Id)
)

CREATE TABLE Marks
(
	Id INT PRIMARY KEY IDENTITY(1,1),
	StudentId INT FOREIGN KEY (StudentId) REFERENCES Students(Id),
	SubjectId INT FOREIGN KEY (SubjectId) REFERENCES Subjects(Id),
	Mark DECIMAL(5,2) DEFAULT(0) CHECK(Mark >= 0 AND Mark <= 10),
	[Date] DATETIME DEFAULT(GETDATE())
)

CREATE TABLE AttendanceTypes
(
	Id INT PRIMARY KEY IDENTITY(1,1),
	[Name] NVARCHAR(100) UNIQUE NOT NULL,
	[Description] NVARCHAR(500) NULL
)

CREATE TABLE Attendances
(
	Id INT PRIMARY KEY IDENTITY(1,1),
	StudentId INT FOREIGN KEY (StudentId) REFERENCES Students(Id) NOT NULL,
	SubjectId INT FOREIGN KEY (SubjectId) REFERENCES Subjects(Id) NOT NULL,
	AttendanceTypeId INT FOREIGN KEY (AttendanceTypeId) REFERENCES AttendanceTypes(Id) NOT NULL,
	[Date] DATETIME DEFAULT(GETDATE()),
	[Description] NVARCHAR(500) NULL
)

CREATE TABLE Tuitions
(
	Id INT PRIMARY KEY IDENTITY(1,1),
	StudentId INT FOREIGN KEY (StudentId) REFERENCES Students(Id) NOT NULL,
	InvoiceCode VARCHAR(10) UNIQUE NOT NULL,
	InvoiceDate DATETIME DEFAULT(GETDATE()) NOT NULL,
	Amount DECIMAL(18,2) CHECK(Amount > 0) NOT NULL,
	EmployeeId INT FOREIGN KEY (EmployeeId) REFERENCES Employees(Id) NOT NULL,
	[Description] NVARCHAR(500) NULL
)

--THÊM DỮ LIỆU VÀO CÁC BẢNG
INSERT INTO [Teachers] (FirstName, LastName, Gender, Email, PhoneNumber, Address, DateOfBirth)
VALUES
	(N'Lê', N'Hải Hùng', 1, 'lehaihung@gmail.com', '0365216487', N'Hải Châu, Đà Nẵng', '1999-05-06'),
	(N'Trần', N'Thị Ngọc', 0, 'tranthingoc@gmail.com', '0912345678', N'Hải Châu, Đà Nẵng', '1998-06-07'),
	(N'Nguyễn', N'Văn Anh', 1, 'nguyenvananh@gmail.com', '0911111111', N'Sơn Trà, Đà Nẵng', '1997-07-08'),
	(N'Phạm', N'Thị Bình', 0, 'phamthib@gmail.com', '0988888888', N'Hòa Vang, Đà Nẵng', '1996-08-09'),
	(N'Hồ', N'Quang Cường', 1, 'hoquangcuong@gmail.com', '0966666666', N'Cẩm Lệ, Đà Nẵng', '1995-09-10'),
	(N'Nguyễn', N'Hải Dương', 0, 'nguyenhaiduong@gmail.com', '0933333333', N'Liên Chiểu, Đà Nẵng', '1994-10-11');

DBCC CHECKIDENT ('Teachers', RESEED, 0);
INSERT INTO Students (FirstName, LastName, Gender, Email, PhoneNumber, [Address], DateOfBirth) 
VALUES
	(N'Nguyễn', N'Văn An', 1, 'nguyenvanan@gmail.com', '0918911111', N'Sơn Trà, Đà Nẵng', '2001-01-01'),
	(N'Trần', N'Thị Bình', 0, 'tranthibi@gmail.com', '0988865888', N'Hòa Vang, Đà Nẵng', '2002-02-02'),
	(N'Phạm', 'Văn Châu', 1, 'phamvancc@gmail.com', '0966649666', N'Cẩm Lệ, Đà Nẵng', '2003-03-03'),
	(N'Lê', N'Thị Dương', 0, 'lethiduongd@gmail.com', '0326458246', N'Hải Châu, Đà Nẵng', '2004-04-04'),
	(N'Hoàng', N'Văn Em', 1, 'hoangvanec@gmail.com', '0324658235', N'Liên Chiểu, Đà Nẵng', '2005-05-05'),
	(N'Nguyễn', N'Thị Phúc', 0, 'nguyenthidf@gmail.com', '0935345678', N'Hải Châu, Đà Nẵng', '2006-06-06'),
	(N'Trần', N'Văn Giang', 1, 'tranvangc@gmail.com', '0987654321', N'Sơn Trà, Đà Nẵng', '2007-07-07'),
	(N'Phan', N'Thị Hoài', 0, 'phanthihd@gmail.com', '091312111', N'Cẩm Lệ, Đà Nẵng', '2008-08-08'),
	(N'Lê', N'Văn Vinh', 1, 'levanid@gmail.com', '0316504685', N'Liên Chiểu, Đà Nẵng', '2009-09-09'),
	(N'Hoàng', N'Thị Khanh', 0, 'hoangthiks@gmail.com', '0316625486', N'Hòa Vang, Đà Nẵng', '2010-10-10');
DBCC CHECKIDENT ('Students', RESEED, 0);
INSERT INTO Employees (FirstName, LastName, Gender, Email, PhoneNumber, [Address], DateOfBirth) 
VALUES
	(N'Nguyễn', N'Văn Anh', 1, 'nguyenvanan123@gmail.com', '0918911111', N'Sơn Trà, Đà Nẵng', '2001-01-01'),
	(N'Trần', N'Thị Bình Châu', 0, 'tranthibi456@gmail.com', '0988865888', N'Hòa Vang, Đà Nẵng', '2002-02-02'),
	(N'Phạm', N'Văn Châu Sa', 1, 'phamvancc789@gmail.com', '0966649666', N'Cẩm Lệ, Đà Nẵng', '2003-04-03'),
	(N'Trần', N'Thị Sa', 0, 'tranthisa789@gmail.com', '0966642366', N'Ngũ Hành Sơn, Đà Nẵng', '2001-03-01'),
	(N'Nguyễn', N'Thị An Thịnh', 0, 'nguyenanthinh@gmail.com', '09664349666', N'Cẩm Lệ, Đà Nẵng', '2002-10-08'),
	(N'Đặng', N'Nguyễn Huỳnh ', 1, 'dangnguyenhinh@gmail.com', '0966456466', N'Hải Châu, Đà Nẵng', '1999-06-16'),
	(N'Huỳnh', N'Thị Lệ Khanh', 0, 'lekhanh89@gmail.com', '09687548666', N'Liên Chiểu, Đà Nẵng', '1999-07-03');

INSERT INTO [Classes] ([Name], [Description], StartDate, EndDate)
VALUES
	('Batch 31',N'Khóa học M.E.R.N', '2023-05-21', '2023-10-21'),
	('Batch 84',N'Mỹ thuật đa phương tiện quốc tế', '2023-03-21', '2023-08-21'),
	('Batch 99',N'Lập trình viên quốc tế', '2023-03-21', '2023-11-21');

INSERT INTO [Classes_Students] (ClassId, StudentId)
VALUES
	(1,2),
	(1,4),
	(1,7),
	(2,1),
	(2,3),
	(2,5),
	(3,2),
	(3,4),
	(3,8),
	(3,9),
	(2,10),
	(1,6);

INSERT INTO Classes_Teachers (ClassId, TeacherId)
VALUES
	(1,2),
	(1,4),
	(3,6),
	(2,1),
	(3,3),
	(2,5);
SELECT * FROM Teachers

INSERT INTO [Subjects] ([Name], [Description])
VALUES
	('HTML5, CSS3, JavaScript',N'Lập trình WEB căn bản'),
	('ReactJS',N'Lập trình FRONTEND ReactJS'),
	('ExpressJS',N'Lập trình BACKEND ExpressJS'),
	('MongoDB',N'CSDL NoSQL MongoDB'),
	('MySQL',N'CSDL MySQL'),
	('SQL Server',N'CSDL SQL Server');

INSERT INTO Subjects_Teachers (SubjectId, TeacherId)
VALUES
	(1,1),
	(2,2),
	(3,3),
	(4,4),
	(5,5),
	(6,6);
SELECT * FROM Teachers

INSERT INTO Marks (StudentId, SubjectId, Mark, Date)
VALUES 
	(1, 1, 8.0, '2022-06-01 14:00:00'),
	(1, 2, 7.5, '2022-06-02 10:30:00'),
    (2, 3, 9.0, '2022-06-03 11:45:00'),
    (3, 4, 8.5, '2022-06-04 13:15:00'),
    (4, 1, 8.0, '2022-05-05 14:30:00'),
    (5, 4, 6.5, '2022-06-04 13:15:00'),
	(6, 5, 9.5, '2022-05-06 16:00:00'),
	(7, 6, 8.5, '2022-05-07 17:30:00'),
	(8, 2, 7.5, '2022-05-09 10:30:00'),
	(9, 3, 9.0, '2022-05-10 11:45:00'),
	(10, 5, 8.5, '2022-06-04 13:15:00');

INSERT INTO AttendanceTypes (Name, Description)
VALUES 
	('Present','Có Mặt'),
	('Absent','Vắng'),
	('Late', 'Muộn'),
	('Excused', 'Có xin phép');

INSERT INTO Attendances (StudentId, SubjectId, AttendanceTypeId, Date, Description)
VALUES
	(1, 1, 1, '2022-06-01', NULL),
    (3, 5, 1, '2022-06-01', NULL),
    (2, 3, 2, '2022-06-02', N'Vắng'),
    (4, 5, 4, '2022-06-03', N'Đi khám bệnh'),
    (8, 2, 1, '2022-06-04', NULL),
    (7, 4, 3, '2022-06-04', N'Đi muộn'),
    (9, 3, 2, '2022-06-05', N'Vắng'),
    (10, 1, 1, '2022-06-05', NULL),
    (5, 6, 1, '2022-06-06', NULL),
    (6, 6, 2, '2022-06-06', N'Vắng');

INSERT INTO Tuitions (StudentId, InvoiceCode, InvoiceDate, Amount, EmployeeId, Description)
VALUES
    (1, 'INV-2022-1', '2022-06-01', 1000, 1, 'Tuition fee for June'),
    (2, 'INV-2022-2', '2022-06-01', 1500, 3, 'Tuition fee for June'),
    (3, 'INV-2022-3', '2022-06-02', 1200, 2, 'Tuition fee for June'),
    (4, 'INV-2022-4', '2022-06-03', 1000, 4, 'Tuition fee for June'),
    (5, 'INV-2022-5', '2022-06-04', 800, 5, 'Tuition fee for June'),
    (6, 'INV-2022-6', '2022-06-05', 1200, 3, 'Tuition fee for June'),
    (7, 'INV-2022-7', '2022-06-06', 1500, 7, 'Tuition fee for June'),
	(8, 'INV-2022-8', '2022-06-07', 1800, 6, 'Tuition fee for June'),
	(9, 'INV-2022-9', '2022-06-08', 1900, 5, 'Tuition fee for June'),
	(10, 'INV-2023-1', '2022-06-10', 1500, 2, 'Tuition fee for June');

SELECT * FROM Employees