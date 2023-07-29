UPDATE Products
	SET Price = Price * 1.1
	WHERE Price <= 10000000;

UPDATE Products
	SET Discount = Discount * 1.05
	WHERE Discount <= 0.1;

DELETE FROM Products 
	WHERE Stock = 0;