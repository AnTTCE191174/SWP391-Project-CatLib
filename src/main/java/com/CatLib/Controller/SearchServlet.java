/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.CatLib.Controller;

import com.CatLib.DAO.BookDAO;
import com.CatLib.DAO.CategoryDAO;
import com.CatLib.Model.Book;
import com.CatLib.Model.Category;
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


@WebServlet(urlPatterns = {"/search"})
public class SearchServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String input = req.getParameter("search");
        Connection conn = MyUtils.getStoredConnection(req);

        List<Book> books = BookDAO.searchBookByInput(conn, input);
        List<Category> category = CategoryDAO.findAllCategory(conn);
        if (books == null) {
            req.setAttribute("notFound", "notFound");
        } else {
            req.setAttribute("books", books);
        }
        req.setAttribute("tags", category);

        RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/views/homeView.jsp");
        dispatcher.forward(req, resp);
    }

}
