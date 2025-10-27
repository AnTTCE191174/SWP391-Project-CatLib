-- Tạo hoặc sử dụng database CatLib
-- CREATE DATABASE CatLib;
-- GO
-- USE CatLib;
-- GO

CREATE TABLE Roles (
    RoleID INT IDENTITY(1,1) PRIMARY KEY,
    RoleName NVARCHAR(50) NOT NULL,
    CONSTRAINT UQ_RoleName UNIQUE (RoleName)
);
GO

-- Bảng Users (Kết hợp, dùng RoleID, UNIQUE Email)
CREATE TABLE Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    Username NVARCHAR(50) NOT NULL,
    Password NVARCHAR(255) NOT NULL, -- Lưu hash bcrypt
    FullName NVARCHAR(100),         -- Đổi tên từ CatLib2
    Email NVARCHAR(100) NOT NULL,
    Phone NVARCHAR(20),             -- Giữ lại từ CatLib
    IsActive BIT DEFAULT 1,         -- Đổi tên từ CatLib2
    RoleID INT NOT NULL,            -- Dùng RoleID
    CONSTRAINT UQ_Username UNIQUE (Username),
    CONSTRAINT UQ_UserEmail UNIQUE (Email), -- Giữ UNIQUE Email
    FOREIGN KEY (RoleID) REFERENCES Roles(RoleID)
);
GO

-- Bảng Category (Giữ cấu trúc đơn giản, có UNIQUE)
CREATE TABLE Category (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName NVARCHAR(100) NOT NULL,
    CONSTRAINT UQ_CategoryName UNIQUE (CategoryName)
);
GO

-- Bảng Author (Giữ cấu trúc đơn giản, có UNIQUE)
CREATE TABLE Author (
    AuthorID INT IDENTITY(1,1) PRIMARY KEY,
    AuthorName NVARCHAR(100) NOT NULL,
    CONSTRAINT UQ_AuthorName UNIQUE (AuthorName)
);
GO

-- Bảng Publisher (Từ CatLib2)
CREATE TABLE Publisher (
    PublisherID INT IDENTITY(1,1) PRIMARY KEY,
    PublisherName NVARCHAR(255) NOT NULL,
     CONSTRAINT UQ_PublisherName UNIQUE (PublisherName) -- Nên thêm UNIQUE
);
GO

-- Bảng Book (Kết hợp, dùng PublisherID, PublishYear, bỏ StockQuantity)
CREATE TABLE Book (
    BookID INT IDENTITY(1,1) PRIMARY KEY,
    Title NVARCHAR(255) NOT NULL,
    [Description] NVARCHAR(MAX),    -- Dùng NVARCHAR(MAX)
    PublishYear INT,                -- Dùng PublishYear (INT) từ CatLib2
    ShelfLocation NVARCHAR(50),     -- Thêm từ CatLib2
    CategoryID INT,
    PublisherID INT,                -- Dùng PublisherID
    ImageURL NVARCHAR(255) DEFAULT 'no-img.png', -- Giữ ImageURL, giới hạn độ dài, có default
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID) ON DELETE SET NULL,
    FOREIGN KEY (PublisherID) REFERENCES Publisher(PublisherID) ON DELETE SET NULL
);
GO

-- Bảng Book_Author (Giữ nguyên)
CREATE TABLE Book_Author (
    BookID INT,
    AuthorID INT,
    PRIMARY KEY (BookID, AuthorID),
    FOREIGN KEY (BookID) REFERENCES Book(BookID) ON DELETE CASCADE,
    FOREIGN KEY (AuthorID) REFERENCES Author(AuthorID) ON DELETE CASCADE
);
GO

-- Bảng Item (Từ CatLib2 - Quản lý từng bản sao sách)
CREATE TABLE Item (
    ItemID INT IDENTITY(1,1) PRIMARY KEY,
    BookID INT NOT NULL,            -- Liên kết đến sách gốc
    ItemCode NVARCHAR(50) NOT NULL, -- Mã định danh duy nhất cho bản sao
    Status NVARCHAR(20) DEFAULT 'available' CHECK (Status IN ('available', 'borrowed', 'lost', 'damaged')), -- Trạng thái của bản sao
    CONSTRAINT UQ_ItemCode UNIQUE (ItemCode),
    FOREIGN KEY (BookID) REFERENCES Book(BookID) ON DELETE CASCADE -- Nếu xóa sách gốc, xóa luôn các bản sao
);
GO

-- Bảng BookOrders (Kết hợp, bỏ BookID, Bill; dùng DueDate)
CREATE TABLE BookOrders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT,                      -- Ai là người mượn
    OrderDate DATE NOT NULL DEFAULT GETDATE(),
    DueDate DATE NOT NULL,           -- Ngày hẹn trả (thay cho ReturnDate)
    ActualReturnDate DATE,         -- Ngày trả thực tế
    Status NVARCHAR(20) CHECK (Status IN ('pending', 'approved', 'rejected', 'overdue', 'returned')), -- Giữ các trạng thái này
    -- Bỏ BookID (vì giờ mượn theo ItemID)
    -- Bỏ Bill (tiền phạt có thể tính khi trả hoặc lưu ở bảng khác nếu phức tạp hơn)
    LastReminderSentDate DATE NULL, -- Giữ lại cho scheduler
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE SET NULL
);
GO

