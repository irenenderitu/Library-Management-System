-- ================================================
-- Database: Library Management System
-- A database for managing library books, members, and borrowing transactions.
-- =================================================

-- 1. Creating the database
CREATE DATABASE IF NOT EXISTS LibraryDB;
USE LibraryDB;


CREATE TABLE Members (
    MemberID INT AUTO_INCREMENT PRIMARY KEY,    -- Unique identifier
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,        -- Unique email
    PhoneNumber VARCHAR(20),
    JoinDate DATE NOT NULL DEFAULT CURRENT_DATE
);
-- Table: Authors
CREATE TABLE Authors (
    AuthorID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Bio TEXT
);

-- Table: Books
CREATE TABLE Books (
    BookID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(200) NOT NULL,
    ISBN VARCHAR(20) UNIQUE NOT NULL,
    Publisher VARCHAR(100),
    YearPublished YEAR,
    CopiesAvailable INT DEFAULT 1
);

-- Many-to-Many relationship between Books and Authors
-- Table: BookAuthors
CREATE TABLE BookAuthors (
    BookID INT NOT NULL,
    AuthorID INT NOT NULL,
    PRIMARY KEY (BookID, AuthorID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID) ON DELETE CASCADE,
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID) ON DELETE CASCADE
);

-- Table: BorrowTransactions
CREATE TABLE BorrowTransactions (
    TransactionID INT AUTO_INCREMENT PRIMARY KEY,
    MemberID INT NOT NULL,
    BookID INT NOT NULL,
    BorrowDate DATE NOT NULL DEFAULT CURRENT_DATE,
    ReturnDate DATE,
    Status ENUM('Borrowed','Returned','Overdue') NOT NULL DEFAULT 'Borrowed',
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID) ON DELETE CASCADE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID) ON DELETE CASCADE
);
-- Members
INSERT INTO Members (FirstName, LastName, Email, PhoneNumber) VALUES
('John', 'Doe', 'john.doe@example.com', '1234567890'),
('Jane', 'Smith', 'jane.smith@example.com', '0987654321');

-- Authors
INSERT INTO Authors (FirstName, LastName) VALUES
('George', 'Orwell'),
('J.K.', 'Rowling');

-- Books
INSERT INTO Books (Title, ISBN, Publisher, YearPublished, CopiesAvailable) VALUES
('1984', '9780451524935', 'Secker & Warburg', 1949, 5),
('Harry Potter and the Philosopher''s Stone', '9780747532699', 'Bloomsbury', 1997, 3);

-- BookAuthors (Many-to-Many)
INSERT INTO BookAuthors (BookID, AuthorID) VALUES
(1, 1),  -- 1984 by George Orwell
(2, 2);  -- Harry Potter by J.K. Rowling

-- BorrowTransactions
INSERT INTO BorrowTransactions (MemberID, BookID, BorrowDate) VALUES
(1, 1, '2025-11-01'),
(2, 2, '2025-11-05');
