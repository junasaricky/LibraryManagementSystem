package com.junasa.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.junasa.DAO.User_Dao;
import com.junasa.bean.User;


@WebServlet("/Login")
public class Login extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String token = request.getParameter("token");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        User_Dao daoUser = new User_Dao();
        User userInfo = new User(username);

        userInfo.setUsername(username);
        userInfo.setPassword(password);
        userInfo.setRole(role);

        RequestDispatcher dispatcher = null;
        boolean loginSuccess = daoUser.loginUser(userInfo);

        if (loginSuccess) {
            System.out.println(role + " Login successful!");
            System.out.println("User ID: " + userInfo.getId());

            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            session.setAttribute("role", role);
            session.setAttribute("fname", userInfo.getFname());
            session.setAttribute("lname", userInfo.getLname());
            session.setAttribute("user_id", userInfo.getId());
            session.setAttribute("password", userInfo.getPassword());
            session.setAttribute("email", userInfo.getEmail());
            session.setAttribute("status", "success");

            // Unified redirection if there's a token
            if (token != null && token.matches("^[a-zA-Z0-9\\-]+$")) {
                response.sendRedirect("ConfirmEmailChange?token=" + token);
                return;
            }

            // Normal redirection if no token
            if ("Admin".equalsIgnoreCase(role)) {
                response.sendRedirect("AdminHome");
            } else if ("Borrower".equalsIgnoreCase(role)) {
                response.sendRedirect("BorrowerHome");
            }
        } else {
            System.out.println(role + " Login failed!");
            request.setAttribute("status", "failed");
            dispatcher = request.getRequestDispatcher("login.jsp");
            dispatcher.forward(request, response);
        }
    }
}
