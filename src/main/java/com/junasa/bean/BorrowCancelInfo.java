package com.junasa.bean;

public class BorrowCancelInfo {
    private String email;
    private String fname;
    private String bookTitle;

    public BorrowCancelInfo(String email, String fname, String bookTitle) {
        this.email = email;
        this.fname = fname;
        this.bookTitle = bookTitle;
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
}