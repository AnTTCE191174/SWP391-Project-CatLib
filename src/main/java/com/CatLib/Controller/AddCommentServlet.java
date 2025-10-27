package com.CatLib.Controller;

import com.CatLib.DAO.CommentDAO;
import com.CatLib.Ultis.MyUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;

@WebServlet(urlPatterns = {"/add-comment"})
public class AddCommentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        String bookIdStr = req.getParameter("bookId");
        String userIdStr = req.getParameter("userId");
        String commentText = req.getParameter("commentText");

        // Luôn chuyển hướng về trang comment, dù thành công hay thất bại
        // Sửa: URL phải là "/comment" (giống servlet của bạn) chứ không phải "/add-comment"
        String redirectURL = req.getContextPath() + "/comment?id=" + bookIdStr;

        try {
            // --- KIỂM TRA DỮ LIỆU ĐẦU VÀO ---
            
            // 1. Kiểm tra userId và bookId có rỗng không
            if (userIdStr == null || userIdStr.isEmpty() || bookIdStr == null || bookIdStr.isEmpty()) {
                System.out.println("AddCommentServlet Error: userId hoặc bookId bị rỗng.");
                resp.sendRedirect(redirectURL);
                return; // Dừng lại
            }
            
            // 2. Kiểm tra bình luận có rỗng không (trim() để xóa khoảng trắng thừa)
            if (commentText == null || commentText.trim().isEmpty()) {
                System.out.println("AddCommentServlet Info: Người dùng gửi bình luận rỗng.");
                resp.sendRedirect(redirectURL);
                return; // Dừng lại, không lưu bình luận rỗng
            }

            // --- XỬ LÝ DỮ LIỆU ---
            
            int bookId = Integer.parseInt(bookIdStr);
            int userId = Integer.parseInt(userIdStr);

            Connection conn = MyUtils.getStoredConnection(req);

            // 3. Gọi DAO để lưu vào database
            CommentDAO.addNewComment(conn, bookId, userId, commentText.trim()); // Dùng trim() để lưu text sạch

            // 4. Chuyển hướng người dùng TRỞ LẠI trang comment
            resp.sendRedirect(redirectURL);

        } catch (NumberFormatException e) {
            // Lỗi này xảy ra nếu Integer.parseInt(userIdStr) thất bại
            e.printStackTrace();
            System.out.println("AddCommentServlet Error: NumberFormatException - " + e.getMessage());
            resp.sendRedirect(redirectURL); // Vẫn chuyển hướng về trang cũ
            
        } catch (Exception e) {
            e.printStackTrace();
            // Xử lý các lỗi khác (ví dụ: lỗi SQL)
            resp.sendRedirect(redirectURL); // Vẫn chuyển hướng về trang cũ
        }
    }
}