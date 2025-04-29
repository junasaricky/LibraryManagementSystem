package com.junasa.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.junasa.DAO.User_Dao;
import com.junasa.bean.User;


@WebServlet("/UpdateBorrowerInfo")
public class UpdateBorrowerInfo extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	// Handles borrower info update
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("userId"));
        String fname = request.getParameter("fname");
        String lname = request.getParameter("lname");
        String number = request.getParameter("number");

        User_Dao dao = new User_Dao();
        User currentUser = dao.getUserById(id);

        // Check if anything changed
        boolean hasChanges = !fname.equals(currentUser.getFname()) ||
                             !lname.equals(currentUser.getLname()) ||
                             !number.equals(currentUser.getCnumber());

        if (hasChanges) {
        	User user = new User(fname, lname, number, id, true);

            // Validate phone number format BEFORE update
        	if (!number.matches("^\\+63[0-9]{10}$")) {
                response.sendRedirect("BorrowerRecordsProfile?error=invalidPhoneNumber");
                return;
            }
            if (dao.updateUserInfo(user)) {
                System.out.println("Borrower info updated successfully.");
                // Redirect to profile page with success status
                response.sendRedirect("BorrowerRecordsProfile?status=updated");
            } else {
                System.out.println("Update failed.");
                response.sendRedirect("BorrowerRecordsProfile?status=failed");
            }
        } else {
            System.out.println("No changes detected.");
            response.sendRedirect("BorrowerRecordsProfile");
        }
    }

}
