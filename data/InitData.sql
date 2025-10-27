-- Đảm bảo bạn đang sử dụng đúng database
USE CatLib;
GO

-- Xóa dữ liệu cũ (thứ tự quan trọng)
--DELETE FROM LibraryRules;
--DELETE FROM TransactionLog;
--DELETE FROM BookOrderDetail;
--DELETE FROM BookOrders;
--DELETE FROM Review;
--DELETE FROM Item;
--DELETE FROM Book_Author;
--DELETE FROM Book;
--DELETE FROM Publisher;
--DELETE FROM Author;
--DELETE FROM Category;
--DELETE FROM Users;
--DELETE FROM Roles;
--GO

-- Reset ID tự tăng (Tùy chọn)
--DBCC CHECKIDENT ('TransactionLog', RESEED, 0);
--DBCC CHECKIDENT ('BookOrderDetail', RESEED, 0);
--DBCC CHECKIDENT ('BookOrders', RESEED, 0);
--DBCC CHECKIDENT ('Review', RESEED, 0);
--DBCC CHECKIDENT ('Item', RESEED, 0);
--DBCC CHECKIDENT ('Book', RESEED, 0);
--DBCC CHECKIDENT ('Publisher', RESEED, 0);
--DBCC CHECKIDENT ('Author', RESEED, 0);
--DBCC CHECKIDENT ('Category', RESEED, 0);
--DBCC CHECKIDENT ('Users', RESEED, 0);
--DBCC CHECKIDENT ('Roles', RESEED, 0);
--GO

-- Dữ liệu cho bảng Roles
INSERT INTO Roles (RoleName) VALUES ('admin'), ('user');
GO

-- Dữ liệu cho bảng Users
DECLARE @AdminRoleID INT = (SELECT RoleID FROM Roles WHERE RoleName = 'admin');
DECLARE @UserRoleID INT = (SELECT RoleID FROM Roles WHERE RoleName = 'user');

INSERT INTO Users (Username, Password, FullName, RoleID, IsActive, Email, Phone) VALUES
('admin', 'placeholder_admin', N'Nguyễn Văn A', @AdminRoleID, 1, 'admin@example.com', '0123456789'),
('student', 'placeholder_student', N'Trần Thị B', @UserRoleID, 1, 'student@example.com', '0987654321'),
('anotheruser', 'placeholder_another', N'Lê Văn C', @UserRoleID, 0, 'anotheruser@example.com', '0123123123');

-- Cập nhật mật khẩu đã băm
UPDATE Users SET Password = '$2a$10$mGFljz0Wlz2DrMjLhsSWt.o6AlX98Oy0KYNpjGRs2JAxsIGNod6fy' WHERE Username = 'admin';
UPDATE Users SET Password = '$2a$12$J8.YkS.f9iZu9p.U7l3z4.a8jF3g8tX0eQ1hI6kM9zO5vL0rQ2eLq' WHERE Username = 'student'; -- Hash ví dụ
UPDATE Users SET Password = '$2a$12$K0p9.wX6tYgZ5.dF7vE1o.qZ0uR2iT3jS4lM5cN6wP7xV8yB9zA.G' WHERE Username = 'anotheruser'; -- Hash ví dụ
GO -- Kết thúc lô lệnh Users

-- Dữ liệu cho bảng Category
INSERT INTO Category (CategoryName) VALUES
(N'Công nghệ thông tin'), (N'Văn học'), (N'Kinh tế'), (N'Khoa học'), (N'Kỹ năng sống');
GO -- Kết thúc lô lệnh Category

-- Dữ liệu cho bảng Author
INSERT INTO Author (AuthorName) VALUES
(N'Nguyễn Nhật Ánh'), (N'Dale Carnegie'), (N'Yuval Noah Harari'), (N'J.K. Rowling'), (N'Robert C. Martin'),
(N'Robert T. Kiyosaki'), (N'Sharon Lechter');
GO -- Kết thúc lô lệnh Author

-- Dữ liệu cho bảng Publisher
INSERT INTO Publisher (PublisherName) VALUES
(N'NXB Giáo Dục'), (N'NXB Trẻ'), (N'NXB Tổng hợp TP.HCM'), (N'NXB Tri Thức'),
(N'Prentice Hall'), (N'NXB Kinh Tế Quốc Dân');
GO -- Kết thúc lô lệnh Publisher