-- Bảng BookOrderDetail (Từ CatLib2 - Chi tiết đơn hàng mượn Item nào)
CREATE TABLE BookOrderDetail (
    OrderDetailID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT NOT NULL,           -- Thuộc đơn hàng nào
    ItemID INT NOT NULL,            -- Mượn bản sao (Item) nào
    -- Có thể thêm thông tin khác như ngày mượn/trả cụ thể cho item này nếu cần
    FOREIGN KEY (OrderID) REFERENCES BookOrders(OrderID) ON DELETE CASCADE, -- Nếu xóa Order, xóa Detail
    FOREIGN KEY (ItemID) REFERENCES Item(ItemID) -- Không nên CASCADE ở đây, Item có thể tồn tại độc lập
);
GO

-- Bảng Review (Từ CatLib2 - Thay thế Comments)
CREATE TABLE Review (
    ReviewID INT IDENTITY(1,1) PRIMARY KEY,
    BookID INT NOT NULL,
    UserID INT NOT NULL,
    Rating INT CHECK (Rating >= 1 AND Rating <= 5), -- Đánh giá từ 1-5 sao
    Comment NVARCHAR(MAX),          -- Nội dung bình luận
    CreatedAt DATETIME DEFAULT GETDATE(), -- Ngày tạo
    IsDeleted BIT DEFAULT 0,        -- Cờ xóa mềm
    FOREIGN KEY (BookID) REFERENCES Book(BookID) ON DELETE CASCADE,
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE
);
GO

-- Bảng LibraryRules (Từ CatLib2)
CREATE TABLE LibraryRules (
    RuleID INT IDENTITY(1,1) PRIMARY KEY,
    RuleName NVARCHAR(50) NOT NULL,
    RuleValue NVARCHAR(255) NOT NULL, -- Ví dụ: 'MaxBorrowDays', '14'; 'OverdueFinePerDay', '10000'
    Description NVARCHAR(255),
    CONSTRAINT UQ_RuleName UNIQUE (RuleName)
);
GO

-- Bảng TransactionLog (Từ CatLib2)
CREATE TABLE TransactionLog (
    TransactionID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT,                   -- Liên quan đến Order nào (có thể NULL nếu không phải mượn/trả)
    ItemID INT,                    -- Liên quan đến Item nào
    LibrarianID INT,               -- Ai là người thực hiện (nếu là thủ thư)
    Action NVARCHAR(20) CHECK (Action IN ('borrow', 'return', 'add', 'update', 'delete')), -- Loại hành động
    ActionDate DATETIME NOT NULL DEFAULT GETDATE(), -- Thời gian thực hiện
    -- Có thể thêm UserId của người mượn nếu cần
    FOREIGN KEY (OrderID) REFERENCES BookOrders(OrderID) ON DELETE SET NULL, -- Giữ log nếu Order bị xóa
    FOREIGN KEY (ItemID) REFERENCES Item(ItemID) ON DELETE SET NULL,     -- Giữ log nếu Item bị xóa
    FOREIGN KEY (LibrarianID) REFERENCES Users(UserID) ON DELETE SET NULL -- Giữ log nếu Thủ thư bị xóa
);
GO

-- Thêm các Index
CREATE INDEX IX_Book_CategoryID ON Book (CategoryID);
CREATE INDEX IX_Book_PublisherID ON Book (PublisherID);
CREATE INDEX IX_BookAuthor_AuthorID ON Book_Author (AuthorID);
CREATE INDEX IX_Item_BookID ON Item (BookID);
CREATE INDEX IX_Item_Status ON Item (Status);
CREATE INDEX IX_BookOrders_UserID ON BookOrders (UserID);
CREATE INDEX IX_BookOrders_Status ON BookOrders (Status);
CREATE INDEX IX_BookOrderDetail_OrderID ON BookOrderDetail (OrderID);
CREATE INDEX IX_BookOrderDetail_ItemID ON BookOrderDetail (ItemID);
CREATE INDEX IX_Review_BookID ON Review (BookID);
CREATE INDEX IX_Review_UserID ON Review (UserID);
CREATE INDEX IX_TransactionLog_OrderID ON TransactionLog (OrderID);
CREATE INDEX IX_TransactionLog_ItemID ON TransactionLog (ItemID);
CREATE INDEX IX_TransactionLog_LibrarianID ON TransactionLog (LibrarianID);
CREATE INDEX IX_TransactionLog_Action ON TransactionLog (Action);
GO