/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.CatLib.Controller.admin;

import com.CatLib.DAO.UserDAO;
import com.CatLib.Model.User;
import com.CatLib.Ultis.MyUtils;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Connection;
import java.util.List;


@WebServlet(name = "UserManagerServlet", urlPatterns = {"/admin/user-manager"})
public class UserManagerServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        Connection conn = MyUtils.getStoredConnection(req);
        List<User> users = UserDAO.findAllUsers(conn);

        req.setAttribute("users", users);

        HttpSession session = req.getSession(false);
        if (session != null) {
            String message = (String) session.getAttribute("active");
            if (message != null) {
                req.setAttribute("active", message);
                session.removeAttribute("active");
            }
        }

        this.getServletContext().getRequestDispatcher("/views/admin/userManagerView.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

}
