package com.junasa.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.junasa.DAO.User_Dao;
import com.junasa.bean.Book;


@WebServlet("/AddBook")
public class AddBook extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String title = request.getParameter("title");
		String author = request.getParameter("author");
		String publisher = request.getParameter("publisher");
		int quantity = Integer.parseInt(request.getParameter("quantity"));
		String image = request.getParameter("image");
		String genre = request.getParameter("genre");
		
		Book book = new Book(title, author, publisher, quantity, image, genre);
		User_Dao insertBook = new User_Dao();
		if(insertBook.insertBook(book)) {
			System.out.println("Added Successfully!");
			response.sendRedirect("ViewBooks?status=success");  // Redirect to ViewBooks servlet
		} else {
			System.out.println("Failed!");
			response.sendRedirect("ViewBooks?status=failed");  // Redirect to ViewBooks servlet
		}
	}
}
