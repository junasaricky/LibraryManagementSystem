package com.junasa.controller;

import java.io.IOException;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.junasa.DAO.User_Dao;
import com.junasa.bean.Book;
import com.junasa.bean.Status;
import com.junasa.bean.User;
import com.junasa.utils.EmailSender;


@WebServlet("/BorrowServlet")
public class BorrowServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int bookId = Integer.parseInt(request.getParameter("book_id"));
        int userId = Integer.parseInt(request.getParameter("user_id"));
        String borrowDate = request.getParameter("borrow_date");

        User_Dao statusDao = new User_Dao();

        // Check if there's already a pending request
        if (statusDao.hasPendingBorrow(userId, bookId)) {
            System.out.println("Already has a pending request for this book!");
            response.sendRedirect("BorrowerViewBooks?status=already_pending");
            return;
        }

        // Proceed with borrowing
        Status borrow = new Status();
        borrow.setBook_id(bookId);
        borrow.setUser_id(userId);
        borrow.setBorrow_date(borrowDate);
        borrow.setStatus("Pending"); // Assuming status starts as "Pending"
        
        if (statusDao.borrowBook(borrow)) {
            User user = statusDao.getUserById(userId);
            String userEmail = user.getEmail();
            String userFirstName = user.getFname();

            Book book = statusDao.getBookById(bookId); 
            String bookTitle = book.getTitle();

            String subject = "Book Borrow Request Confirmation";
            String message = "Hi " + userFirstName + ",\n\n" +
                    "Thanks for requesting the book \"" + bookTitle + "\".\n" +
                    "Please pick it up from the library within 3 days to avoid cancellation.\n\n" +
                    "Best regards,\nThe LMS Team";

            EmailSender.sendEmail(userEmail, subject, message);

            System.out.println("Borrow request submitted. Email sent.");
            response.sendRedirect("BorrowerViewBooks?status=success");
        } else {
            System.out.println("Borrow failed!");
            response.sendRedirect("BorrowerViewBooks?status=failed");
        }
    }
}