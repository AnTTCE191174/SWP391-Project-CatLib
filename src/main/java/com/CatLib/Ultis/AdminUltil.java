/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.CatLib.Ultis;

import com.CatLib.Model.Book;
import jakarta.servlet.http.HttpServletRequest;
import java.sql.Date;


public class AdminUltil {
    public static Book GetBookDoPost(HttpServletRequest req) {
        String title = req.getParameter("title");
        String publishDate = req.getParameter("publishDate");
        String publisher = req.getParameter("publisher");
        String stockQuantity = req.getParameter("stockQuantity");
        String description = req.getParameter("description");
        String imageUrl = req.getParameter("imagePath");

        return new Book(title, Date.valueOf(publishDate), publisher, Integer.parseInt(stockQuantity), description, imageUrl);
        
    }
}
