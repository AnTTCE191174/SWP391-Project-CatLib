/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.CatLib.Controller.admin;

import com.CatLib.DAO.BookDAO;
import com.CatLib.Model.Book;
import com.CatLib.Ultis.AdminUltil;
import com.CatLib.Ultis.MyUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;


@WebServlet(urlPatterns = {"/admin/book-manager/add"})
public class AddBookManagerServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String categoryId = req.getParameter("categories");
        String authorId = req.getParameter("authors");
        Book book = AdminUltil.GetBookDoPost(req);
        Connection conn = MyUtils.getStoredConnection(req);
        boolean isAdd = BookDAO.createBook(conn, book, categoryId, authorId);
        HttpSession session = req.getSession();
        if (isAdd) {
            session.setAttribute("message", book.getTitle() + " has been added success");
        } else {
            session.setAttribute("message", "There is a problem when adding " + book.getTitle());
        }
        resp.sendRedirect(req.getContextPath() + "/admin/book-manager");
    }
}
