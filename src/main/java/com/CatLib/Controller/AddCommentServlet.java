package com.CatLib.Controller;

import com.CatLib.DAO.CommentDAO;
import com.CatLib.Ultis.MyUtils;
import com.CatLib.Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;

@WebServlet(urlPatterns = {"/add-comment"})
public class AddCommentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        // --- LẤY USER TỪ SESSION (AN TOÀN) ---
        HttpSession session = req.getSession(false); // Lấy session hiện có, không tạo mới
        User loginedUser = MyUtils.getLoginedUser(session);

        // --- KIỂM TRA ĐĂNG NHẬP ---
        if (loginedUser == null) {
            // Nếu chưa đăng nhập, chuyển về trang login hoặc trang sách
            resp.sendRedirect(req.getContextPath() + "/login"); // Hoặc trang sách nếu muốn
            return; // Dừng servlet
        }

        // --- Lấy userId từ đối tượng User đã đăng nhập ---
        int userId = loginedUser.getUserId();

        // --- Lấy các thông tin khác từ form ---
        String bookIdStr = req.getParameter("bookId");
        String commentText = req.getParameter("commentText");

        // --- URL chuyển hướng (vẫn giữ nguyên) ---
        String redirectURL = req.getContextPath() + "/comment?id=" + bookIdStr;

        try {
            // --- KIỂM TRA DỮ LIỆU ĐẦU VÀO (bỏ kiểm tra userIdStr rỗng) ---

            // 1. Kiểm tra bookId có rỗng không
            if (bookIdStr == null || bookIdStr.isEmpty()) {
                System.out.println("AddCommentServlet Error: bookId bị rỗng.");
                resp.sendRedirect(redirectURL);
                return; // Dừng lại
            }

            // 2. Kiểm tra bình luận có rỗng không
            if (commentText == null || commentText.trim().isEmpty()) {
                System.out.println("AddCommentServlet Info: Người dùng gửi bình luận rỗng.");
                resp.sendRedirect(redirectURL);
                return; // Dừng lại
            }

            // --- XỬ LÝ DỮ LIỆU ---
            int bookId = Integer.parseInt(bookIdStr);
            // userId đã lấy an toàn từ session ở trên

            Connection conn = MyUtils.getStoredConnection(req);

            // 3. Gọi DAO để lưu vào database
            CommentDAO.addNewComment(conn, bookId, userId, commentText.trim());

            // 4. Chuyển hướng người dùng TRỞ LẠI trang comment
            resp.sendRedirect(redirectURL);

        } catch (NumberFormatException e) {
            // Lỗi parse bookIdStr
            e.printStackTrace();
            System.out.println("AddCommentServlet Error: NumberFormatException - " + e.getMessage());
            resp.sendRedirect(redirectURL);

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(redirectURL);
        }
    }
}
