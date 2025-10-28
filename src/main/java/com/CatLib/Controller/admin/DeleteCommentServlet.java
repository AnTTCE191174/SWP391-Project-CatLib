/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.CatLib.Controller.admin;

import com.CatLib.DAO.CommentDAO;
import com.CatLib.Ultis.MyUtils; // Import MyUtils giống như servlet kia
import com.CatLib.Model.User;    // Import User để kiểm tra admin

import java.io.IOException;
import java.sql.Connection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet này xử lý việc xoá comment của Admin.
 */
@WebServlet(urlPatterns = {"/admin/delete-comment"})
public class DeleteCommentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy bookId trước, để luôn biết đường quay lại
        String bookId = request.getParameter("bookId");
        String redirectURL = request.getContextPath() + "/comment?id=" + bookId;
        
        try {
            // --- KIỂM TRA QUYỀN ADMIN (Giống servlet mẫu) ---
            HttpSession session = request.getSession();
            User loginedUser = (User) session.getAttribute("loginedUser");

            // Nếu chưa đăng nhập hoặc không phải admin -> đá về trang chủ
            if (loginedUser == null || !"admin".equals(loginedUser.getRole())) {
                response.sendRedirect(request.getContextPath() + "/home");
                return; 
            }
            // --- Kết thúc kiểm tra ---


            // 1. Lấy Connection từ MyUtils (giống hệt DeleteBookManagerServlet)
            Connection conn = MyUtils.getStoredConnection(request);

            // 2. Lấy ID của comment cần xoá
            int commentId = Integer.parseInt(request.getParameter("commentId"));

            // 3. Gọi phương thức DAO (static) để xoá
            // (Phương thức này ta đã thêm vào CommentDAO ở bước trước)
            CommentDAO.deleteCommentById(conn, commentId);

        } catch (Exception e) {
            // Nếu có lỗi (ví dụ: commentId không phải là số)
            e.printStackTrace();
        } 
        
        // 4. Luôn luôn chuyển hướng Admin trở lại trang comment
        // (Servlet này không cần set "message" vì admin sẽ thấy comment biến mất ngay)
        response.sendRedirect(redirectURL);
    }
}