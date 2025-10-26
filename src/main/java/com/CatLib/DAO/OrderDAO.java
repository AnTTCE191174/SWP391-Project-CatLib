/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.CatLib.DAO;

import com.CatLib.Model.OrderModel;
import com.CatLib.Model.User;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    public static List<OrderModel> findALlOrder(Connection conn, User user) {
        String sql = "select o.OrderID, b.Title, a.authorName, b.Publisher, b.PublishDate, o.status, b.imageURL, \n"
                + " b.StockQuantity, o.OrderDate, o.ReturnDate from BookOrders o\n"
                + " join Book b on b.BookID = o.BookID\n"
                + " join Book_Author BA on BA.BookID = b.BookID\n"
                + " join Author a on a.AuthorID = BA.AuthorID\n"
                + " where o.UserId = ?\n"
                + " order by orderID desc";
        try {
            PreparedStatement pstm = conn.prepareStatement(sql);
            pstm.setString(1, String.valueOf(user.getUserId()));
            ResultSet rs = pstm.executeQuery();
            List<OrderModel> list = new ArrayList<>();
            while (rs.next()) {

//            int id = Integer.parseInt(rs.getString("bookid"));
                int orderId = rs.getInt("orderId");
                String title = rs.getString("title");
                String description = rs.getString("authorName");
                String publisher = rs.getString("Publisher");
                String publishDate = rs.getString("PublishDate");
                Date orderDate = rs.getDate("OrderDate");
                Date returnDate = rs.getDate("ReturnDate");
                String status = rs.getString("status");

                String url = rs.getString("imageURL");

                OrderModel order = new OrderModel(orderId, title, description,
                        publisher, publishDate, orderDate, returnDate, url, status);
                list.add(order);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e.toString());
        }
        return null;
    }

    public static List<OrderModel> findOrderByStatus(Connection conn, String userId, String status) {
        String sql;
        boolean hasStatus = (status != null && !status.isEmpty());

        if (!hasStatus) {
            sql = "select o.OrderID, b.Title, a.authorName, b.Publisher, b.PublishDate, o.status, b.imageURL,\n"
                    + " b.StockQuantity, o.OrderDate, o.ReturnDate from BookOrders o\n"
                    + " join Book b on b.BookID = o.BookID\n"
                    + " left join Book_Author BA on BA.BookID = b.BookID\n"
                    + " left join Author a on a.AuthorID = BA.AuthorID\n"
                    + " where o.UserId = ? \n"
                    + " order by orderID desc";
        } else {
            sql = "select o.OrderID, b.Title, a.authorName, b.Publisher, b.PublishDate, o.status, b.imageURL,\n"
                    + " b.StockQuantity, o.OrderDate, o.ReturnDate from BookOrders o\n"
                    + " join Book b on b.BookID = o.BookID\n"
                    + " left join Book_Author BA on BA.BookID = b.BookID\n"
                    + " left join Author a on a.AuthorID = BA.AuthorID\n"
                    + " where o.UserId = ? and o.status = ? \n" // <--- Sửa ở đây
                    + " order by orderID desc";
        }

        PreparedStatement pstm;
        try {
            pstm = conn.prepareStatement(sql);
            pstm.setString(1, userId); // Luôn set UserId

            if (hasStatus) {
                pstm.setString(2, status); // <--- Set tham số status an toàn
            }

            ResultSet rs = pstm.executeQuery();
            List<OrderModel> list = new ArrayList<>();
            // ... (phần còn lại của code giữ nguyên)
            // ...
        } catch (SQLException e) {
            System.out.println(e.toString());
        }
        return null;
    }

    public static boolean sendOrder(Connection conn, int userId, int bookId) {
        String insertSql = "INSERT INTO BookOrders (UserID, BookID, OrderDate, ReturnDate, "
                + "ActualReturnDate, Bill, Status) VALUES (?, ?, ?, ?, ?, ?, ?)";
        int borrowDurationDays = 14;
        LocalDate orderDate = LocalDate.now();
        LocalDate returnDate = orderDate.plusDays(borrowDurationDays);
        double defaultBill = 0.0;

        int newOrderId;

        try {
            try (PreparedStatement pstm = conn.prepareStatement(insertSql, Statement.RETURN_GENERATED_KEYS)) {
                pstm.setInt(1, userId);
                pstm.setInt(2, bookId);
                pstm.setDate(3, Date.valueOf(orderDate));
                pstm.setDate(4, Date.valueOf(returnDate));
                pstm.setNull(5, java.sql.Types.DATE); // ActualReturnDate: ban đầu là NULL
                pstm.setDouble(6, defaultBill);
                pstm.setNull(7, java.sql.Types.NVARCHAR); // Status: Trigger sẽ tự động gán giá trị
                int affectedRows = pstm.executeUpdate(); // Thực thi câu lệnh INSERT

                if (affectedRows == 0) {
                    System.out.println("Không thể chèn đơn hàng.");
                    return false; // Chèn không thành công
                }

                try (ResultSet generatedKeys = pstm.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        newOrderId = generatedKeys.getInt(1); // Lấy OrderID đầu tiên
                    } else {
                        System.out.println("Không thể lấy OrderID sau khi chèn.");
                        return false; // Không lấy được ID
                    }
                }
            }

            String selectStatusSql = "SELECT Status FROM BookOrders WHERE OrderID = ?";
            try (PreparedStatement statusPstm = conn.prepareStatement(selectStatusSql)) {
                statusPstm.setInt(1, newOrderId); // Sử dụng OrderID vừa lấy được
                try (ResultSet rs = statusPstm.executeQuery()) {
                    if (rs.next()) {
                        String finalStatus = rs.getString("Status");
                        // So sánh trạng thái và trả về true/false
                        return "pending".equalsIgnoreCase(finalStatus);
                    } else {
                        System.out.println("Không tìm thấy đơn hàng với OrderID đã chèn.");
                        return false; // Không tìm thấy đơn hàng (lỗi)
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi SQL khi gửi yêu cầu mượn sách: " + e.getMessage());
            // In stack trace để debug chi tiết hơn
            return false;
        }
    }

    public static boolean ActionOrder(Connection conn, String orderId, String action) {

        String sql = "update BookOrders set status = ? where orderId = ?";

        try (PreparedStatement pstm = conn.prepareStatement(sql)) {
            pstm.setString(1, action);
            pstm.setString(2, orderId);
            int affected = pstm.executeUpdate();
            return affected != 0;
        } catch (SQLException e) {
            System.out.println(e);
            return false;
        }
    }

}