-- Dữ liệu cho bảng Book
-- Khai báo lại biến CategoryID và PublisherID trong lô lệnh này
DECLARE @CatCNTT INT = (SELECT CategoryID FROM Category WHERE CategoryName = N'Công nghệ thông tin');
DECLARE @CatVanHoc INT = (SELECT CategoryID FROM Category WHERE CategoryName = N'Văn học');
DECLARE @CatKinhTe INT = (SELECT CategoryID FROM Category WHERE CategoryName = N'Kinh tế');
DECLARE @CatKhoaHoc INT = (SELECT CategoryID FROM Category WHERE CategoryName = N'Khoa học');
DECLARE @CatKyNang INT = (SELECT CategoryID FROM Category WHERE CategoryName = N'Kỹ năng sống');
DECLARE @PubGD INT = (SELECT PublisherID FROM Publisher WHERE PublisherName = N'NXB Giáo Dục');
DECLARE @PubTre INT = (SELECT PublisherID FROM Publisher WHERE PublisherName = N'NXB Trẻ');
DECLARE @PubTHHCM INT = (SELECT PublisherID FROM Publisher WHERE PublisherName = N'NXB Tổng hợp TP.HCM');
DECLARE @PubTriThuc INT = (SELECT PublisherID FROM Publisher WHERE PublisherName = N'NXB Tri Thức');
DECLARE @PubPrentice INT = (SELECT PublisherID FROM Publisher WHERE PublisherName = N'Prentice Hall');
DECLARE @PubKTQD INT = (SELECT PublisherID FROM Publisher WHERE PublisherName = N'NXB Kinh Tế Quốc Dân');

INSERT INTO Book (Title, PublishYear, [Description], PublisherID, ShelfLocation, CategoryID, ImageURL) VALUES
(N'Lập trình Java cơ bản', 2022, N'Sách dạy lập trình Java...', @PubGD, N'Kệ A1', @CatCNTT, 'java_basic.jpg'),
(N'Cho tôi xin một vé đi tuổi thơ', 2008, N'Một tác phẩm văn học...', @PubTre, N'Kệ B2', @CatVanHoc, 'cho_toi_xin_mot_ve.jpg'),
(N'Đắc nhân tâm', 1936, N'Nghệ thuật thu phục lòng người.', @PubTHHCM, N'Kệ C3', @CatKyNang, 'dac_nhan_tam.jpg'),
(N'Sapiens: Lược sử loài người', 2011, N'Khám phá lịch sử...', @PubTriThuc, N'Kệ D4', @CatKhoaHoc, 'sapiens.jpg'),
(N'Clean Code', 2008, N'Cẩm nang về viết mã sạch.', @PubPrentice, N'Kệ E5', @CatCNTT, 'clean_code.jpg'),
(N'Kinh tế học vĩ mô', 2020, N'Các nguyên lý cơ bản...', @PubKTQD, N'Kệ F6', @CatKinhTe, 'kinh_te_vi_mo.jpg'),
(N'Cha giàu Cha nghèo', 2000, N'Cuốn sách về tư duy tài chính.', @PubTre, N'Kệ G7', @CatKinhTe, 'cha_giau_cha_ngheo.jpg');
GO -- Kết thúc lô lệnh Book

-- Dữ liệu cho bảng Book_Author
-- Khai báo lại biến BookID và AuthorID trong lô lệnh này
DECLARE @BookTuoiTho INT = (SELECT BookID FROM Book WHERE Title = N'Cho tôi xin một vé đi tuổi thơ');
DECLARE @BookDacNhanTam INT = (SELECT BookID FROM Book WHERE Title = N'Đắc nhân tâm');
DECLARE @BookSapiens INT = (SELECT BookID FROM Book WHERE Title = N'Sapiens: Lược sử loài người');
DECLARE @BookCleanCode INT = (SELECT BookID FROM Book WHERE Title = N'Clean Code');
DECLARE @BookChaGiau INT = (SELECT BookID FROM Book WHERE Title = N'Cha giàu Cha nghèo');
DECLARE @AuthNNA INT = (SELECT AuthorID FROM Author WHERE AuthorName = N'Nguyễn Nhật Ánh');
DECLARE @AuthDale INT = (SELECT AuthorID FROM Author WHERE AuthorName = N'Dale Carnegie');
DECLARE @AuthHarari INT = (SELECT AuthorID FROM Author WHERE AuthorName = N'Yuval Noah Harari');
DECLARE @AuthMartin INT = (SELECT AuthorID FROM Author WHERE AuthorName = N'Robert C. Martin');
DECLARE @AuthKiyo INT = (SELECT AuthorID FROM Author WHERE AuthorName = N'Robert T. Kiyosaki');
DECLARE @AuthSharon INT = (SELECT AuthorID FROM Author WHERE AuthorName = N'Sharon Lechter');

