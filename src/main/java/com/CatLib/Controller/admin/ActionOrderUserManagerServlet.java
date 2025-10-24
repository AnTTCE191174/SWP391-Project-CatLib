/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.CatLib.Controller.admin;

import com.CatLib.DAO.OrderDAO;
import com.CatLib.Ultis.MyUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;


@WebServlet(urlPatterns = {"/admin/user-manager/action"})
public class ActionOrderUserManagerServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String orderId = req.getParameter("id");
        String action = req.getParameter("action");
        String userId = req.getParameter("userId");
        Connection conn = MyUtils.getStoredConnection(req);

        boolean isSucces = OrderDAO.ActionOrder(conn, orderId, action);
        HttpSession session = req.getSession();
        if (isSucces) {
            session.setAttribute("messageAction", action + " successful book");
        } else {
            session.setAttribute("messageAction", action + " unsuccessful book");
        }
        resp.sendRedirect(req.getContextPath() + "/admin/user-manager/order?id=" + userId);

    }
}
