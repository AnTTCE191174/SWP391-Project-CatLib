CREATE TRIGGER trg_ProcessReturnAndCalculateBill
ON BookOrders
AFTER UPDATE
AS
BEGIN
    -- Ngăn không cho SQL Server gửi thông báo số dòng bị ảnh hưởng, giúp tăng hiệu năng
    SET NOCOUNT ON;

    -- Cập nhật các đơn hàng vừa được chuyển trạng thái thành 'returned'
    UPDATE bo
    SET
        -- 1. Cập nhật ngày trả thực tế là ngày hiện tại
        bo.ActualReturnDate = GETDATE(),

        -- 2. Tính toán hóa đơn (Bill) dựa trên logic
        bo.Bill =
            CASE
                -- TRƯỜNG HỢP 1: Trả sách đúng hạn hoặc sớm hơn (ngày hiện tại <= ngày phải trả)
                WHEN GETDATE() <= i.ReturnDate THEN
                    -- Tính 5.000 VNĐ cho mỗi ngày mượn.
                    -- DATEDIFF trả về số ngày chênh lệch. Nếu trả trong ngày, tính là 1 ngày.
                    (DATEDIFF(day, i.OrderDate, GETDATE()) + 1) * 5000

                -- TRƯỜNG HỢP 2: Trả sách trễ hạn (ngày hiện tại > ngày phải trả)
                ELSE
                    -- Phí cho giai đoạn mượn đúng hạn (tính 5.000/ngày)
                    (DATEDIFF(day, i.OrderDate, i.ReturnDate) * 5000)
                    +
                    -- Phí phạt cho những ngày trả trễ (tính 10.000/ngày)
                    (DATEDIFF(day, i.ReturnDate, GETDATE()) * 10000)
            END
    FROM
        BookOrders bo
    -- 'inserted' là bảng ảo chứa dữ liệu CỦA DÒNG SAU KHI được update
    INNER JOIN
        inserted i ON bo.OrderID = i.OrderID
    -- 'deleted' là bảng ảo chứa dữ liệu CỦA DÒNG TRƯỚC KHI được update
    INNER JOIN
        deleted d ON bo.OrderID = d.OrderID
    WHERE
        -- Chỉ thực thi khi trạng thái mới là 'returned'
        i.Status = 'returned'
        -- Và trạng thái cũ không phải là 'returned' (để tránh trigger chạy lại khi ta sửa thông tin khác của đơn hàng đã trả)
        AND d.Status <> 'returned';
END;