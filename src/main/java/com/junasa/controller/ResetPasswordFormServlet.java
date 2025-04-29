package com.junasa.controller;

import com.junasa.DAO.User_Dao;
import com.junasa.bean.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/ResetPasswordFormServlet")
public class ResetPasswordFormServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String token = request.getParameter("resetToken");
        User_Dao dao = new User_Dao();
        User user = dao.getUserByResetToken(token);

        if (user != null) {
            request.setAttribute("user", user);
            request.getRequestDispatcher("reset-password.jsp").forward(request, response);
        } else {
            response.sendRedirect("forgot-password.jsp?error=invalidToken");
        }
    }
}
