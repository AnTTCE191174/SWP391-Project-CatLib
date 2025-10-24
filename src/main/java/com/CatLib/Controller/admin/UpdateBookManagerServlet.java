/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.CatLib.Controller.admin;

import com.CatLib.DAO.BookDAO;
import com.CatLib.Model.Book;
import com.CatLib.Ultis.AdminUltil;
import com.CatLib.Ultis.MyUtils;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;


@WebServlet(urlPatterns = {"/admin/book-manager/update"})
public class UpdateBookManagerServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        PrintWriter out = resp.getWriter();
        String bookId = req.getParameter("id");
        Connection conn = MyUtils.getStoredConnection(req);
        Book book = BookDAO.findBookById(conn, bookId);

        Gson gson = new GsonBuilder()
                .setDateFormat("yyyy-MM-dd") // định dạng đúng theo chuẩn input type="date"
                .create();

        String jsonBook = gson.toJson(book);
        out.write(jsonBook);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String bookId = req.getParameter("id");
        String categoryId = req.getParameter("categories");
        String authorId = req.getParameter("authors");
        Book book = AdminUltil.GetBookDoPost(req);
        book.setBookId(Integer.parseInt(bookId));
        Connection conn = MyUtils.getStoredConnection(req);
        boolean isUpdate = BookDAO.updateBook(conn, book, categoryId, authorId);
        HttpSession session = req.getSession();
        if (isUpdate) {
            session.setAttribute("message", book.getTitle() + " has been successfully updated");
        } else {
            session.setAttribute("message", book.getTitle() + " has been updated unsuccessfully");
        }
        resp.sendRedirect(req.getContextPath() + "/admin/book-manager");

    }

}
