package com.CatLib.Controller.admin;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
import com.CatLib.DAO.UserDAO;
import com.CatLib.Ultis.MyUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;


@WebServlet(urlPatterns = {"/admin/user-manager/deactivate"})
public class DeactivateUserManagerServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        boolean isActive = Boolean.parseBoolean(req.getParameter("isActive"));
        Connection conn = MyUtils.getStoredConnection(req);
        boolean isSuccess = UserDAO.activeUser(conn, id, isActive);
        HttpSession session = req.getSession();
        if (isSuccess) {
            session.setAttribute("active", "Users have been " + (isActive ? "actived" : "deativate") + " successfully");
        } else {
            session.setAttribute("active", "Users have been " + (isActive ? "actived" : "deativate") + " unsuccessfully");
        }
        resp.sendRedirect(req.getContextPath() + "/admin/user-manager");

    }
}
