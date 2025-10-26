-- create database CatLib;
-- GO -- Use GO if running multiple batches in SSMS or similar tools

USE CatLib;
GO

CREATE TABLE Category (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName NVARCHAR(100) NOT NULL,
    CONSTRAINT UQ_CategoryName UNIQUE (CategoryName)
);
-- GO

CREATE TABLE Author (
    AuthorID INT IDENTITY(1,1) PRIMARY KEY,
    AuthorName NVARCHAR(100) NOT NULL,
    -- Added UNIQUE constraint to prevent duplicate author names
    CONSTRAINT UQ_AuthorName UNIQUE (AuthorName)
    -- Removed the 'story' column as it's not used in the application
);
-- GO

CREATE TABLE Book (
    BookID INT IDENTITY(1,1) PRIMARY KEY,
    Title NVARCHAR(255) NOT NULL,
    PublishDate DATE,
    -- Changed from deprecated NTEXT to NVARCHAR(MAX) for better compatibility
    [Description] NVARCHAR(MAX),
    Publisher NVARCHAR(255),
    StockQuantity INT NOT NULL CHECK (StockQuantity >= 0), -- Added CHECK constraint for non-negative stock
    CategoryID INT,
    -- Changed from NVARCHAR(MAX) to NVARCHAR(255) assuming only filenames are stored
    -- Added DEFAULT value for cases where no image is provided
    ImageURL NVARCHAR(255) DEFAULT 'no-img.png',
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)
    -- Consider adding ON DELETE SET NULL or ON DELETE CASCADE for CategoryID if needed
);
-- GO

CREATE TABLE Book_Author (
    BookID INT,
    AuthorID INT,
    PRIMARY KEY (BookID, AuthorID), -- Correctly defined composite primary key
    FOREIGN KEY (BookID) REFERENCES Book(BookID) ON DELETE CASCADE, -- Added ON DELETE CASCADE
    FOREIGN KEY (AuthorID) REFERENCES Author(AuthorID) ON DELETE CASCADE -- Added ON DELETE CASCADE
);
-- GO

CREATE TABLE Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    username NVARCHAR(50) UNIQUE NOT NULL,
    password NVARCHAR(255) NOT NULL, -- Stores bcrypt hash
    full_name NVARCHAR(100),
    role NVARCHAR(10) CHECK (role IN ('user', 'admin')) DEFAULT 'user', -- Added DEFAULT
    is_active BIT DEFAULT 1,
    email NVARCHAR(100) NOT NULL,
    phone NVARCHAR(20),
    -- Added UNIQUE constraint to prevent duplicate emails
    CONSTRAINT UQ_UserEmail UNIQUE (email)
);
-- GO

CREATE TABLE BookOrders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT,
    BookID INT,
    OrderDate DATE NOT NULL DEFAULT GETDATE(), -- Added DEFAULT for convenience
    ReturnDate DATE NOT NULL, -- Expected return date
    ActualReturnDate DATE, -- Actual return date (NULL until returned)
    -- Correctly used DECIMAL for bill/fine amount
    Bill DECIMAL(10, 2) DEFAULT 0.00, -- Added DEFAULT
    Status NVARCHAR(20) CHECK (Status IN ('pending', 'approved', 'rejected', 'overdue', 'returned')),
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE SET NULL, -- Consider implications: keep order history even if user deleted?
    FOREIGN KEY (BookID) REFERENCES Book(BookID) ON DELETE CASCADE -- If book is deleted, related orders are deleted
);
-- GO

CREATE TABLE Comments (
    CommentID INT IDENTITY(1,1) PRIMARY KEY, -- Dự đoán có khóa chính tự tăng
    bookId INT NOT NULL,                 -- Khóa ngoại đến Book(BookID)
    userId INT NOT NULL,                 -- Khóa ngoại đến Users(UserID)
    commentText NVARCHAR(MAX) NOT NULL, -- Nội dung comment (dùng NVARCHAR(MAX) cho an toàn)
    createdAt DATETIME NOT NULL DEFAULT GETDATE(), -- Ngày giờ tạo, tự động lấy giờ hiện tại
    FOREIGN KEY (bookId) REFERENCES Book(BookID) ON DELETE CASCADE, -- Nếu sách bị xóa, comment cũng xóa
    FOREIGN KEY (userId) REFERENCES Users(UserID) ON DELETE CASCADE -- Nếu user bị xóa, comment cũng xóa (hoặc SET NULL tùy nghiệp vụ)
);
-- GO

-- Recommended Indexes for better query performance
CREATE INDEX IX_Book_CategoryID ON Book (CategoryID);
-- GO
CREATE INDEX IX_BookAuthor_AuthorID ON Book_Author (AuthorID);
-- GO
CREATE INDEX IX_BookOrders_UserID ON BookOrders (UserID);
-- GO
CREATE INDEX IX_BookOrders_BookID ON BookOrders (BookID);
-- GO
CREATE INDEX IX_BookOrders_Status ON BookOrders (Status);
-- GO
CREATE INDEX IX_Comments_BookID ON Comments (bookId);
-- GO
CREATE INDEX IX_Comments_UserID ON Comments (userId);
-- GO