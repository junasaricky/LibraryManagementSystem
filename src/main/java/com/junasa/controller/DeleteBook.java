package com.junasa.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.junasa.DAO.User_Dao;

@WebServlet("/DeleteBook")
public class DeleteBook extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int bookId = Integer.parseInt(request.getParameter("id"));
        User_Dao dao = new User_Dao();

        boolean isDeleted = dao.deleteBookById(bookId);
        if (isDeleted) {
        	System.out.println("Deleted Successfully!");
        	response.sendRedirect("ViewBooks?status=deleted"); // redirect to book list page
        } else {
        	System.out.println("Failed!");
            response.getWriter().println("Failed to delete the book.");
            response.sendRedirect("ViewBooks?status=failed");
        }
    }
}
