-- Dữ liệu cho bảng Category
INSERT INTO Category (CategoryName) VALUES
(N'Công nghệ thông tin'),
(N'Văn học'),
(N'Kinh tế'),
(N'Khoa học'),
(N'Kỹ năng sống');

-- Dữ liệu cho bảng Author
INSERT INTO Author (AuthorName) VALUES
(N'Nguyễn Nhật Ánh'),
(N'Dale Carnegie'),
(N'Yuval Noah Harari'),
(N'J.K. Rowling'),
(N'Robert C. Martin');

-- Dữ liệu cho bảng Users
INSERT INTO Users (username, password, full_name, role, is_active, email, phone) VALUES
('admin', 'hashed_password_admin', N'Nguyễn Văn A', 'admin', 1, 'admin@example.com', '0123456789'),
('student', 'hashed_password_user', N'Trần Thị B', 'user', 1, 'student@example.com', '0987654321'),
('anotheruser', 'hashed_password_another', N'Lê Văn C', 'user', 0, 'anotheruser@example.com', '0123123123');
UPDATE Users
SET password = '$2a$10$mGFljz0Wlz2DrMjLhsSWt.o6AlX98Oy0KYNpjGRs2JAxsIGNod6fy'
WHERE username = 'admin';



-- Dữ liệu cho bảng Book
INSERT INTO Book (Title, PublishDate, [Description], Publisher, StockQuantity, CategoryID, ImageURL) VALUES
(N'Lập trình Java cơ bản', '2022-01-15', N'Sách dạy lập trình Java từ những khái niệm đầu tiên.', N'NXB Giáo Dục', 10, 1, 'http://example.com/images/java_basic.jpg'),
(N'Cho tôi xin một vé đi tuổi thơ', '2008-03-24', N'Một tác phẩm văn học nổi tiếng của Nguyễn Nhật Ánh.', N'NXB Trẻ', 15, 2, 'http://example.com/images/cho_toi_xin_mot_ve.jpg'),
(N'Đắc nhân tâm', '1936-10-01', N'Nghệ thuật thu phục lòng người.', N'NXB Tổng hợp TP.HCM', 20, 5, 'http://example.com/images/dac_nhan_tam.jpg'),
(N'Sapiens: Lược sử loài người', '2011-01-01', N'Khám phá lịch sử phát triển của loài người.', N'NXB Tri Thức', 8, 4, 'http://example.com/images/sapiens.jpg'),
(N'Clean Code', '2008-08-01', N'Cẩm nang về viết mã sạch.', N'Prentice Hall', 5, 1, 'http://example.com/images/clean_code.jpg'),
(N'Kinh tế học vĩ mô', '2020-05-20', N'Các nguyên lý cơ bản của kinh tế học vĩ mô.', N'NXB Kinh Tế Quốc Dân', 12, 3, 'http://example.com/images/kinh_te_vi_mo.jpg');


-- Dữ liệu cho bảng Book_Author (Mối quan hệ nhiều-nhiều)
INSERT INTO Book_Author (BookID, AuthorID) VALUES
(2, 1), -- Cho tôi xin một vé đi tuổi thơ - Nguyễn Nhật Ánh
(3, 2), -- Đắc nhân tâm - Dale Carnegie
(4, 3), -- Sapiens: Lược sử loài người - Yuval Noah Harari
(5, 5); -- Clean Code - Robert C. Martin

-- Dữ liệu cho bảng BookOrders
INSERT INTO BookOrders (UserID, BookID, OrderDate, ReturnDate, ActualReturnDate, Bill, Status) VALUES
(2, 1, '2025-06-01', '2025-06-15', '2025-06-14', 0.00, 'returned'),
(2, 3, '2025-06-20', '2025-07-04', NULL, 0.00, 'approved'),
(3, 2, '2025-06-25', '2025-07-09', NULL, 0.00, 'pending'),
(2, 4, '2025-05-10', '2025-05-24', '2025-05-28', 15000.00, 'overdue');