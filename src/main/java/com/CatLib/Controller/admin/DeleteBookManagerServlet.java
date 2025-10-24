/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.CatLib.Controller.admin;

import com.CatLib.DAO.BookDAO;
import com.CatLib.Ultis.MyUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;


@WebServlet(urlPatterns = {"/admin/book-manager/delete"})
public class DeleteBookManagerServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String id = req.getParameter("id");
        Connection conn = MyUtils.getStoredConnection(req);
        HttpSession session = req.getSession();
        boolean isDeleted = BookDAO.deleteBook(conn, id);
        if (isDeleted) {
            session.setAttribute("message", "The book with ID = " + id + " has been successfully erased");
        } else {
            session.setAttribute("message", "The book with ID = " + id + " is lending or does not exist");
        }

        resp.sendRedirect(req.getContextPath() + "/admin/book-manager");

    }
}
