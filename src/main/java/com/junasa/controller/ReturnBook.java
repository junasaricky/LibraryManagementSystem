package com.junasa.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.junasa.DAO.User_Dao;
import com.junasa.bean.User;


@WebServlet("/ReturnBook")
public class ReturnBook extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int id = Integer.parseInt(request.getParameter("borrow_id"));
		
		User status = new User(id);
		User_Dao dao = new User_Dao();
		if(dao.getReturnBook(status)) {
			System.out.println("Updated Successfully!");
        	response.sendRedirect("BorrowerStatus?status=updated"); 
		} else {
			System.out.println("Failed!");
            response.sendRedirect("BorrowerStatus?status=failed");
		}
	}
}
