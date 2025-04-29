package com.junasa.bean;

public class BorrowReminderInfo {
    private String email;
    private String fname;
    private String bookTitle;
    private String returnDate;  // This is now the calculated due date

    public BorrowReminderInfo(String email, String fname, String bookTitle, String returnDate) {
        this.email = email;
        this.fname = fname;
        this.bookTitle = bookTitle;
        this.returnDate = returnDate;
    }

    public String getEmail() {
        return email;
    }

    public String getFname() {
        return fname;
    }

    public String getBookTitle() {
        return bookTitle;
    }

    public String getReturnDate() {
        return returnDate;
    }
}
