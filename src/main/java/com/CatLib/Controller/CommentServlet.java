package com.CatLib.Controller;

import com.CatLib.DAO.BookDAO;
import com.CatLib.DAO.CommentDAO;
import com.CatLib.Model.Book;
import com.CatLib.Model.Comment; 
import com.CatLib.Ultis.MyUtils;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;

@WebServlet(urlPatterns = {"/comment"})
public class CommentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        Connection conn = MyUtils.getStoredConnection(req);
        
        // 1. Lấy bookId (dưới dạng String) từ URL
        String bookIdStr = req.getParameter("id");

        // --- SỬA LỖI 1: Kiểm tra ID (String) có null hay rỗng không ---
        if (bookIdStr == null || bookIdStr.isEmpty()) {
            // Nếu không có ID, chuyển về trang chủ
            resp.sendRedirect(req.getContextPath() + "/home");
            return; // Dừng servlet
        }

        try {
            // --- BƯỚC 2: Gọi BookDAO bằng String ---
            // (Giả sử BookDAO.findBookById đã được đổi để nhận String)
            Book book = BookDAO.findBookById(conn, bookIdStr); 

            // --- BƯỚC 3: Kiểm tra sách có tồn tại không ---
            if (book == null) {
                // Nếu không tìm thấy sách (DAO trả về null)
                resp.sendRedirect(req.getContextPath() + "/home"); // Chuyển về home
                return; // Dừng servlet
            }
            
            // --- BƯỚC 4: Lấy comment (vẫn dùng int) ---
            // Bây giờ mới parse sang int, và bắt lỗi NumberFormatException ở đây
            int bookIdInt = Integer.parseInt(bookIdStr);
            List<Comment> comments = CommentDAO.findCommentsByBookId(conn, bookIdInt);

            // --- BƯỚC 5: Gửi dữ liệu qua JSP ---
            req.setAttribute("book", book);
            req.setAttribute("comments", comments);

            // --- BƯỚC 6: Chuyển tiếp ---
            RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/views/commentView.jsp");
            dispatcher.forward(req, resp);

        } catch (NumberFormatException e) {
            // Lỗi này xảy ra nếu ID là "abc" (không phải số)
            // (Vì CommentDAO cần số)
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/home");
        } catch (Exception e) {
            e.printStackTrace();
            // Xử lý các lỗi chung khác (ví dụ: lỗi SQL)
        }
    }
}