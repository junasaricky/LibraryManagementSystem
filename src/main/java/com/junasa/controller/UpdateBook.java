package com.junasa.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.junasa.DAO.User_Dao;
import com.junasa.bean.Book;


@WebServlet("/UpdateBook")
public class UpdateBook extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	// Show update form
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
    	String title = request.getParameter("title");
    	String author = request.getParameter("author");
    	String publisher = request.getParameter("publisher");
    	int id = Integer.parseInt(request.getParameter("bookId"));
    	User_Dao dao = new User_Dao();
    	//RequestDispatcher dispatcher = null;

    	Book currentBook = dao.getBookById(id);
    	
    	// Check if any of the fields have changed
        boolean hasChanges = !title.equals(currentBook.getTitle()) || 
                             !author.equals(currentBook.getAuthor()) || 
                             !publisher.equals(currentBook.getPublisher());
    	
        if (hasChanges) {
        	Book book = new Book(title, author, publisher, id);
        
	    	if (dao.updateBook(book)) {
	            System.out.println("Updated Successfully!");
	            response.sendRedirect("ViewBooks?status=success");  // Redirect to ViewBooks servlet
	        } else {
	            System.out.println("Failed!");
	            System.out.println("UpdateBook servlet called with ID: " + id);
	            response.sendRedirect("ViewBooks?status=failed");  // Redirect to ViewBooks servlet
	        }
    	} else {
    		System.out.println("No Changes!");
    		response.sendRedirect("ViewBooks");
    	}
    }
}
