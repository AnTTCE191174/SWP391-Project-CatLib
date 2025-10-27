/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.CatLib.DAO;

import com.CatLib.Model.Author;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;


public class AuthorDAO {

    public static List<Author> findAllAuthor(Connection conn) {
        String sql = "select authorID, authorName from Author";
        List<Author> list;
        PreparedStatement pstm;
        try {
            pstm = conn.prepareStatement(sql);
            ResultSet rs = pstm.executeQuery();
            list = new ArrayList<>();
            while (rs.next()) {
                int id = Integer.parseInt(rs.getString("authorID"));

                String authorName = rs.getString("authorName");
                Author author = new Author(id, authorName);
                list.add(author);
            }
            return list;

        } catch (SQLException ex) {
            Logger.getLogger(BookDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
}
