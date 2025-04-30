package com.junasa.controller;

import java.sql.Timestamp;
import java.io.IOException;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.junasa.DAO.User_Dao;
import com.junasa.bean.User;
import com.junasa.utils.EmailSender;


@WebServlet("/ChangeEmailServlet")
public class ChangeEmailServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
   
    // Handles admin info update
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("userId"));
        String newEmail = request.getParameter("newEmail");
        String sourcePage = request.getParameter("source");

        User_Dao dao = new User_Dao();
        User currentUser = dao.getUserById(id);

        // Check if the new email already exists
        if (dao.isEmailExists(newEmail)) {
            // If the email already exists, show an error message
            response.sendRedirect(sourcePage + "?error=emailExists");
            return; // Stop further execution if email exists
        }

        // Check if email is different from the current email
        if (!newEmail.equals(currentUser.getEmail())) {

            // Validate email format
            if (!newEmail.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.(com|net|org|edu)$")) {
                response.sendRedirect(sourcePage + "?error=invalidEmail");
                return;
            }

            // Generate token + expiry
            String token = UUID.randomUUID().toString();
            Timestamp expiry = new Timestamp(System.currentTimeMillis() + 15 * 60 * 1000); // 15 mins

            // Save token, expiry, and pending email
            boolean tokenUpdated = dao.updateEmailChangeToken(id, token, expiry);
            boolean pendingEmailUpdated = dao.setPendingEmail(id, newEmail); // ← this is a new DAO method

            if (tokenUpdated && pendingEmailUpdated) {
                // Send confirmation email
                String confirmLink = "http://localhost:8080/LibraryManagementSystem/ConfirmEmailChange?token=" + token;

                String subject = "Confirm Your Email Change";
                String message = "Hello " + currentUser.getFname() + ",\n\n"
                        + "We received a request to change your email address.\n"
                        + "Please click the link below to confirm your new email address:\n\n"
                        + confirmLink + "\n\n"
                        + "If you did not request this change, please ignore this email.\n\n"
                        + "Best regards,\nThe LMS Team";

                EmailSender.sendEmail(currentUser.getEmail(), subject, message);
                System.out.println("Current user's first name: " + currentUser.getFname());
                System.out.println("Email change request sent to " + newEmail);

                // Redirect with info
                response.sendRedirect(sourcePage + "?status=confirmEmailSent");
            } else {
                response.sendRedirect("Logout?status=failed");
            }

        } else {
            System.out.println("No changes detected.");
            response.sendRedirect(sourcePage);
        }
    }
}