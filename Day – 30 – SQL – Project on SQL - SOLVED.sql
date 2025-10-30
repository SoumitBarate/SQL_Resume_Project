CREATE TABLE Books (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);

CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);

CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);

SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;

-- 1) Retrieve all books in the "Fiction" genre:
SELECT * FROM Books
WHERE genre = 'Fiction';

-- 2) Find books published after the year 1950:
SELECT * FROM Books
WHERE published_year > 1950;

-- 3) List all customers from the Canada:
SELECT name as customers FROM Customers;

-- 4) Show orders placed in November 2023:
SELECT * FROM Orders 
WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30';

-- 5) Retrieve the total stock of books available:
SELECT SUM(stock) From Books;

-- 6) Find the details of the most expensive book:
SELECT * FROM books
ORDER BY price desc
LIMIT 1;

-- 7) Show all customers who ordered more than 1 quantity of a book:
SELECT * FROM orders
WHERE quantity > 1;

-- 8) Retrieve all orders where the total amount exceeds $20:
SELECT * FROM orders
WHERE total_amount > 20;

-- 9) List all genres available in the Books table:
SELECT genre FROM books;

-- 10) Find the book with the lowest stock:
SELECT * FROM books
ORDER BY stock ASC
LIMIT 1;

-- 11) Calculate the total revenue generated from all orders:
SELECT SUM(total_amount) FROM orders;

-- Advance Questions : 

SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;

-- 1) Retrieve the total number of books sold for each genre:
SELECT SUM(Orders.quantity), Books.genre FROM Orders
JOIN Books ON Orders.book_id = Books.book_id
GROUP BY Books.genre;

-- 2) Find the average price of books in the "Fantasy" genre:
SELECT AVG(price) FROM Books
WHERE genre = 'Fantasy';

-- 3) List customers who have placed at least 2 orders:
SELECT Customers.name, COUNT(Orders.order_id) FROM Customers JOIN Orders
ON Customers.Customer_id = Orders.customer_id
GROUP BY Customers.name
HAVING COUNT(Orders.order_id) >= 2;

-- 4) Find the most frequently ordered book:
SELECT Orders.book_id, Books.title, COUNT(Orders.order_id) AS ORDER_COUNT
FROM Orders 
JOIN Books ON Orders.book_id=Books.book_id
GROUP BY Orders.book_id, Books.title
ORDER BY ORDER_COUNT DESC LIMIT 1;

-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :
SELECT genre FROM Books
WHERE genre = 'Fantasy'
ORDER BY price desc
LIMIT 3;

-- 6) Retrieve the total quantity of books sold by each author:
SELECT Books.author, SUM(Orders.quantity) 
FROM Orders 
JOIN Books ON Orders.book_id=Books.book_id
GROUP BY Books.Author;

-- 7) List the cities where customers who spent over $30 are located:
SELECT Customers.city, Orders.total_amount 
FROM Customers JOIN Orders
ON Customers.customer_id = Orders.customer_id
WHERE total_amount > 30;

-- 8) Find the customer who spent the most on orders:
SELECT Customers.customer_id, Customers.name, SUM(orders.total_amount) AS Total_Spent
FROM orders
JOIN Customers ON orders.customer_id = Customers.customer_id
GROUP BY Customers.customer_id, CUstomers.name
ORDER BY Total_spent Desc LIMIT 1;

--9) Calculate the stock remaining after fulfilling all orders:
SELECT Books.book_id, Books.title, Books.stock, COALESCE(SUM(Orders.quantity),0) AS Order_quantity,  
	Books.stock- COALESCE(SUM(Orders.quantity),0) AS Remaining_Quantity
FROM Books 
LEFT JOIN Orders ON Books.book_id=Orders.book_id
GROUP BY Books.book_id ORDER BY Books.book_id;

