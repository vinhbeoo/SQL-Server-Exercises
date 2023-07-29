--1.Hiển thị danh sách các lớp học cùng với thông tin giáo viên phụ trách
SELECT
	C.*,
	T.Id AS TeacherId,
	T.FirstName,
	T.LastName,
	T.Gender
FROM
	Classes AS C
		INNER JOIN Classes_Teachers AS CT ON C.Id = CT.ClassId
		INNER JOIN Teachers AS T ON CT.TeacherId = T.Id

--2.Hiển thị danh sách các lớp học cùng với thông tin giáo viên phụ trách và số lượng học sinh.
SELECT 
	C.Id,
	C.Name,
	C.Description,
	T.FirstName,
	T.LastName,
	COUNT(S.Id) AS Total
FROM
	Classes AS C
		INNER JOIN Classes_Teachers AS CT ON C.Id = CT.ClassId
		INNER JOIN Teachers AS T ON CT.TeacherId = T.Id
		INNER JOIN Classes_Students AS CS ON C.Id = CS.ClassId
		INNER JOIN Students AS S ON CS.StudentId = S.Id
GROUP BY 
	C.Id,
	C.Name,
	C.Description,
	T.FirstName,
	T.LastName

--3.Hiển thị danh sách các lớp học cùng với thông tin giáo viên phụ trách và số lượng học sinh, sắp xếp theo tên lớp học.
SELECT 
	C.Id,
	C.Name,
	C.Description,
	T.FirstName,
	T.LastName,
	COUNT(S.Id) AS Total
FROM
	Classes AS C
		INNER JOIN Classes_Teachers AS CT ON C.Id = CT.ClassId
		INNER JOIN Teachers AS T ON CT.TeacherId = T.Id
		INNER JOIN Classes_Students AS CS ON C.Id = CS.ClassId
		INNER JOIN Students AS S ON CS.StudentId = S.Id
GROUP BY 
	C.Id,
	C.Name,
	C.Description,
	T.FirstName,
	T.LastName
ORDER BY C.Id ASC

--4.Hiển thị danh sách các lớp học còn trống (chưa có học sinh nào đăng ký).
SELECT 
	C.Id,
	C.Name,
	C.Description
FROM
	Classes AS C
		INNER JOIN Classes_Students AS CS ON C.Id = CS.ClassId
		INNER JOIN Students AS S ON CS.StudentId = S.Id
WHERE CS.StudentId <> S.Id

--5.Hiển thị danh sách các lớp học còn học, sắp xếp theo ngày kết thúc tăng dần.
SELECT 
	C.Id,
	C.Name,
	C.Description,
	C.StartDate,
	C.EndDate
FROM
	Classes	AS C
WHERE C.EndDate > GETDATE()
ORDER BY C.EndDate ASC

--6.Hiển thị các lớp học đã kết thúc, sắp xếp theo ngày kết thúc giảm dần.
SELECT 
	C.Id,
	C.Name,
	C.Description,
	C.StartDate,
	C.EndDate
FROM
	Classes	AS C
WHERE C.EndDate < GETDATE()
ORDER BY C.EndDate DESC

--7.Hiển thị các lớp học chưa bắt đầu, sắp xếp theo ngày bắt đầu tăng dần.
SELECT 
	C.Id,
	C.Name,
	C.Description,
	C.StartDate,
	C.EndDate
FROM
	Classes	AS C
WHERE C.StartDate > GETDATE()
ORDER BY C.EndDate ASC

--8.Hiển thị lớp học có ít hơn 10 học sinh.
SELECT
	C.Id,
	C.Name,
	C.Description,
	C.StartDate,
	C.EndDate,
	COUNT(S.Id) AS TotalStudents
FROM
	Classes AS C
		INNER JOIN Classes_Students AS CS ON C.Id = CS.ClassId
		INNER JOIN Students AS S ON CS.StudentId = S.Id
GROUP BY 	
	C.Id,
	C.Name,
	C.Description,
	C.StartDate,
	C.EndDate
HAVING COUNT(S.Id) < 10;

--9.Hiển thị lớp học có nhiều hơn 20 học sinh.
SELECT
	C.Id,
	C.Name,
	C.Description,
	C.StartDate,
	C.EndDate,
	COUNT(S.Id) AS TotalStudents
