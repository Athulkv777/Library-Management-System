CREATE DATABASE Library;
USE Library;

CREATE TABLE Branch(Branch_no INT PRIMARY KEY,  
Manager_Id INT,
Branch_address VARCHAR(150),
Contact_no BIGINT);
/* The values in the Branch table 
are imported from excel.*/
SELECT * FROM Branch;

CREATE TABLE Employee(Emp_Id INT AUTO_INCREMENT PRIMARY KEY,  
Emp_name VARCHAR(30),  
Position VARCHAR(30),
Salary INT,
branch_num INT,
FOREIGN KEY(branch_num) REFERENCES Branch(branch_no));

INSERT INTO Employee(Emp_name, Position, Salary, branch_num) VALUES
('Alice_Johnson','Assistant_Librarian',56000,101),
('Jennifer_Lee','Library_Assistant',52000,102),
('Michael_Smith','Assistant_Librarian',58000,103),
('David_Brown','Assistant_Librarian',55000,104),
('Emily_Davis','Library_Assistant',50000,105),
('John_Wilson','Library_Assistant',51000,106),
('Linda_Thompson','Assistant_Librarian',52000,107),
('James_White','Assistant_Librarian',55000,108),
('Karen_Harris','Library_Assistant',49000,109),
('Robert_Martin','Library_Assistant',51000,110),
('Patricia_Lewis','Assistant_Librarian',60000,111),
('Christopher_Walker','Assistant_Librarian',59000,112),
('Barbara_Hall','Library_Assistant',45000,113),
('Daniel_Allen','Assistant_Librarian',50000,114),
('Elizabeth_Young','Library_Assistant',52000,115),
('Matthew_King','Assistant_Librarian',51000,116),
('Susan_Wright','Assistant_Librarian',56000,117),
('Anthony_Scott','Library_Assistant',48000,118),
('Sarah_Green','Library_Assistant',50000,119),
('Brian_Adams','Assistant_Librarian',69000,120);

INSERT INTO Employee(Emp_name, Position, Salary, branch_num) VALUES
('William_Scott','Library_Assistant',50000,101);
INSERT INTO Employee(Emp_name, Position, Salary, branch_num) VALUES
('Tony_Greek','Assistant_Librarian',55000,109),
('Steve_Smith','Librarian',50000,109),
('Shane_Worn','Library_Assistant',50000,101),
('Mitchell_Wing','Librarian',50000,101),
('Leana_Sam','Librarian',50000,101),
('Scott_Vain','Librarian',50000,101);
SELECT * FROM Employee;

 CREATE TABLE Books(ISBN BIGINT PRIMARY KEY,  
Book_title VARCHAR(50),
Category VARCHAR(30), 
Rental_Price INT, 
Status char(3),  
Author VARCHAR(30),
Publisher VARCHAR(30));
/* The values in the Books table 
are imported from excel.*/
SELECT * FROM Books;

CREATE TABLE Customer(Customer_Id INT PRIMARY KEY,
Customer_Name VARCHAR(30),
Customer_Address VARCHAR(200),
Reg_Date DATE);
/* The values in the Customer table 
are imported from excel.*/
SELECT * FROM Customer;

CREATE TABLE Issue_Status (Issue_Id INT PRIMARY KEY,  
Issued_Cust INT, 
Issue_Date DATE,
Isbn_Book BIGINT,
FOREIGN KEY(Issued_Cust) REFERENCES Customer(Customer_Id),
FOREIGN KEY(Isbn_Book) REFERENCES Books(ISBN));
/* The values in the Issue_Status table 
are imported from excel.*/
SELECT * FROM Issue_Status;

CREATE TABLE Return_Status(Return_Id INT PRIMARY KEY, 
Return_Cust INT,
Return_Book_Name VARCHAR(50),
Return_Date DATE,
Isbn_Book2 BIGINT,
FOREIGN KEY(Isbn_Book2) REFERENCES Books(ISBN));
/* The values in the Return_Status table 
are imported from excel.*/
SELECT * FROM Return_Status;

-- 1. Retrieve the book title, category, and rental price of all available books. 
SELECT Book_title, Category, Rental_Price 
FROM BOOKS
WHERE Status = 'Yes';

-- 2. List the employee names and their respective salaries in descending order of salary.
SELECT Emp_name, Salary 
FROM Employee 
ORDER BY Salary DESC;

-- 3. Retrieve the book titles and the corresponding customers who have rented those books. 
SELECT B.Book_title, C.Customer_Name FROM Books B 
JOIN Issue_Status I ON B.ISBN = I.Isbn_Book 
JOIN Customer C WHERE I.Issued_Cust = C.Customer_Id;

-- 4. Display the total count of books in each category.
SELECT Category, COUNT(Category) AS Num_of_Books 
FROM Books GROUP BY Category;

-- 5. Retrieve the employee names and their positions for the employees whose salaries are above Rs.55,000. 
SELECT Emp_name, Position FROM Employee 
WHERE Salary > 55000;

-- 6. List the customer names who registered before 2015-01-01 and have not issued any books yet. 
SELECT Customer_Name FROM Customer WHERE Reg_Date < '2015-01-01' 
AND Customer_Id NOT IN (SELECT Issued_Cust FROM Issue_Status);

-- 7. Display the branch numbers and the total count of employees in each branch. 
SELECT Branch_num, COUNT(Emp_Id) AS Num_of_Emp 
FROM Employee GROUP BY Branch_num;

-- 8. Display the names of customers who have issued books in the month of June 2023.
SELECT C.Customer_name, I.Issue_Date FROM Customer C JOIN 
Issue_Status I ON C.Customer_Id = I.Issued_cust 
WHERE I.Issue_Date BETWEEN '2023-06-01' AND '2023-06-30';

-- 9. Retrieve book_title from book table containing history.
SELECT Book_title FROM Books 
WHERE Book_title LIKE '%History%';

-- 10. Retrieve the branch numbers along with the count of employees for branches having more than 2 employees.
SELECT Branch_num AS branch_no, COUNT(Emp_Id) AS count_of_emp FROM Employee 
GROUP BY Branch_no HAVING COUNT(Emp_Id) > 2;

-- 11. Retrieve the names of employees who manage branches and their respective branch addresses.
SELECT E.Emp_name, B.Branch_address FROM Employee E LEFT JOIN Branch B 
ON E.branch_num = B.Branch_no;

-- 12. Display the names of customers who have issued books with a rental price higher than Rs. 25.
SELECT C.Customer_name FROM CUSTOMER C JOIN Issue_Status I ON C.Customer_Id = I.Issued_Cust JOIN Books B 
ON B.ISBN = Isbn_book WHERE Rental_Price > 25;

