package com.junasa.controller;

import com.junasa.DAO.User_Dao;
import com.junasa.bean.User;
import com.junasa.utils.EmailSender;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/ResetPasswordServlet")
public class ResetPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int userId = Integer.parseInt(request.getParameter("userId"));
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (!newPassword.equals(confirmPassword)) {
            response.sendRedirect("reset-password.jsp?error=notMatching");
            return;
        }

        User_Dao dao = new User_Dao();
        boolean updated = dao.updateUserPassword(userId, newPassword);

        if (updated) {
            dao.clearResetToken(userId); // to clear reset token after use
            // Get user's email (fetch it using the userId)
            User user = dao.getUserById(userId);
            String userEmail = user.getEmail();
            String subject = "Your password has been successfully changed";
            String content = "Hi " + user.getFname() + ",\n\n"
                    + "This is a confirmation that your password for LMS has been successfully changed.\n\n"
                    + "If you did not make this change, please reset your password or contact support immediately.\n\n"
                    + "Best regards,\nThe LMS Team";

            // Send confirmation email
            try {
            	EmailSender.sendEmail(userEmail, subject, content); 
            } catch (Exception e) {
                e.printStackTrace();
            }
            response.sendRedirect("login.jsp?status=resetSuccess");
        } else {
            response.sendRedirect("reset-password.jsp?error=resetFailed");
        }
    }
}
