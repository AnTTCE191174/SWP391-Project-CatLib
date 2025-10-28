package com.CatLib.DAO;

import com.CatLib.Model.Comment;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CommentDAO {

    /**
     * Lấy tất cả comment (Đã sửa để lấy cả CommentID)
     */
    public static List<Comment> findCommentsByBookId(Connection conn, int bookId) {
        
        // SỬA Ở ĐÂY: Thêm "c.CommentID" vào câu SELECT
        String sql = "SELECT c.CommentID, u.username, c.commentText, CONVERT(varchar, c.createdAt, 103) AS commentDate "
                   + "FROM Comments c "
                   + "JOIN Users u ON c.userId = u.UserID "
                   + "WHERE c.bookId = ? "
                   + "ORDER BY c.createdAt DESC"; 

        List<Comment> commentList = new ArrayList<>();

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, bookId);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    // SỬA Ở ĐÂY: Lấy thêm "CommentID"
                    int commentId = rs.getInt("CommentID"); 
                    String username = rs.getString("username");
                    String text = rs.getString("commentText");
                    String date = rs.getString("commentDate");
                    
                    // SỬA Ở ĐÂY: Truyền ID vào constructor (Bạn sẽ phải sửa file Comment.java)
                    Comment comment = new Comment(commentId, username, text, date);
                    commentList.add(comment);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return commentList;
    }

    /**
     * Thêm comment mới
     */
    public static void addNewComment(Connection conn, int bookId, int userId, String commentText) {
        
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
    
    /**
     * PHƯƠNG THỨC MỚI: Dùng cho DeleteCommentServlet
     * Xoá một comment dựa trên ID
     */
    public static void deleteCommentById(Connection conn, int commentId) {
        
        // (Giả sử cột khoá chính của bạn là "CommentID")
        String sql = "DELETE FROM Comments WHERE CommentID = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, commentId);
            ps.executeUpdate(); // Thực thi lệnh DELETE
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}