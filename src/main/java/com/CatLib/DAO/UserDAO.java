/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.CatLib.DAO;

import com.CatLib.Model.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import org.mindrot.jbcrypt.BCrypt;

public class UserDAO {

    public static User findUser(Connection conn, //
            String userName, String password) {

        String sql = "Select userId, username, password, full_name, role, is_active from Users u " //
                + " where u.username = ?";
        try {
            PreparedStatement pstm = conn.prepareStatement(sql);
            pstm.setString(1, userName);
            ResultSet rs = pstm.executeQuery();

            while (rs.next()) {
                String hashedPassword = rs.getString("password");
                if (BCrypt.checkpw(password, hashedPassword)) {
                    int userId = Integer.parseInt(rs.getString("userId"));
                    String fullName = rs.getString("full_name");
                    String role = rs.getString("role");
                    boolean isActive = rs.getString("is_active").equals("1");

                    User user = new User(userId, userName, null, fullName, role, isActive);
                    return user;
                }
            }
            return null;
        } catch (SQLException e) {
            System.out.println(e.toString());
        }

        return null;
    }

    public static User findUser(Connection conn, String userName) {

        String sql = "Select * from Users u " //
                + " where u.username = ?";
        try {
            PreparedStatement pstm = conn.prepareStatement(sql);
            pstm.setString(1, userName);

            ResultSet rs = pstm.executeQuery();

//         public User(int userId, String username, String password, String fullName,
//            String role, boolean isActive, String email, String phone) {
            if (rs.next()) {
                String password = rs.getString("password");
                String fullName = rs.getString("full_name");
                String email = rs.getString("email");
                String phone = rs.getString("phone_number");
                String role = rs.getString("role");
                boolean isActive = rs.getString("is_active").equals("1");
                User user = new User(userName, password, fullName, role, isActive, email, phone);

                return user;
            }
        } catch (SQLException e) {
            System.out.println(e.toString());
        }

        return null;
    }

    public static User findUserById(Connection conn, String userId) {
        String sql = "Select * from Users u " //
                + " where u.userId = ?";
        try {
            PreparedStatement pstm = conn.prepareStatement(sql);
            pstm.setString(1, userId);

            ResultSet rs = pstm.executeQuery();

//         public User(int userId, String username, String password, String fullName,
//            String role, boolean isActive, String email, String phone) {
            if (rs.next()) {
                String userName = rs.getString("userName");
                String email = rs.getString("email");
                boolean isActive = rs.getString("is_active").equals("1");

                User user = new User();
                user.setUserId(Integer.parseInt(userId));
                user.setUsername(userName);
                user.setEmail(email);
                user.setActive(isActive);
                return user;
            }
        } catch (SQLException e) {
            System.out.println(e.toString());
        }

        return null;
    }

    public static int createUser(Connection conn, String userName, String password, String email) {
        String sql = "INSERT INTO Users (username, password, email, role) VALUES (?, ?, ?, ?) "
                + "SELECT SCOPE_IDENTITY() AS NewUserID;";
        try {
            PreparedStatement pstm = conn.prepareStatement(sql);

            // --- BĂM MẬT KHẨU TRƯỚC KHI LƯU ---
            String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt(12)); // (12 là độ mạnh, có thể 10-12)

            pstm.setString(1, userName);
            pstm.setString(2, hashedPassword); // <--- LƯU MẬT KHẨU ĐÃ BĂM
            pstm.setString(3, email);
            pstm.setString(4, "user");

            ResultSet rs = pstm.executeQuery();
            if (rs.next()) {
                return rs.getInt("NewUserID");
            }
        } catch (SQLException e) {
            System.out.println(e.toString());
        }

        return -1;
    }

    public static List<User> findAllUsers(Connection conn) {
        String sql = "select userId, userName, email, is_active from Users"
                + " where Users.role = ? ";

        List<User> users = new ArrayList<>();
        try {
            PreparedStatement pstm = conn.prepareStatement(sql);
            pstm.setString(1, "user");
            ResultSet rs = pstm.executeQuery();
            while (rs.next()) {
                int userId = rs.getInt("userId");
                String userName = rs.getString("userName");
                String email = rs.getString("email");
                String isActive = rs.getString("is_active");

                User u = new User();
                u.setUserId(userId);
                u.setUsername(userName);
                u.setEmail(email);
                if (isActive.equals("1")) {
                    u.setActive(true);
                } else {
                    u.setActive(false);
                }
                users.add(u);
            }
        } catch (SQLException e) {
            System.out.println(e.toString());
        }

        return users;
    }

    public static boolean activeUser(Connection conn, String id, boolean isActive) {
        String sql = "update users set is_active = ? where UserID = ?;";
        try {
            PreparedStatement pstm = conn.prepareStatement(sql);
            pstm.setBoolean(1, !isActive);
            pstm.setString(2, id);
            int affectedRows = pstm.executeUpdate();
            return affectedRows != 0;
        } catch (SQLException e) {
            System.out.println(e.toString());
            return false;
        }
    }

}
