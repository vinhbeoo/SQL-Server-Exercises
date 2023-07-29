CREATE PROCEDURE usp_Getproducts_With_Min_Discount
(
	@Discount FLOAT
)
AS
BEGIN
	SELECT * FROM Products
	WHERE Discount <= @Discount
END

EXECUTE usp_Getproducts_With_Min_Discount 0.15