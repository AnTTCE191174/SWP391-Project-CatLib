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
        // Chỉ lấy những Category CÓ SÁCH LIÊN KẾT
        // DISTINCT đảm bảo mỗi category chỉ xuất hiện 1 lần dù có nhiều sách
        String sql = "SELECT DISTINCT c.CategoryID, c.CategoryName "
                + "FROM Category c "
                + "INNER JOIN Book b ON c.CategoryID = b.CategoryID "
                + // Chỉ lấy category nào có trong bảng Book
                "ORDER BY c.CategoryName"; // Sắp xếp theo tên cho dễ nhìn
        try {
            PreparedStatement pstm = conn.prepareStatement(sql);
            ResultSet rs = pstm.executeQuery();
            List<Category> list = new ArrayList<>();
            while (rs.next()) {
                int id = rs.getInt("CategoryID");
                String name = rs.getString("CategoryName");
                Category category = new Category(id, name);
                list.add(category);
            }
            return list;
        } catch (SQLException e) {
            // Nên ghi log lỗi chi tiết hơn thay vì chỉ in ra console
            // Logger.getLogger(CategoryDAO.class.getName()).log(Level.SEVERE, null, e); 
            System.out.println("Lỗi khi lấy danh sách Category: " + e.toString());
        }
        return null; // hoặc trả về new ArrayList<>() để tránh lỗi NullPointerException ở Servlet
    }
}
