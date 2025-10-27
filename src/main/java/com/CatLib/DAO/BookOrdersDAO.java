package com.CatLib.DAO;

import com.CatLib.Model.Book;
import com.CatLib.Model.BookOrders;
import com.CatLib.Model.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

// ===== THÊM IMPORT NÀY =====
import java.sql.Date; 
import java.time.LocalDate;
// ==========================

public class BookOrdersDAO {

    public static List<BookOrders> findOverdueOrders(Connection conn) {
        
        // Sửa câu SQL: Thêm điều kiện AND LastReminderSentDate IS NULL
        String sql = "SELECT "
                + "bo.orderId, bo.ReturnDate, bo.status, bo.userId, bo.bookId, "
                + "u.email, u.full_name, " 
                + "b.title "
                + "FROM BookOrders bo "
                + "JOIN Users u ON bo.userId = u.userId "
                + "JOIN Book b ON bo.bookId = b.bookId "
                + "WHERE LOWER(TRIM(bo.status)) = 'overdue' "
                + "AND bo.LastReminderSentDate IS NULL"; // <-- CHỈ LẤY NHỮNG ĐƠN CHƯA GỬI MAIL

        List<BookOrders> list = new ArrayList<>();
        PreparedStatement pstm = null;
        ResultSet rs = null;

        try {
            pstm = conn.prepareStatement(sql);
            rs = pstm.executeQuery();

            while (rs.next()) {
                // ... (code tạo User, Book, Order vẫn như cũ)
                User user = new User();
                user.setUserId(rs.getInt("userId"));
                user.setEmail(rs.getString("email"));
                user.setFullName(rs.getString("full_name")); 

                Book book = new Book();
                book.setBookId(rs.getInt("bookId"));
                book.setTitle(rs.getString("title")); 

                BookOrders order = new BookOrders();
                order.setOrderId(rs.getInt("orderId"));
                order.setStatus(rs.getString("status"));
                order.setDueDate(rs.getTimestamp("ReturnDate")); 
                
                order.setUser(user);
                order.setBook(book);

                list.add(order);
            }
        } catch (SQLException ex) {
            Logger.getLogger(BookOrdersDAO.class.getName()).log(Level.SEVERE, "LỖI KHI ĐỌC ResultSet", ex);
        } finally {
            // Đóng rs và pstm (Connection sẽ đóng ở lớp gọi)
             try {
                if (rs != null) rs.close();
                if (pstm != null) pstm.close();
            } catch (SQLException e) { e.printStackTrace(); }
        }
        
        return list; 
    }

    public static boolean updateLastReminderDate(int orderId, Connection conn) {
        String sql = "UPDATE BookOrders SET LastReminderSentDate = ? WHERE orderId = ?";
        PreparedStatement pstm = null;
        try {
            pstm = conn.prepareStatement(sql);
            // Lấy ngày hiện tại
            Date today = Date.valueOf(LocalDate.now()); 
            pstm.setDate(1, today);
            pstm.setInt(2, orderId);
            
            int rowsAffected = pstm.executeUpdate();
            return rowsAffected > 0; // Trả về true nếu cập nhật thành công
            
        } catch (SQLException ex) {
            Logger.getLogger(BookOrdersDAO.class.getName()).log(Level.SEVERE, "LỖI KHI CẬP NHẬT LastReminderSentDate", ex);
            return false;
        } finally {
             try {
                if (pstm != null) pstm.close();
            } catch (SQLException e) { e.printStackTrace(); }
        }
    }
}