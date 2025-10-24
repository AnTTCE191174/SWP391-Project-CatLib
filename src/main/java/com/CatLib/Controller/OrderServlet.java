/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.CatLib.Controller;

import com.CatLib.DAO.OrderDAO;
import com.CatLib.Model.OrderModel;
import com.CatLib.Model.User;
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


@WebServlet(urlPatterns = {"/user/order"})
public class OrderServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User loginedUser = MyUtils.getLoginedUser(req.getSession());

        String status = req.getParameter("status");

        Connection conn = MyUtils.getStoredConnection(req);
        List<OrderModel> orders = OrderDAO.findOrderByStatus(conn, String.valueOf(loginedUser.getUserId()), status);

        req.setAttribute("orders", orders);
        req.setAttribute("status", status);
        RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/views/orderView.jsp");
        dispatcher.forward(req, resp);
    }

}
