package com.junasa.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/BorrowerRecordsProfile")
public class BorrowerRecordsProfile extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// session-based authentication or access control 
        HttpSession session = request.getSession(false); // false to prevent new session
        if (session == null || !"Borrower".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
            return;
        }
        request.getRequestDispatcher("borrower-records-profile.jsp").forward(request, response);
    }
}
