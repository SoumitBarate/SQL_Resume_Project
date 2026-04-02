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

-- Questions and Answers :- 

-- 1) Retrieve all books in the "Fiction" genre:
SELECT * 
FROM Books
WHERE genre = 'Fiction';

-- 2) Find books published after the year 1950:
SELECT *
FROM Books
WHERE published_year > 1950;

-- 3) List all customers from the Canada:
SELECT *
FROM customers
WHERE country = 'Canada';

-- 4) Show orders placed in November 2023:
SELECT *
FROM orders
WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30';

-- 5) Retrieve the total stock of books available:
SELECT SUM(stock) AS total_stock
FROM books;

-- 6) Find the details of the most expensive book:
SELECT *
FROM books
ORDER BY price desc
LIMIT 1;

-- 7) Show all customers who ordered more than 1 quantity of a book:
SELECT c.customer_id, c.name, o.quantity, o.customer_id
FROM customers c
Join 
orders o
ON c.customer_id = o.customer_id
WHERE quantity > 1;

-- 8) Retrieve all orders where the total amount exceeds $20:
SELECT *
FROM orders
WHERE total_amount > 20;

-- 9) List all genres available in the Books table:
SELECT DISTINCT(genre)
FROM books;

-- 10) Find the book with the lowest stock:
SELECT * 
FROM books
ORDER BY stock ASC
LIMIT 1;

-- 11) Calculate the total revenue generated from all orders:
SELECT SUM(total_amount) AS Total_revenue
FROM orders;

SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;

-- 12) Retrieve the total number of books sold for each genre:
SELECT SUM(Orders.quantity), Books.genre 
FROM Orders
JOIN Books 
ON Orders.book_id = Books.book_id
GROUP BY Books.genre;

-- 13) Find the average price of books in the "Fantasy" genre:
SELECT AVG(price)
FROM books
WHERE genre = 'Fantasy';

-- 14) List customers who have placed at least 2 orders:
SELECT c.name, COUNT(o.order_id) 
FROM Customers c 
JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.name
HAVING COUNT(o.order_id) >= 2;

-- 15) Find the most frequently ordered book:
SELECT o.book_id, b.title, COUNT(o.order_id) AS ORDER_COUNT
FROM Orders o 
JOIN books b 
ON o.book_id = b.book_id
GROUP BY o.book_id, b.title
ORDER BY ORDER_COUNT DESC LIMIT 1;

-- 16) Show the top 3 most expensive books of 'Fantasy' Genre :
SELECT * 
FROM books
WHERE genre = 'Fantasy'
ORDER BY price desc
LIMIT 3;

-- 17) Retrieve the total quantity of books sold by each author:
SELECT b.author, SUM(o.quantity) 
FROM orders o 
JOIN books b ON o.book_id = b.book_id
GROUP BY b.Author;

-- 18) List the cities where customers who spent over $30 are located:
SELECT c.city, o.total_amount 
FROM customers c 
JOIN orders o
ON c.customer_id = o.customer_id
WHERE total_amount > 30;

-- 19) Find the customer who spent the most on orders:
SELECT c.customer_id, c.name, SUM(o.total_amount) AS Total_Spent
FROM orders o
JOIN customers c 
ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.name
ORDER BY Total_spent Desc LIMIT 1;

--20) Calculate the stock remaining after fulfilling all orders:
SELECT b.book_id, b.title, b.stock, COALESCE(SUM(o.quantity),0) AS Order_quantity,  
	b.stock - COALESCE(SUM(o.quantity),0) AS Remaining_Quantity
FROM books b
LEFT JOIN orders o
ON b.book_id = o.book_id
GROUP BY b.book_id ORDER BY b.book_id;

