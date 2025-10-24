/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.CatLib.Filter;

import com.CatLib.DAO.UserDAO;
import com.CatLib.Model.User;
import com.CatLib.Ultis.MyUtils;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;


@WebFilter(filterName = "cookieFilter", urlPatterns = {"/*"})
public class CookieFilter implements Filter {

    public CookieFilter() {
    }

    @Override
    public void init(FilterConfig fConfig) throws ServletException {

    }

    @Override
    public void destroy() {

    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpSession session = req.getSession();

        User userInSession = MyUtils.getLoginedUser(session);
        if (userInSession != null) {
            session.setAttribute("COOKIE_CHECKED", "CHECKED");
            chain.doFilter(request, response);
            return;
        }

        // Connection đã được tạo trong JDBCFilter.
        Connection conn = MyUtils.getStoredConnection(request);

        // Cờ (flag) để kiểm tra Cookie.
        String checked = (String) session.getAttribute("COOKIE_CHECKED");
        if (checked == null && conn != null) {
            String userName = MyUtils.getUserNameInCookie(req);
            User user = UserDAO.findUser(conn, userName);
            MyUtils.storeLoginedUser(session, user);
            // Đánh dấu đã kiểm tra Cookie.
            session.setAttribute("COOKIE_CHECKED", "CHECKED");
        }

        chain.doFilter(request, response);
    }

}
