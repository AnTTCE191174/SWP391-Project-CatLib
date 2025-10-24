/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.CatLib.Filter;

import com.CatLib.Model.User;
import com.CatLib.Ultis.MyUtils;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;


@WebFilter(urlPatterns = {"/user/*"})
public class UserFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        User loginedUser = MyUtils.getLoginedUser(req.getSession());

        if (loginedUser == null || !loginedUser.isActive()) {
            // Redirect (Chuyển hướng) tới trang login.
            HttpSession session = req.getSession();
            session.setAttribute("message", "The account has been disabled or not existed");
            resp.sendRedirect(req.getContextPath() + "/login");
        } else if (loginedUser.getRole().equals("admin")) {
            resp.sendRedirect(req.getContextPath() + "/permission");
        } else {
            chain.doFilter(req, resp);
        }
    }
}
