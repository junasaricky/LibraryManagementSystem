package com.junasa.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.junasa.DAO.User_Dao;
import com.junasa.bean.User;
import com.junasa.utils.EmailSender;


@WebServlet("/ChangePasswordServlet")
public class ChangePasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        int userId = (int) session.getAttribute("user_id");
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String sourcePage = request.getParameter("source");

        User_Dao dao = new User_Dao();
        boolean isMatch = dao.checkUserPassword(userId, currentPassword);

        if (isMatch) {
            if (currentPassword.equals(newPassword)) {
                System.out.println("No changes detected. Passwords are the same.");
                response.sendRedirect(sourcePage + "?status=noChanges");
                return;
            }

            boolean updated = dao.updateUserPassword(userId, newPassword);
            if (updated) {
            	// Fetch user information for email notification
                User user = dao.getUserById(userId);  
                String userEmail = user.getEmail();  
                String userFirstName = user.getFname(); 
                
                String subject = "Password Successfully Updated";
                String message = "Hi " + userFirstName + ",\n\nYour password has been successfully updated. " +
                                 "If you didn't request this change, please contact support immediately.\n\n" +
                                 "Best regards,\nThe LMS Team";

                // Assuming you have an EmailSender class to handle sending the email
                EmailSender.sendEmail(userEmail, subject, message);

                response.sendRedirect("login.jsp?status=passwordChanged");
            } else {
            	System.out.println("Wrong current password.");
                response.sendRedirect(sourcePage + "?error=passwordUpdateFailed");
            }
        } else {
            System.out.println("Wrong current password.");
            response.sendRedirect(sourcePage + "?error=wrongCurrentPassword");
        }
    }
}

