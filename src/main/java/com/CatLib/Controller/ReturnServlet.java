/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.CatLib.Controller;

import com.CatLib.DAO.OrderDAO;
import com.CatLib.Ultis.MyUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;


@WebServlet(name = "ReturnServlet", urlPatterns = {"/user/return"})
public class ReturnServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String orderId = req.getParameter("id");
        Connection conn = MyUtils.getStoredConnection(req);
//        OrderDAO.returnOrder(conn, Integer.parseInt(orderId));
        
        resp.sendRedirect(req.getContextPath() + "/user/order?status=returned");
    }

}
