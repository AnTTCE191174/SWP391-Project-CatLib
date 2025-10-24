/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.CatLib.Conn;

import java.sql.Connection;
import java.sql.SQLException;


public class ConnectionUtils {

    public static Connection getConnection()
            throws ClassNotFoundException, SQLException {
         return SQLConn.getSQLServerConnection_SQLJDBC();
    }

    public static void closeQuietly(Connection conn) {
        try {
            conn.close();
        } catch (SQLException e) {
        }
    }

    public static void rollbackQuietly(Connection conn) {
        try {
            conn.rollback();
        } catch (SQLException e) {
        }
    }
}