FROM
	Classes AS C
		INNER JOIN Classes_Students AS CS ON C.Id = CS.ClassId
		INNER JOIN Students AS S ON CS.StudentId = S.Id
GROUP BY 	
	C.Id,
	C.Name,
	C.Description,
	C.StartDate,
	C.EndDate
HAVING COUNT(S.Id) > 20;

--10.Hiển thị lớp học có số lượng học sinh nhiều nhất.
SELECT TOP 1
	C.Id,
	C.Name,
	C.Description,
	C.StartDate,
	C.EndDate,
	COUNT(S.Id) AS TotalStudents
FROM
	Classes AS C
		INNER JOIN Classes_Students AS CS ON C.Id = CS.ClassId
		INNER JOIN Students AS S ON CS.StudentId = S.Id
GROUP BY 	
	C.Id,
	C.Name,
	C.Description,
	C.StartDate,
	C.EndDate
ORDER BY COUNT(S.Id) DESC 

--HỌC SINH
--1.Hiển thị danh sách học sinh của lớp học có tên là Batch 31.
ALTER PROCEDURE usp_GetStudentsInClassesNames
(
	@ClassesNames NVARCHAR(50)
)
AS
BEGIN
	SELECT
		S.Id,
		S.FirstName,
		S.LastName,
		C.Name AS ClassesName
	FROM
		Students AS S
			INNER JOIN Classes_Students AS CS ON S.Id = CS.StudentId
			INNER JOIN Classes AS C ON CS.ClassId = C.Id
	WHERE C.Name = @ClassesNames
	ORDER BY S.Id ASC
END

EXEC usp_GetStudentsInClassesNames 'Batch 31'

--2.Hiển thị danh sách học sinh của lớp học có tên là Batch 31, sắp xếp theo tên học sinh.
ALTER PROCEDURE usp_GetStudentsInClassesNamesArrange
(
	@ClassesNames NVARCHAR(50)
)
AS
BEGIN
	SELECT
		S.Id,
		S.FirstName,
		S.LastName,
		C.Name AS ClassesName
	FROM
		Students AS S
			INNER JOIN Classes_Students AS CS ON S.Id = CS.StudentId
			INNER JOIN Classes AS C ON CS.ClassId = C.Id
	WHERE C.Name = @ClassesNames
	ORDER BY S.LastName,S.FirstName ASC
END

EXEC usp_GetStudentsInClassesNamesArrange 'Batch 31'

--MÔN HỌC
--1.Hiển thị danh sách môn học cùng với thông tin giáo viên dạy môn đó.
SELECT 
	S.Id,
	S.Name,
	S.Description,
	STRING_AGG(T.FirstName + ' ' +T.LastName, ', ') AS TeachersName
FROM 
	Subjects AS S
		INNER JOIN Subjects_Teachers AS ST ON S.Id = ST.SubjectId
		INNER JOIN Teachers AS T ON ST.TeacherId = T.Id
GROUP BY S.Id, S.Name, S.Description

--2.Hiển thị danh sách môn học cùng với thông tin giáo viên dạy môn đó, sắp xếp theo tên môn học.
SELECT 
	S.Id,
	S.Name,
	S.Description,
	STRING_AGG(T.FirstName + ' ' +T.LastName, ', ') AS TeachersName
FROM 
	Subjects AS S
		INNER JOIN Subjects_Teachers AS ST ON S.Id = ST.SubjectId
		INNER JOIN Teachers AS T ON ST.TeacherId = T.Id
GROUP BY S.Id, S.Name, S.Description
ORDER BY S.Name ASC

--3.Hiển thị danh sách môn học cùng với thông tin trung bình cộng điểm số của môn đó, sắp xếp theo tên môn học.
SELECT
	S.Id,
	S.Name,
	S.Description,
	AVG(M.Mark)
FROM
	Subjects AS S
		INNER JOIN Marks AS M ON S.Id = M.SubjectId
GROUP BY S.Id, S.Name, S.Description
ORDER BY S.Name ASC

