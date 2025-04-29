package com.junasa.bean;

public class Book {
    private int id;
    private String title;
    private String author;
    private String publisher;
    private String image;
    private int totalQuantity;
    private int availableQuantity;
    private String genre;

    public String getGenre() {
		return genre;
	}

	public void setGenre(String genre) {
		this.genre = genre;
	}

	public Book() {
        // Default constructor
    }

    public Book(int id, String title, String author, String publisher, String image, int totalQuantity, int availableQuantity) {
        this.id = id;
        this.title = title;
        this.author = author;
        this.publisher = publisher;
        this.image = image;
        this.totalQuantity = totalQuantity;
        this.availableQuantity = availableQuantity;
    }
    
    public Book(String title, String author, String publisher, int id) {
        this.title = title;
        this.author = author;
        this.publisher = publisher;
        this.id = id;
    }
    
    public Book(String title, String author, String publisher, int totalQuantity, String image, String genre) {
        this.title = title;
        this.author = author;
        this.publisher = publisher;
        this.totalQuantity = totalQuantity;
        this.availableQuantity = totalQuantity; // auto-set!
        this.image = image;
        this.genre = genre;
    }
    
    public Book(int id) {
    	this.id = id;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getPublisher() {
        return publisher;
    }

    public void setPublisher(String publisher) {
        this.publisher = publisher;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public int getTotalQuantity() {
        return totalQuantity;
    }

    public void setTotalQuantity(int totalQuantity) {
        this.totalQuantity = totalQuantity;
    }

    public int getAvailableQuantity() {
        return availableQuantity;
    }

    public void setAvailableQuantity(int availableQuantity) {
        this.availableQuantity = availableQuantity;
    }
}