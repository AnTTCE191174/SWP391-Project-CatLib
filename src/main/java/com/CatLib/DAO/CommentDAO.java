package com.CatLib.DAO;

import com.CatLib.Model.Comment;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CommentDAO {

    /**
     * Phương thức này được gọi bởi CommentServlet
     * Lấy tất cả comment (Đã sửa cho SQL SERVER)
     */
    public static List<Comment> findCommentsByBookId(Connection conn, int bookId) {
        
        // Dùng CONVERT(varchar, ..., 103) thay vì DATE_FORMAT (103 = dd/mm/yyyy)
        // Dùng Users(UserID) và Book(BookID) để khớp với file CatLib.sql
        String sql = "SELECT u.username, c.commentText, CONVERT(varchar, c.createdAt, 103) AS commentDate "
                   + "FROM Comments c "
                   + "JOIN Users u ON c.userId = u.UserID " // Khớp với 'UserID' của bảng Users
                   + "WHERE c.bookId = ? "
                   + "ORDER BY c.createdAt DESC"; 

        List<Comment> commentList = new ArrayList<>();

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, bookId);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    String username = rs.getString("username");
                    String text = rs.getString("commentText");
                    String date = rs.getString("commentDate");
                    
                    Comment comment = new Comment(username, text, date);
                    commentList.add(comment);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return commentList;
    }

    /**
     * Phương thức này được gọi bởi AddCommentServlet
     * Thêm comment mới (Đã sửa cho SQL SERVER)
     */
    public static void addNewComment(Connection conn, int bookId, int userId, String commentText) {
        
        // Dùng GETDATE() thay vì NOW()
        String sql = "INSERT INTO Comments (bookId, userId, commentText, createdAt) "
                   + "VALUES (?, ?, ?, GETDATE())"; 

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, bookId);
            ps.setInt(2, userId);
            ps.setString(3, commentText);
            
            ps.executeUpdate(); // Thực thi lệnh INSERT
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}