--ĐIỂM SỐ
--1.Hiển thị danh sác các học sinh có điểm số của môn học ReactJS, sắp xếp theo điểm số giảm dần.
CREATE PROCEDURE usp_GetListStudentsMark
(
	@SubjectsName NVARCHAR(100)
)
AS
BEGIN
	SELECT 
		S.Id,
		S.FirstName,
		S.LastName,
		S.Email,
		SJ.Name,
		M.Mark
	FROM
		Students AS S
			INNER JOIN Marks AS M ON S.Id = M.StudentId
			INNER JOIN Subjects AS SJ ON M.SubjectId = SJ.Id
	WHERE SJ.Name = @SubjectsName
	GROUP BY 
		S.Id,
		S.FirstName,
		S.LastName,
		S.Email,
		SJ.Name,
		M.Mark
	ORDER BY M.Mark DESC
END

EXEC usp_GetListStudentsMark 'ReactJS'

--2.Hiển thị danh sách các học sinh có điểm số của môn học ReactJS cao nhất, sắp xếp theo điểm số giảm dần.
CREATE PROCEDURE usp_GetListStudentsMarkMax
(
	@SubjectsName NVARCHAR(100),
	@Number INT
)
AS
BEGIN
	SELECT TOP (@Number)
		S.Id,
		S.FirstName,
		S.LastName,
		S.Email,
		SJ.Name,
		M.Mark
	FROM
		Students AS S
			INNER JOIN Marks AS M ON S.Id = M.StudentId
			INNER JOIN Subjects AS SJ ON M.SubjectId = SJ.Id
	WHERE SJ.Name = @SubjectsName
	GROUP BY 
		S.Id,
		S.FirstName,
		S.LastName,
		S.Email,
		SJ.Name,
		M.Mark
	ORDER BY M.Mark DESC
END

EXEC usp_GetListStudentsMarkMax 'ReactJS', 3

--HỌC PHÍ
--1.Hiển thị danh sách học sinh nộp học phí trong tháng 10/2020.
CREATE PROCEDURE usp_GetStudentsTuitions
(
	@Month INT,
	@Years INT
)
AS
BEGIN
	SELECT
		S.Id,
		S.FirstName,
		S.LastName,
		T.InvoiceDate
	FROM
		Students AS S
			INNER JOIN Tuitions AS T ON S.Id = T.StudentId
	WHERE
		MONTH(T.InvoiceDate) = @Month 
		AND YEAR(T.InvoiceDate) = @Years
END

EXEC usp_GetStudentsTuitions 6, 2022

--2.Hiển thị danh sách học sinh nộp học phí trong tháng 10/2020, sắp xếp theo ngày nộp học phí, sắp xếp theo tên học sinh.
ALTER PROCEDURE usp_GetStudentsTuitionsDate
(
	@Month INT,
	@Years INT
)
AS
BEGIN
	SELECT
		S.Id,
		S.FirstName,
		S.LastName,
		T.InvoiceDate
	FROM
		Students AS S
			INNER JOIN Tuitions AS T ON S.Id = T.StudentId
	WHERE
		MONTH(T.InvoiceDate) = @Month 
		AND YEAR(T.InvoiceDate) = @Years
	GROUP BY S.Id, S.FirstName, S.LastName, T.InvoiceDate
	ORDER BY T.InvoiceDate ASC, S.FirstName ASC, S.LastName ASC
END

EXEC usp_GetStudentsTuitionsDate 6, 2022

--3.Hiển thị danh sách học sinh chưa nộp học phí trong tháng 10/2020, sắp xếp theo tên học sinh.
ALTER PROCEDURE usp_GetStudentsDontTuitionsDate
(
	@Month INT,
	@Year INT
)
AS
BEGIN
	SELECT DISTINCT
		S.Id,
		S.FirstName,
		S.LastName,
		T.InvoiceDate
	FROM
		Students AS S
			LEFT JOIN Tuitions AS T ON S.Id = T.StudentId
	WHERE
		S.Id NOT IN ( 
			SELECT
				T.StudentId
			FROM
				Tuitions AS T
			WHERE
				MONTH(T.InvoiceDate) = @Month
				AND YEAR(T.InvoiceDate) = @Year
			)
	ORDER BY T.InvoiceDate ASC, S.FirstName ASC, S.LastName ASC
END

