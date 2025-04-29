package com.junasa.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.junasa.DAO.User_Dao;
import com.junasa.bean.User;
import com.junasa.utils.EmailSender;


@WebServlet("/ForgotPasswordServlet")
public class ForgotPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        User_Dao dao = new User_Dao();
        User user = dao.getUserByEmail(email);

        if (user != null) {
            // Generate password reset token
            String resetToken = generateResetToken(); // Assuming this method generates a secure token
            Timestamp expiry = new Timestamp(System.currentTimeMillis() + 15 * 60 * 1000); // 15 mins

            // Save token and expiry to DB
            boolean isTokenSaved = dao.setPasswordResetToken(user.getId(), resetToken, expiry);

            if (isTokenSaved) {
                // Send reset link to the user via email
            	String resetLink = "http://localhost:8080/Library/ResetPasswordFormServlet?resetToken=" + resetToken;
                sendResetEmail(user.getEmail(), resetLink); // Assuming sendResetEmail sends the email
                response.sendRedirect("forgot-password.jsp?status=resetLinkSent");
            } else {
                response.sendRedirect("forgot-password.jsp?error=tokenGenerationFailed");
            }
        } else {
            response.sendRedirect("forgot-password.jsp?error=userNotFound");
        }
    }

    // Example of a method to generate reset token (use a secure method for production)
    private String generateResetToken() {
        return UUID.randomUUID().toString();  // This generates a simple random token
    }

    // Example method to send reset email (make sure to use a real email sending logic)
    private void sendResetEmail(String email, String resetLink) {
        // Logic to send email
        String subject = "Password Reset Request";
        String message = "Click the following link to reset your password: " + resetLink;
        EmailSender.sendEmail(email, subject, message);
    }
}