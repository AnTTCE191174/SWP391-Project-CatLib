/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.CatLib.DAO;

import com.CatLib.Model.Category;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class CategoryDAO {

    public static List<Category> findAllCategory(Connection conn) {
        String sql = "select * from Category";
        try {
            PreparedStatement pstm = conn.prepareStatement(sql);

            ResultSet rs = pstm.executeQuery();
            List<Category> list = new ArrayList<>();
            while (rs.next()) {
                int id = Integer.parseInt(rs.getString("categoryId"));
                String name = rs.getString("categoryName");

                Category category = new Category(id, name);
                list.add(category);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e.toString());
        }
        return null;

    }
}