INSERT INTO Book_Author (BookID, AuthorID) VALUES
(@BookTuoiTho, @AuthNNA),
(@BookDacNhanTam, @AuthDale),
(@BookSapiens, @AuthHarari),
(@BookCleanCode, @AuthMartin),
(@BookChaGiau, @AuthKiyo),
(@BookChaGiau, @AuthSharon);
GO -- Kết thúc lô lệnh Book_Author

-- Dữ liệu cho bảng Item
-- Khai báo lại biến BookID
DECLARE @BookJava INT = (SELECT BookID FROM Book WHERE Title = N'Lập trình Java cơ bản');
DECLARE @BookTuoiTho INT = (SELECT BookID FROM Book WHERE Title = N'Cho tôi xin một vé đi tuổi thơ');
DECLARE @BookDacNhanTam INT = (SELECT BookID FROM Book WHERE Title = N'Đắc nhân tâm');
DECLARE @BookSapiens INT = (SELECT BookID FROM Book WHERE Title = N'Sapiens: Lược sử loài người');
DECLARE @BookCleanCode INT = (SELECT BookID FROM Book WHERE Title = N'Clean Code');
DECLARE @BookKTMacro INT = (SELECT BookID FROM Book WHERE Title = N'Kinh tế học vĩ mô');
DECLARE @BookChaGiau INT = (SELECT BookID FROM Book WHERE Title = N'Cha giàu Cha nghèo');

INSERT INTO Item (BookID, ItemCode, Status) VALUES
(@BookJava, N'JAVA001', 'available'), (@BookJava, N'JAVA002', 'available'),
(@BookTuoiTho, N'TT001', 'available'), (@BookTuoiTho, N'TT002', 'available'),
(@BookDacNhanTam, N'DNT001', 'available'), (@BookDacNhanTam, N'DNT002', 'available'),
(@BookSapiens, N'SAP001', 'available'), (@BookSapiens, N'SAP002', 'available'),
(@BookCleanCode, N'CLEAN001', 'available'), (@BookCleanCode, N'CLEAN002', 'available'),
(@BookKTMacro, N'KTM001', 'available'), (@BookKTMacro, N'KTM002', 'available'),
(@BookChaGiau, N'CGCN001', 'available'), (@BookChaGiau, N'CGCN002', 'available');
GO -- Kết thúc lô lệnh Item

-- Dữ liệu cho bảng BookOrders và BookOrderDetail (Gộp chung lô lệnh)
-- Khai báo biến UserID, OrderID, ItemID
DECLARE @UserStudent INT = (SELECT UserID FROM Users WHERE Username = 'student');
DECLARE @UserAnother INT = (SELECT UserID FROM Users WHERE Username = 'anotheruser');

-- Chèn BookOrders và lấy ID ngay lập tức (nếu dùng SCOPE_IDENTITY() hoặc OUTPUT)
-- Hoặc chèn trước rồi truy vấn ID sau như dưới đây
INSERT INTO BookOrders (UserID, OrderDate, DueDate, ActualReturnDate, Status) VALUES
(@UserStudent, '2025-06-01', '2025-06-15', '2025-06-14', 'returned'),
(@UserStudent, '2025-06-20', '2025-07-04', NULL, 'approved'),
(@UserAnother, '2025-06-25', '2025-07-09', NULL, 'pending'),
(@UserStudent, '2025-05-10', '2025-05-24', '2025-05-28', 'returned');

