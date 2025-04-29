package com.junasa.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.junasa.DAO.User_Dao;
import com.junasa.bean.Book;
import com.junasa.bean.User;
import com.junasa.utils.EmailSender;

@WebServlet("/ConfirmBorrowServlet")
public class ConfirmBorrowServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int borrowId = Integer.parseInt(request.getParameter("borrow_id"));
        int bookId = Integer.parseInt(request.getParameter("book_id"));

        User_Dao dao = new User_Dao();

        // 1. Update status to "Borrowed"
        boolean updated = dao.updateBorrowStatus(borrowId, "Borrowed");

        if (updated) {
            // 2. Decrease available quantity
            dao.decreaseAvailableQuantity(bookId);

            // 3. Get user info (for email)
            User user = dao.getUserByBorrowId(borrowId);
            Book book = dao.getBookById(bookId);

            String userEmail = user.getEmail();
            String userFirstName = user.getFname();
            String bookTitle = book.getTitle();

            // 4. Send email
            String subject = "Book Borrow Confirmed!";
            String message = "Hi " + userFirstName + ",\n\n" +
                             "Good news! Your request to borrow \"" + bookTitle + "\" has been confirmed.\n" +
                             "Please visit the library to collect your book.\n\n" +
                             "Happy reading!\nThe LMS Team";

            EmailSender.sendEmail(userEmail, subject, message);

            System.out.println("Borrow confirmed. Email sent.");
            response.sendRedirect("BorrowerStatus?status=confirm_success");
        } else {
            System.out.println("Failed to confirm borrow.");
            response.sendRedirect("BorrowerStatus?status=confirm_failed");
        }
    }
}
