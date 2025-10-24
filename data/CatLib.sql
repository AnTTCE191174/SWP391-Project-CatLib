 -- create database CatLib;


CREATE TABLE Category (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName NVARCHAR(100) NOT NULL
);
CREATE TABLE Author (
    AuthorID INT IDENTITY(1,1) PRIMARY KEY,
    AuthorName NVARCHAR(100) NOT NULL,
);
CREATE TABLE Book ( 
    BookID INT IDENTITY(1,1) PRIMARY KEY, 
    Title NVARCHAR(255) NOT NULL,
    PublishDate Date,
    [Description] NTEXT,
    Publisher NVARCHAR(255),
    StockQuantity INT NOT NULL,
    CategoryID INT,
    ImageURL NVARCHAR(max),
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID),
);
CREATE TABLE Book_Author (
    BookID INT,
    AuthorID INT,
    PRIMARY KEY (BookID, AuthorID),
    FOREIGN KEY (BookID) REFERENCES Book(BookID),
    FOREIGN KEY (AuthorID) REFERENCES Author(AuthorID)
);
CREATE TABLE Users ( -- id, username, email, active, 
    UserID  INT IDENTITY(1,1) PRIMARY KEY,
    username NVARCHAR(50) UNIQUE NOT NULL,
    password NVARCHAR(255) NOT NULL,
    full_name NVARCHAR(100),
    role NVARCHAR(10) CHECK (role IN ('user', 'admin')),
    is_active BIT DEFAULT 1,
    email NVARCHAR(100) NOT NULL,
    phone NVARCHAR(20)
);
CREATE TABLE BookOrders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT,
    BookID INT,
    OrderDate DATE NOT NULL,
    ReturnDate DATE NOT NULL,
    Bill DECIMAL(10, 2),
	 ActualReturnDate DATE,
    Status NVARCHAR(20) CHECK (Status IN ('pending', 'approved', 'rejected', 'overdue', 'returned')),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (BookID) REFERENCES Book(BookID)
);