-- Lấy OrderID vừa chèn (giả sử thứ tự không đổi, cách này không an toàn 100% nếu có insert đồng thời)
-- Cách an toàn hơn là dùng OUTPUT clause khi INSERT BookOrders
DECLARE @Order1 INT = (SELECT OrderID FROM BookOrders WHERE UserID=@UserStudent AND OrderDate='2025-06-01');
DECLARE @Order2 INT = (SELECT OrderID FROM BookOrders WHERE UserID=@UserStudent AND OrderDate='2025-06-20');
DECLARE @Order3 INT = (SELECT OrderID FROM BookOrders WHERE UserID=@UserAnother AND OrderDate='2025-06-25');
DECLARE @Order4 INT = (SELECT OrderID FROM BookOrders WHERE UserID=@UserStudent AND OrderDate='2025-05-10');

-- Lấy ItemID
DECLARE @ItemJava1 INT = (SELECT ItemID FROM Item WHERE ItemCode='JAVA001');
DECLARE @ItemDNT1 INT = (SELECT ItemID FROM Item WHERE ItemCode='DNT001');
DECLARE @ItemTT1 INT = (SELECT ItemID FROM Item WHERE ItemCode='TT001');
DECLARE @ItemSap1 INT = (SELECT ItemID FROM Item WHERE ItemCode='SAP001');

-- Chèn BookOrderDetail
INSERT INTO BookOrderDetail (OrderID, ItemID) VALUES
(@Order1, @ItemJava1),
(@Order2, @ItemDNT1),
(@Order3, @ItemTT1),
(@Order4, @ItemSap1);

-- Cập nhật trạng thái Item tương ứng
UPDATE Item SET Status = 'borrowed' WHERE ItemID IN (@ItemDNT1, @ItemTT1); -- Đơn approved và pending
-- Các item đã trả ('JAVA001', 'SAP001') mặc định là 'available' hoặc cần trigger xử lý khi trả
GO -- Kết thúc lô lệnh Order/Detail/Item Update

-- Dữ liệu cho bảng Review
-- Khai báo lại biến BookID và UserID
DECLARE @UserStudent INT = (SELECT UserID FROM Users WHERE Username = 'student');
DECLARE @UserAnother INT = (SELECT UserID FROM Users WHERE Username = 'anotheruser');
DECLARE @BookTuoiTho INT = (SELECT BookID FROM Book WHERE Title = N'Cho tôi xin một vé đi tuổi thơ');
DECLARE @BookDacNhanTam INT = (SELECT BookID FROM Book WHERE Title = N'Đắc nhân tâm');

INSERT INTO Review (BookID, UserID, Rating, Comment, CreatedAt) VALUES
(@BookTuoiTho, @UserStudent, 5, N'Sách rất hay, gợi nhớ tuổi thơ!', GETDATE()-10),
(@BookDacNhanTam, @UserStudent, 4, N'Nội dung hữu ích, nên đọc.', GETDATE()-5),
(@BookTuoiTho, @UserAnother, 4, N'Cũng được, đọc giải trí.', GETDATE()-1);
GO -- Kết thúc lô lệnh Review

-- Dữ liệu cho bảng LibraryRules
INSERT INTO LibraryRules (RuleName, RuleValue, Description) VALUES
('MaxBorrowDays', '14', N'Số ngày mượn tối đa'),
('FinePerDay', '5000', N'Phí mượn mỗi ngày (đúng hạn)'),
('OverdueFinePerDay', '10000', N'Phí phạt mỗi ngày (quá hạn)');
GO -- Kết thúc lô lệnh Rules

-- Dữ liệu cho bảng TransactionLog (Ví dụ)
-- Khai báo lại biến Admin, Order, Item
DECLARE @AdminUserID INT = (SELECT UserID FROM Users WHERE Username = 'admin');
DECLARE @Order2 INT = (SELECT OrderID FROM BookOrders WHERE UserID=(SELECT UserID FROM Users WHERE Username='student') AND OrderDate='2025-06-20');
DECLARE @ItemDNT1 INT = (SELECT ItemID FROM Item WHERE ItemCode='DNT001');
-- Giả sử admin là người duyệt đơn 2
-- INSERT INTO TransactionLog (OrderID, ItemID, LibrarianID, Action) VALUES (@Order2, @ItemDNT1, @AdminUserID, 'borrow'); -- Nên do trigger hoặc ứng dụng ghi
GO -- Kết thúc lô lệnh Log

PRINT '--- Dữ liệu mẫu đã được chèn vào database CatLib (phiên bản thống nhất) ---';