EXEC usp_GetStudentsDontTuitionsDate 6, 2022

--4.Hiển thị tổng số tiền học phí đã đóng của học sinh có tên là Nguyễn Văn A.
CREATE PROCEDURE usp_GetMoneyTotalOfStudentNames
(
	@FisrtName NVARCHAR(50),
	@LastName NVARCHAR(50)
)
AS
BEGIN
	SELECT 
		S.Id,
		S.FirstName,
		S.LastName,
		SUM(T.Amount)
	FROM
		Students AS S
			INNER JOIN Tuitions AS T ON S.Id = T.StudentId
	WHERE
		S.FirstName = @FisrtName AND S.LastName = @LastName
	GROUP BY S.Id, S.FirstName, S.LastName
END

EXEC usp_GetMoneyTotalOfStudentNames N'Lê', N'Văn Vinh'

--5.Hiển thị tổng số tiền học phí đã đóng của học sinh có tên là Nguyễn Văn A trong năm 2020.
CREATE PROCEDURE usp_GetMoneyTotalOfStudentNamesInYears
(
	@FisrtName NVARCHAR(50),
	@LastName NVARCHAR(50),
	@Year INT
)
AS
BEGIN
	SELECT 
		S.Id,
		S.FirstName,
		S.LastName,
		SUM(T.Amount)
	FROM
		Students AS S
			INNER JOIN Tuitions AS T ON S.Id = T.StudentId
	WHERE
		S.FirstName = @FisrtName 
		AND S.LastName = @LastName
		AND YEAR(T.InvoiceDate) = @Year
	GROUP BY S.Id, S.FirstName, S.LastName
END

EXEC usp_GetMoneyTotalOfStudentNamesInYears N'Hoàng', N'Văn Em', 2022

--6.Hiển thị danh sách học sinh của lớp học có tên là Batch 31 số tiền nộp học phí trong tháng 10/2020, sắp xếp theo tên học sinh.
ALTER PROCEDURE usp_GetListStudentInClass
(
	@ClassesName NVARCHAR(50),
	@Month INT,
	@Year INT
)
AS
BEGIN
	SELECT
		S.Id,
		S.FirstName,
		S.LastName,
		C.Name AS ClassesName,
		T.Amount AS [Học Phí],
		T.InvoiceDate
	FROM
		Students AS S
			INNER JOIN Tuitions AS T ON S.Id = T.StudentId
			INNER JOIN Classes_Students AS CS ON S.Id = CS.StudentId
			INNER JOIN Classes AS C ON CS.ClassId = C.Id
	WHERE 
		C.Name = @ClassesName 
		AND MONTH(T.InvoiceDate) = @Month AND YEAR(T.InvoiceDate) = @Year
	GROUP BY 
		S.Id,
		S.FirstName,
		S.LastName,
		C.Name,
		T.Amount,
		T.InvoiceDate
END

EXEC usp_GetListStudentInClass 'Batch 99', 6, 2022

--6.Hiển thị danh sách học sinh của lớp học có tên là Batch 31 số tiền nộp học phí trong tháng 10/2020, sắp xếp theo tên học sinh.
CREATE PROCEDURE usp_GetListStudentInClassArrange
(
	@ClassesName NVARCHAR(50),
	@Month INT,
	@Year INT
)
AS
BEGIN
	SELECT
		S.Id,
		S.FirstName,
		S.LastName,
		C.Name AS ClassesName,
		T.Amount AS [Học Phí],
		T.InvoiceDate
	FROM
		Students AS S
			INNER JOIN Tuitions AS T ON S.Id = T.StudentId
			INNER JOIN Classes_Students AS CS ON S.Id = CS.StudentId
			INNER JOIN Classes AS C ON CS.ClassId = C.Id
	WHERE 
		C.Name = @ClassesName 
		AND MONTH(T.InvoiceDate) = @Month AND YEAR(T.InvoiceDate) = @Year
	GROUP BY 
		S.Id,
		S.FirstName,
		S.LastName,
		C.Name,
		T.Amount,
		T.InvoiceDate
	ORDER BY S.FirstName ASC, S.LastName ASC
END

EXEC usp_GetListStudentInClassArrange 'Batch 99', 6, 2022