CREATE TRIGGER trg_ApproveRejectOrder
ON BookOrders -- Đã sửa từ BookOrders thành [Order] để phù hợp với định nghĩa bảng bạn đã cung cấp
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON; -- Ngăn không cho các câu lệnh SELECT trong trigger trả về kết quả không mong muốn

    -- Bước 1: Tạo bảng tạm để xử lý thông tin các đơn hàng mới và số lượng sách hiện có
    CREATE TABLE #OrderProcessing (
        OrderID INT PRIMARY KEY,
        BookID INT,
        CurrentStock INT,
        NewStatus NVARCHAR(20) DEFAULT 'rejected' -- Mặc định ban đầu là 'rejected'
    );

    -- Chèn dữ liệu từ bảng 'inserted' (các hàng mới được thêm vào [Order])
    -- cùng với số lượng sách hiện tại từ bảng Book vào bảng tạm
    INSERT INTO #OrderProcessing (OrderID, BookID, CurrentStock)
    SELECT
        I.OrderID,
        I.BookID,
        B.StockQuantity
    FROM
        inserted I
    INNER JOIN
        Book B ON I.BookID = B.BookID;

    -- Bước 2: Xác định trạng thái cho các đơn hàng
    -- Nếu còn hàng (CurrentStock > 0), đặt trạng thái là 'pending'
    UPDATE T
    SET
        NewStatus = 'pending'
    FROM
        #OrderProcessing T
    WHERE
        T.CurrentStock > 0;

    -- Bước 3: Cập nhật trạng thái cuối cùng vào bảng '[Order]' gốc
    -- Áp dụng trạng thái ('pending' hoặc 'rejected') đã xác định trong bảng tạm vào bảng chính
    UPDATE O
    SET [status] = OP.NewStatus
    FROM BookOrders O
    INNER JOIN #OrderProcessing OP ON O.OrderID = OP.OrderID;

    -- Bước 4: Xóa bảng tạm để giải phóng tài nguyên
    DROP TABLE #OrderProcessing;

END;
