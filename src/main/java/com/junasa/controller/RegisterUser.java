package com.junasa.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.junasa.DAO.User_Dao;
import com.junasa.bean.User;


@WebServlet("/RegisterUser")
public class RegisterUser extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        String fname = request.getParameter("fname");
        String lname = request.getParameter("lname");
        String email = request.getParameter("email");
        String cnumber = request.getParameter("cnumber");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        User user = new User(fname, lname, email, cnumber, username, password, "Borrower"); // Default role is Borrower
        User_Dao dao = new User_Dao();

        if (dao.isUsernameOrEmailTaken(username, email)) {
        	System.out.println("Email/username already exist!");
            response.sendRedirect("registration.jsp?status=taken");
        } else {
            if (dao.registerUser(user)) {
            	System.out.println("Registration Successful!");
                response.sendRedirect("login.jsp?status=registered");
            } else {
            	System.out.println("Registration Failed!");
                response.sendRedirect("registration.jsp?status=failed");
            }
        }
    }
}