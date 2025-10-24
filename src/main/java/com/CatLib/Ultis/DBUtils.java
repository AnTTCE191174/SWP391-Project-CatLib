/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.CatLib.Ultis;

import com.CatLib.Model.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class DBUtils {

//    public static User findUser(Connection conn, //
//            String userName, String password) throws SQLException {
//
//        String sql = "Select username, password, full_name, role, is_active from Users u " //
//                + " where u.username = ? and u.password= ?";
//
//        PreparedStatement pstm = conn.prepareStatement(sql);
//        pstm.setString(1, userName);
//        pstm.setString(2, password);
//        ResultSet rs = pstm.executeQuery();
//
//        if (rs.next()) {
//            String fullName = rs.getString("full_name");
//            String role = rs.getString("role");
//            boolean isActive = rs.getString("is_active").equals("1");
//
//            User user = new User(userName, password, fullName, role, isActive);
//
//            return user;
//        }
//        return null;
//    }
//
//    public static User findUser(Connection conn, String userName) throws SQLException {
//
//        String sql = "Select * from Users u " //
//                + " where u.username = ?";
//
//        PreparedStatement pstm = conn.prepareStatement(sql);
//        pstm.setString(1, userName);
//
//        ResultSet rs = pstm.executeQuery();
//
//        if (rs.next()) {
//            String password = rs.getString("password");
//            String fullName = rs.getString("full_name");
//            String email = rs.getString("email");
//            String phone = rs.getString("phone_number");
//            String address = rs.getString("address");
//            String role = rs.getString("role");
//            boolean isActive = rs.getString("is_active").equals("1");
//            User user = new User(userName, password, email, fullName, phone, address, role, isActive);
//
//            return user;
//        }
//        return null;
//    }

//    public static List<Product> queryProduct(Connection conn) throws SQLException {
//        String sql = "Select a.Code, a.Name, a.Price from Product a ";
//
//        PreparedStatement pstm = conn.prepareStatement(sql);
//
//        ResultSet rs = pstm.executeQuery();
//        List<Product> list = new ArrayList<>();
//        while (rs.next()) {
//            String code = rs.getString("Code");
//            String name = rs.getString("Name");
//            float price = rs.getFloat("Price");
//            Product product = new Product();
//            product.setCode(code);
//            product.setName(name);
//            product.setPrice(price);
//            list.add(product);
//        }
//        return list;
//    }
//
//    public static Product findProduct(Connection conn, String code) throws SQLException {
//        String sql = "Select a.Code, a.Name, a.Price from Product a where a.Code=?";
//
//        PreparedStatement pstm = conn.prepareStatement(sql);
//        pstm.setString(1, code);
//
//        ResultSet rs = pstm.executeQuery();
//
//        while (rs.next()) {
//            String name = rs.getString("Name");
//            float price = rs.getFloat("Price");
//            Product product = new Product(code, name, price);
//            return product;
//        }
//        return null;
//    }
//
//    public static void updateProduct(Connection conn, Product product) throws SQLException {
//        String sql = "Update Product set Name =?, Price=? where Code=? ";
//
//        PreparedStatement pstm = conn.prepareStatement(sql);
//
//        pstm.setString(1, product.getName());
//        pstm.setFloat(2, product.getPrice());
//        pstm.setString(3, product.getCode());
//        pstm.executeUpdate();
//    }
//
//    public static void insertProduct(Connection conn, Product product) throws SQLException {
//        String sql = "Insert into Product(Code, Name,Price) values (?,?,?)";
//
//        PreparedStatement pstm = conn.prepareStatement(sql);
//
//        pstm.setString(1, product.getCode());
//        pstm.setString(2, product.getName());
//        pstm.setFloat(3, product.getPrice());
//
//        pstm.executeUpdate();
//    }
//
//    public static void deleteProduct(Connection conn, String code) throws SQLException {
//        String sql = "Delete From Product where Code= ?";
//
//        PreparedStatement pstm = conn.prepareStatement(sql);
//
//        pstm.setString(1, code);
//
//        pstm.executeUpdate();
//    }
}
