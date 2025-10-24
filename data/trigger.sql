CREATE TRIGGER trg_UpdateStockQuantity
ON BookOrders
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Giảm số lượng sách khi trạng thái chuyển sang 'approved'
    UPDATE B
    SET B.StockQuantity = B.StockQuantity - 1
    FROM Book B
    INNER JOIN inserted i ON B.BookID = i.BookID
    INNER JOIN deleted d ON i.OrderID = d.OrderID
    WHERE i.Status = 'approved' AND d.Status != 'approved';

    -- Tăng số lượng sách khi trạng thái chuyển sang 'returned'
    UPDATE B
    SET B.StockQuantity = B.StockQuantity + 1
    FROM Book B
    INNER JOIN inserted i ON B.BookID = i.BookID
    INNER JOIN deleted d ON i.OrderID = d.OrderID
    WHERE i.Status = 'returned' AND d.Status != 'returned';
END;
