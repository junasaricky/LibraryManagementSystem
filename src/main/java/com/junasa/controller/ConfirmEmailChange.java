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


@WebServlet("/ConfirmEmailChange")
public class ConfirmEmailChange extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String token = request.getParameter("token");

        if (token == null || token.isEmpty()) {
            response.sendRedirect("login.jsp?error=invalidToken");
            return;
        }

        User_Dao dao = new User_Dao();
        User user = dao.getUserByToken(token);

        if (user == null) {
            response.sendRedirect("login.jsp?error=tokenExpiredOrInvalid");
            return;
        }

        // Session check
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user_id") == null) {
            response.sendRedirect("login.jsp?token=" + token);
            return;
        }

        Object sessionUserIdObj = session.getAttribute("user_id");
        int loggedInUserId;

        try {
            loggedInUserId = (Integer) sessionUserIdObj;
        } catch (Exception e) {
            System.out.println("Invalid session user ID.");
            response.sendRedirect("Logout?error=sessionError");
            return;
        }

        // Check if token user matches the logged-in user
        if (loggedInUserId != user.getId()) {
            response.sendRedirect("login.jsp?error=unauthorizedAccess");
            return;
        }

        // Get pending email
        String newEmail = dao.getPendingEmail(user.getId());

        if (dao.confirmEmailChange(user.getId())) {
            if (newEmail != null && !newEmail.isEmpty()) {
                boolean emailUpdated = dao.updateUserEmail(user.getId(), newEmail);
                if (emailUpdated) {
                    String subject = "Email Successfully Changed";
                    String message = "Hi " + user.getFname() + ",\n\nYour email has been successfully updated.\n\nBest regards,\nThe LMS Team";
                    EmailSender.sendEmail(newEmail, subject, message);

                    // Update session
                    session.setAttribute("email", newEmail);
                } else {
                    redirectByRole(session, response, "?status=emailUpdateFailed");
                    return;
                }
            }

            // Dynamic redirect after successful confirmation
            redirectByRole(session, response, "?status=emailConfirmed");

        } else {
            System.out.println("Email confirmation failed.");
            redirectByRole(session, response, "?status=confirmationFailed");
        }
    }

    // Helper method for role-based redirection
    private void redirectByRole(HttpSession session, HttpServletResponse response, String statusParam)
            throws IOException {
        String role = (String) session.getAttribute("role");
        if ("Admin".equalsIgnoreCase(role)) {
            response.sendRedirect("AdminHome" + statusParam);
        } else if ("Borrower".equalsIgnoreCase(role)) {
            response.sendRedirect("BorrowerHome" + statusParam);
        } else {
            response.sendRedirect("login.jsp?error=unknownRole");
        }
    }
}
