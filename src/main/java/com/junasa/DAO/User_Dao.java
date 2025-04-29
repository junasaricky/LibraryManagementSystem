package com.junasa.DAO;

import java.security.Timestamp;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import com.junasa.bean.Book;
import com.junasa.bean.BorrowCancelInfo;
import com.junasa.bean.BorrowReminderInfo;
import com.junasa.bean.Status;
import com.junasa.bean.User;
import com.junasa.dbconnection.DBConnection;

public class User_Dao {

	// For User Login
	public boolean loginUser(User user) {
		boolean result = false;
		String sql = "SELECT * FROM user WHERE username=? AND password=? AND role=?";
		try (Connection con = DBConnection.getConnection();
			 PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setString(1, user.getUsername());
			ps.setString(2, user.getPassword());
			ps.setString(3, user.getRole());
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				result = true;
				// Fetch names from DB and set them in the user object
				user.setFname(rs.getString("fname"));
				user.setLname(rs.getString("lname"));
				user.setId(rs.getInt("user_id"));
				user.setEmail(rs.getString("email"));
			}
			//System.out.println("Connected to database: true");
			//System.out.println("Query: " + sql);
			//System.out.println("Params: " + user.getUsername() + ", " + user.getPassword() + ", " + user.getRole());
		} catch (Exception e) {
			System.out.println("Login error: " + e.getMessage());
			e.printStackTrace();
		}
		return result;
	}

	// For Retrieve Book Info
	public ResultSet getBookData() throws Exception {
		Connection con = DBConnection.getConnection();
		Statement st = con.createStatement();
		return st.executeQuery("SELECT * FROM books ORDER BY book_id DESC");
	}

	// Count Total Books
	public int getTotalBooks() {
		int count = 0;
		String sql = "SELECT COUNT(*) FROM books";
		try (Connection con = DBConnection.getConnection();
			 PreparedStatement ps = con.prepareStatement(sql);
			 ResultSet rs = ps.executeQuery()) {

			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}

	// Count Borrowed Books
	public int getBorrowedBooks() {
		int count = 0;
		String sql = "SELECT COUNT(*) FROM borrowed_books WHERE status = 'Borrowed'";
		try (Connection con = DBConnection.getConnection();
			 PreparedStatement ps = con.prepareStatement(sql);
			 ResultSet rs = ps.executeQuery()) {

			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}

	// Count Total Borrowers
	public int getTotalBorrowers() {
		int count = 0;
		String sql = "SELECT COUNT(*) FROM user WHERE role = 'Borrower'";
		try (Connection con = DBConnection.getConnection();
			 PreparedStatement ps = con.prepareStatement(sql);
			 ResultSet rs = ps.executeQuery()) {

			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}

	// Count Overdue Books
	public int getOverdueBooks() {
		int count = 0;
		String sql = "SELECT COUNT(*) FROM borrowed_books WHERE DATE(borrow_date, '+7 days') < DATE('now') AND status != 'Returned'";
		try (Connection con = DBConnection.getConnection();
			 PreparedStatement ps = con.prepareStatement(sql);
			 ResultSet rs = ps.executeQuery()) {

			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}

	// Update Book
	public boolean updateBook(Book book) {
		String sql = "UPDATE books SET title = ?, author = ?, publisher = ? WHERE book_id = ?";
		int rowCount = 0;
		try (Connection con = DBConnection.getConnection();
			 PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setString(1, book.getTitle());
			ps.setString(2, book.getAuthor());
			ps.setString(3, book.getPublisher());
			ps.setInt(4, book.getId());
			rowCount = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return rowCount > 0;
	}
	
	// Display book by id
	public Book getBookById(int id) {
		Book book = null;
	    String sql = "SELECT * FROM books WHERE book_id = ?";
	    
	    try (Connection con = DBConnection.getConnection();
	         PreparedStatement ps = con.prepareStatement(sql)) {

	        ps.setInt(1, id);
	        ResultSet rs = ps.executeQuery();

	        if (rs.next()) {
	            String title = rs.getString("title");
	            String author = rs.getString("author");
	            String publisher = rs.getString("publisher");

	            book = new Book(title, author, publisher, id);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return book;
	}
	
	// Delete book by id
	public boolean deleteBookById(int bookId) {
	    String sql = "DELETE FROM books WHERE book_id = ?";
	    try (Connection con = DBConnection.getConnection();
	         PreparedStatement ps = con.prepareStatement(sql)) {

	        ps.setInt(1, bookId);
	        int rowsAffected = ps.executeUpdate();
	        return rowsAffected > 0;

	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return false;
	}
	
	// Insert New Book
	public boolean insertBook(Book book) {
	    String sql = "INSERT INTO books (title, author, publisher, image, total_quantity, available_quantity, genre, date_added) " +
	                 "VALUES (?, ?, ?, ?, ?, ?, ?, DATE('now'))";
	    try (Connection con = DBConnection.getConnection();
	         PreparedStatement ps = con.prepareStatement(sql)) {

	        ps.setString(1, book.getTitle());
	        ps.setString(2, book.getAuthor());
	        ps.setString(3, book.getPublisher());
	        ps.setString(4, book.getImage());
	        ps.setInt(5, book.getTotalQuantity());
	        ps.setInt(6, book.getAvailableQuantity());
	        ps.setString(7, book.getGenre());

	        int rows = ps.executeUpdate();
	        return rows > 0;

	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return false;
	}
	
	// Get books ordered by recently added
	public ResultSet getRecentlyAddedBooks() throws Exception {
	    Connection con = DBConnection.getConnection();
	    Statement st = con.createStatement();
	    return st.executeQuery("SELECT * FROM books ORDER BY date_added DESC LIMIT 5");
	}
	
	// Get all borrowed books with borrower info, return date, and computed due date
	public ResultSet getBorrowedBooksWithUsers() {
	    String sql = "SELECT bb.borrow_id AS borrow_id, bb.book_id AS book_id, u.fname, u.lname, b.title, b.author, bb.borrow_date, " +
	                 "DATE(bb.borrow_date, '+7 days') AS due_date, bb.return_date, bb.status " +
	                 "FROM borrowed_books bb " +
	                 "JOIN user u ON bb.user_id = u.user_id " +
	                 "JOIN books b ON bb.book_id = b.book_id " +
	                 "ORDER BY bb.borrow_date DESC";
	    try {
	        Connection con = DBConnection.getConnection();
	        PreparedStatement ps = con.prepareStatement(sql);
	        return ps.executeQuery();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return null;
	}

	// Return book
	public boolean getReturnBook(User user) {
	    String sqlUpdateBorrowed = "UPDATE borrowed_books SET status = 'Returned', return_date = DATE('now') WHERE borrow_id = ?";
	    String sqlUpdateBooks = "UPDATE books SET available_quantity = available_quantity + 1 WHERE book_id = (SELECT book_id FROM borrowed_books WHERE borrow_id = ?)";

	    try {
	        Connection con = DBConnection.getConnection();
	        con.setAutoCommit(false); // Start transaction

	        // Update borrowed_books
	        PreparedStatement ps = con.prepareStatement(sqlUpdateBorrowed);
	        ps.setInt(1, user.getId());
	        int rowsAffected = ps.executeUpdate();
	        ps.close();

	        // Only update books if the borrow status was updated
	        if (rowsAffected > 0) {
	            ps = con.prepareStatement(sqlUpdateBooks);
	            ps.setInt(1, user.getId());
	            ps.executeUpdate();
	            ps.close();

	            con.commit(); // Commit both updates
	            return true;
	        } else {
	            con.rollback();
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return false;
	}
	
	// Retrieve data for the currently logged-in admin
	public ResultSet getAdminData(String username) {
	    ResultSet rs = null;
	    try {
	        Connection con = DBConnection.getConnection(); // don't close!
	        String sql = "SELECT * FROM user WHERE username = ? AND role = 'Admin'";
	        PreparedStatement ps = con.prepareStatement(sql);
	        ps.setString(1, username);
	        rs = ps.executeQuery();
	    } catch (Exception e) {
	        System.out.println("Error fetching admin data: " + e.getMessage());
	        e.printStackTrace();
	    }
	    return rs;
	}
	
	// Retrieve data for the currently logged-in borrower
	public ResultSet getBorrowerData(String username) {
	    ResultSet rs = null;
	    try {
	        Connection con = DBConnection.getConnection(); // don't close!
	        String sql = "SELECT * FROM user WHERE username = ? AND role = 'Borrower'";
	        PreparedStatement ps = con.prepareStatement(sql);
	        ps.setString(1, username);
	        rs = ps.executeQuery();
	    } catch (Exception e) {
	        System.out.println("Error fetching admin data: " + e.getMessage());
	        e.printStackTrace();
	    }
	    return rs;
	}
	
	public ResultSet getAllBorrowers() {
	    ResultSet rs = null;
	    try {
	        Connection con = DBConnection.getConnection(); // don't close!
	        String sql = "SELECT * FROM user WHERE role = 'Borrower'";
	        PreparedStatement ps = con.prepareStatement(sql);
	        rs = ps.executeQuery();
	    } catch (Exception e) {
	        System.out.println("Error fetching borrower data: " + e.getMessage());
	        e.printStackTrace();
	    }
	    return rs;
	}
	
	// Update User Info
	public boolean updateUserInfo(User user) {
	    String sql = "UPDATE user SET fname = ?, lname = ?, cnumber = ? WHERE user_id = ?";
	    int rowCount = 0;
	    try (Connection con = DBConnection.getConnection();
	         PreparedStatement ps = con.prepareStatement(sql)) {

	        ps.setString(1, user.getFname());
	        ps.setString(2, user.getLname());
	        ps.setString(3, user.getCnumber());
	        ps.setInt(4, user.getId());  

	        rowCount = ps.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return rowCount > 0;
	}

	// Display user by id
	public User getUserById(int id) {
	    User user = null;
	    String sql = "SELECT * FROM user WHERE user_id = ?";
	    
	    try (Connection con = DBConnection.getConnection();
	         PreparedStatement ps = con.prepareStatement(sql)) {

	        ps.setInt(1, id);
	        ResultSet rs = ps.executeQuery();

	        if (rs.next()) {
	            String fname = rs.getString("fname");
	            String lname = rs.getString("lname");
	            String email = rs.getString("email");
	            String cnumber = rs.getString("cnumber");

	            user = new User(fname, lname, email, cnumber, id);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return user;
	}
	
	// Update Admin Info		
	public boolean updateEmail(User user) {		
	    String sql = "UPDATE user SET email = ? WHERE user_id = ?";		
	    int rowCount = 0;		
	    try (Connection con = DBConnection.getConnection();		
	         PreparedStatement ps = con.prepareStatement(sql)) {		
					
	        ps.setString(1, user.getEmail());		
	        ps.setInt(2, user.getId());  		
			
	        rowCount = ps.executeUpdate();		
	    } catch (Exception e) {		
	        e.printStackTrace();		
	    }		
	    return rowCount > 0;		
	}		

	
	// Update email change token and its expiry
	public boolean updateEmailChangeToken(int userId, String token, java.sql.Timestamp expiryTime) {
	    String sql = "UPDATE user SET email_change_token = ?, email_change_token_expiry = ? WHERE user_id = ?";
	    int rowCount = 0;
	    
	    try (Connection con = DBConnection.getConnection();
	         PreparedStatement ps = con.prepareStatement(sql)) {
	        
	        ps.setString(1, token);
	        ps.setTimestamp(2, expiryTime);
	        ps.setInt(3, userId);
	        
	        rowCount = ps.executeUpdate(); // Executes the update query
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    
	    return rowCount > 0; // Returns true if the update was successful
	}

	// Get user by email change token
	public User getUserByToken(String token) {
	    User user = null;
	    String sql = "SELECT * FROM user WHERE email_change_token = ? AND email_change_token_expiry > ?";
	    
	    try (Connection con = DBConnection.getConnection();
	         PreparedStatement ps = con.prepareStatement(sql)) {
	        
	        ps.setString(1, token);
	        ps.setTimestamp(2, new java.sql.Timestamp(System.currentTimeMillis())); // Ensure token is not expired
	        
	        ResultSet rs = ps.executeQuery();
	        
	        if (rs.next()) {
	            int id = rs.getInt("user_id");
	            String email = rs.getString("email");
	            String fname = rs.getString("fname");
	            
	            // Create and return user object
	            user = new User(email, id, fname);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return user;
	}

	public boolean setPendingEmail(int userId, String newEmail) {
	    String sql = "UPDATE user SET pending_email = ? WHERE user_id = ?";
	    try (Connection con = DBConnection.getConnection();
	         PreparedStatement ps = con.prepareStatement(sql)) {
	        ps.setString(1, newEmail);
	        ps.setInt(2, userId);
	        return ps.executeUpdate() > 0;
	    } catch (Exception e) {
	        e.printStackTrace();
	        return false;
	    }
	}
	
	// Confirm the email change by updating the email and clearing the token
	public boolean confirmEmailChange(int userId) {
	    String getPendingSql = "SELECT pending_email FROM user WHERE user_id = ?";
	    String updateSql = "UPDATE user SET email = ?, pending_email = NULL, email_change_token = NULL, email_change_token_expiry = NULL WHERE user_id = ?";
	    int result = 0;

	    try (Connection con = DBConnection.getConnection();
	         PreparedStatement ps1 = con.prepareStatement(getPendingSql)) {

	        ps1.setInt(1, userId);
	        ResultSet rs = ps1.executeQuery();

	        if (rs.next()) {
	            String pendingEmail = rs.getString("pending_email");
	            System.out.println("Pending email for user ID " + userId + ": " + pendingEmail);

	            if (pendingEmail != null && !pendingEmail.isEmpty()) {
	                try (PreparedStatement ps2 = con.prepareStatement(updateSql)) {
	                    ps2.setString(1, pendingEmail);
	                    ps2.setInt(2, userId);
	                    result = ps2.executeUpdate();
	                    System.out.println("Rows updated: " + result);
	                }
	            } else {
	                System.out.println("No pending email found.");
	            }
	        } else {
	            System.out.println("User not found with ID: " + userId);
	        }

	    } catch (Exception e) {
	        System.out.println("Exception in confirmEmailChange:");
	        e.printStackTrace();
	    }

	    return result > 0;
	}
	
	// Retrieves the pending email address for a user by their user ID.
	public String getPendingEmail(int userId) {
	    String sql = "SELECT pending_email FROM user WHERE user_id = ?";
	    String pendingEmail = null;

	    try (Connection con = DBConnection.getConnection();
	         PreparedStatement ps = con.prepareStatement(sql)) {

	        ps.setInt(1, userId);
	        try (ResultSet rs = ps.executeQuery()) {
	            if (rs.next()) {
	                pendingEmail = rs.getString("pending_email");
	            }
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return pendingEmail;
	}
	
	public boolean updateUserEmail(int userId, String newEmail) {
		String sql = "UPDATE user SET email = ?, pending_email = NULL, email_change_token = NULL, email_change_token_expiry = NULL WHERE user_id = ?";
	    try (Connection con = DBConnection.getConnection();
	         PreparedStatement ps = con.prepareStatement(sql)) {
	        ps.setString(1, newEmail);
	        ps.setInt(2, userId);
	        return ps.executeUpdate() > 0;
	    } catch (Exception e) {
	        e.printStackTrace();
	        return false;
	    }
	}
	
	public boolean isEmailExists(String email) {
	    String sql = "SELECT user_id FROM user WHERE email = ?";
	    try (Connection con = DBConnection.getConnection();
	         PreparedStatement stmt = con.prepareStatement(sql)) {
	        stmt.setString(1, email);
	        ResultSet rs = stmt.executeQuery();
	        return rs.next(); // If a record is found, email already exists
	    } catch (SQLException e) {
	        e.printStackTrace();
	        return false;
	    }
	}
	
	public boolean checkUserPassword(int userId, String currentPassword) {
	    String sql = "SELECT password FROM user WHERE user_id = ?";
	    try (Connection con = DBConnection.getConnection();
	         PreparedStatement ps = con.prepareStatement(sql)) {
	        ps.setInt(1, userId);
	        ResultSet rs = ps.executeQuery();
	        if (rs.next()) {
	            String dbPassword = rs.getString("password");
	            return dbPassword.equals(currentPassword); // Ideally, use hashing
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return false;
	}

	public boolean updateUserPassword(int userId, String newPassword) {
	    String sql = "UPDATE user SET password = ? WHERE user_id = ?";
	    try (Connection con = DBConnection.getConnection();
	         PreparedStatement ps = con.prepareStatement(sql)) {
	        ps.setString(1, newPassword);
	        ps.setInt(2, userId);
	        return ps.executeUpdate() > 0;
	    } catch (Exception e) {
	        e.printStackTrace();
	        return false;
	    }
	}

	public User getUserByEmail(String email) {
	    String sql = "SELECT * FROM user WHERE email = ?";
	    try (Connection con = DBConnection.getConnection();
	         PreparedStatement ps = con.prepareStatement(sql)) {

	        ps.setString(1, email);
	        ResultSet rs = ps.executeQuery();

	        if (rs.next()) {
	            User user = new User();
	            user.setId(rs.getInt("user_id"));
	            user.setFname(rs.getString("fname"));
	            user.setLname(rs.getString("lname"));
	            user.setEmail(rs.getString("email"));
	            return user;
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return null; // if not found
	}
	
	public boolean setPasswordResetToken(int userId, String token, java.sql.Timestamp expiry) {
	    String sql = "UPDATE user SET password_reset_token = ?, password_reset_token_expiry = ? WHERE user_id = ?";
	    
	    try (Connection con = DBConnection.getConnection();
	         PreparedStatement stmt = con.prepareStatement(sql)) {
	         
	        stmt.setString(1, token);
	        stmt.setTimestamp(2, expiry);
	        stmt.setInt(3, userId);
	        
	        int rowsUpdated = stmt.executeUpdate();
	        return rowsUpdated > 0;
	    } catch (SQLException e) {
	        e.printStackTrace();
	        return false;
	    }
	}
	
	public User getUserByResetToken(String token) {
	    String sql = "SELECT * FROM user WHERE password_reset_token = ?";
	    try (Connection con = DBConnection.getConnection();
	         PreparedStatement pstmt = con.prepareStatement(sql)) {

	        pstmt.setString(1, token);
	        ResultSet rs = pstmt.executeQuery();

	        if (rs.next()) {
	            User user = new User();
	            user.setId(rs.getInt("user_id"));
	            user.setEmail(rs.getString("email"));
	            user.setFname(rs.getString("fname"));
	            user.setPasswordResetToken(rs.getString("password_reset_token"));
	            user.setPasswordResetTokenExpiry(rs.getTimestamp("password_reset_token_expiry"));
	            return user;
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return null;
	}

	public void clearResetToken(int userId) {
	    String sql = "UPDATE user SET password_reset_token = NULL, password_reset_token_expiry = NULL WHERE user_id = ?";
	    try (Connection con = DBConnection.getConnection();
	         PreparedStatement pstmt = con.prepareStatement(sql)) {
	        pstmt.setInt(1, userId);
	        pstmt.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}
	
	public boolean registerUser(User user) {
	    Connection con = null;
	    PreparedStatement ps = null;
	    try {
	        con = DBConnection.getConnection();
	        String sql = "INSERT INTO user (fname, lname, email, cnumber, username, password, role) VALUES (?, ?, ?, ?, ?, ?, ?)";
	        ps = con.prepareStatement(sql);
	        ps.setString(1, user.getFname());
	        ps.setString(2, user.getLname());
	        ps.setString(3, user.getEmail());
	        ps.setString(4, user.getCnumber());
	        ps.setString(5, user.getUsername());
	        ps.setString(6, user.getPassword());
	        ps.setString(7, user.getRole());

	        int rows = ps.executeUpdate();
	        return rows > 0;
	    } catch (Exception e) {
	        System.out.println("Error in registerUser(): " + e.getMessage());
	        e.printStackTrace();
	    } finally {
	        try {
	            if (ps != null) ps.close();
	            if (con != null) con.close(); // IMPORTANT
	        } catch (Exception ex) {
	            ex.printStackTrace();
	        }
	    }
	    return false;
	}
	
	public boolean isUsernameOrEmailTaken(String username, String email) {
	    boolean isTaken = false;
	    Connection con = null;
	    PreparedStatement ps = null;
	    ResultSet rs = null;

	    try {
	        con = DBConnection.getConnection();
	        String sql = "SELECT * FROM user WHERE username = ? OR email = ?";
	        ps = con.prepareStatement(sql);
	        ps.setString(1, username);
	        ps.setString(2, email);
	        rs = ps.executeQuery();
	        if (rs.next()) {
	            isTaken = true;
	        }
	    } catch (Exception e) {
	        System.out.println("Error checking uniqueness: " + e.getMessage());
	        e.printStackTrace();
	    } finally {
	        try {
	            if (rs != null) rs.close();
	            if (ps != null) ps.close();
	            if (con != null) con.close();
	        } catch (Exception ex) {
	            ex.printStackTrace();
	        }
	    }
	    return isTaken;
	}

	public int countBorrowedBooks(int userId) {
	    int count = 0;
	    String sql = "SELECT COUNT(*) FROM borrowed_books WHERE user_id = ? AND status = 'Borrowed'";
	    try (Connection con = DBConnection.getConnection();
	         PreparedStatement ps = con.prepareStatement(sql)) {
	        ps.setInt(1, userId);  // Use the user_id to filter for the specific borrower
	        try (ResultSet rs = ps.executeQuery()) {
	            if (rs.next()) {
	                count = rs.getInt(1);
	            }
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return count;
	}

	public int countOverdueBooks(int userId) {
	    int count = 0;
	    String sql = "SELECT COUNT(*) FROM borrowed_books WHERE user_id = ? AND DATE(borrow_date, '+7 days') < DATE('now') AND status != 'Returned'";
	    try (Connection con = DBConnection.getConnection();
	         PreparedStatement ps = con.prepareStatement(sql)) {
	        ps.setInt(1, userId);  // Use the user_id to filter for the specific borrower
	        try (ResultSet rs = ps.executeQuery()) {
	            if (rs.next()) {
	                count = rs.getInt(1);
	            }
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return count;
	}
	
	public ResultSet getAvailableBooks() {
	    ResultSet rs = null;
	    try {
	        Connection con = DBConnection.getConnection();
	        String sql = "SELECT * FROM books WHERE available_quantity > 0";
	        PreparedStatement ps = con.prepareStatement(sql);
	        rs = ps.executeQuery();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return rs;
	}
	
	public ResultSet getBorrowedBooksByUser(String username) {
	    String sql = "SELECT bb.borrow_id, u.fname, u.lname, b.title, b.author, bb.borrow_date,\r\n"
		    		+ "       DATE(bb.borrow_date, '+7 days') AS due_date, bb.return_date, bb.status\r\n"
		    		+ "FROM borrowed_books bb\r\n"
		    		+ "JOIN user u ON bb.user_id = u.user_id\r\n"
		    		+ "JOIN books b ON bb.book_id = b.book_id\r\n"
		    		+ "WHERE u.username = ? AND bb.status = 'Borrowed'\r\n"
		    		+ "ORDER BY bb.borrow_date DESC;\r\n"
		    		+ "";
	    try {
	        Connection con = DBConnection.getConnection();
	        PreparedStatement ps = con.prepareStatement(sql);
	        ps.setString(1, username);
	        return ps.executeQuery();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return null;
	}
	
	public ResultSet getBorrowerHistoryByUsername(String username) {
	    String sql = "SELECT bb.borrow_id, u.fname, u.lname, b.title, b.author, bb.borrow_date, " +
	                 "DATE(bb.borrow_date, '+7 days') AS due_date, bb.return_date, bb.status " +
	                 "FROM borrowed_books bb " +
	                 "JOIN user u ON bb.user_id = u.user_id " +
	                 "JOIN books b ON bb.book_id = b.book_id " +
	                 "WHERE u.username = ? " +  // No filter on status
	                 "ORDER BY bb.borrow_date DESC";
	    try {
	        Connection con = DBConnection.getConnection();
	        PreparedStatement ps = con.prepareStatement(sql);
	        ps.setString(1, username);
	        return ps.executeQuery();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return null;
	}
	
	public ResultSet getAvailableBooksWithBorrowStatus(int loggedInUserId) {
	    ResultSet rs = null;
	    try {
	        Connection con = DBConnection.getConnection();
	        String sql = "SELECT b.book_id, b.title, b.image, b.author, b.publisher, b.genre, b.available_quantity, " +
	                     "       bb.status, bb.borrow_date, bb.return_date, bb.user_id " +
	                     "FROM books b " +
	                     "LEFT JOIN borrowed_books bb " +
	                     "    ON b.book_id = bb.book_id " +
	                     "    AND bb.user_id = ? " +
	                     "    AND bb.borrow_date = (SELECT MAX(borrow_date) FROM borrowed_books WHERE book_id = b.book_id) " + // Most recent borrow record
	                     "WHERE b.available_quantity > 0 " +
	                     "ORDER BY bb.borrow_date DESC NULLS LAST;"; // Show the most recent borrow record
	        PreparedStatement ps = con.prepareStatement(sql);
	        ps.setInt(1, loggedInUserId); // Set the logged-in user's ID
	        rs = ps.executeQuery();
	    } catch (Exception e) {
	        System.out.println("SQL Error in getAvailableBooksWithBorrowStatus(): " + e.getMessage());
	        e.printStackTrace();
	    }
	    return rs;
	}

	public boolean borrowBook(Status status) {
		String sql = "INSERT INTO borrowed_books (book_id, user_id, borrow_date, status) " +
                "VALUES (?, ?, DATE('now'), ?)"; // Automatically set borrow_date to now and return_date to 7 days later
	    try (Connection con = DBConnection.getConnection();
	        PreparedStatement ps = con.prepareStatement(sql)) {
	
	       ps.setInt(1, status.getBook_id());
	       ps.setInt(2, status.getUser_id());
	       ps.setString(3, status.getStatus());
	
	       int rows = ps.executeUpdate();
	       return rows > 0;
	
	    } catch (Exception e) {
	       e.printStackTrace();
	    }
	    return false;
	}
	
	// Check if user already has a pending borrow for the same book
	public boolean hasPendingBorrow(int userId, int bookId) {
	    String sql = "SELECT * FROM borrowed_books WHERE user_id = ? AND book_id = ? AND status = 'Pending'";
	    try (Connection con = DBConnection.getConnection();
	         PreparedStatement ps = con.prepareStatement(sql)) {
	         
	        ps.setInt(1, userId);
	        ps.setInt(2, bookId);

	        try (ResultSet rs = ps.executeQuery()) {
	            return rs.next(); 
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return false;
	}
	
	public boolean decreaseAvailableQuantity(int bookId) {
	    String sql = "UPDATE books SET available_quantity = available_quantity - 1 WHERE book_id = ? AND available_quantity > 0";
	    try (Connection con = DBConnection.getConnection();
	         PreparedStatement ps = con.prepareStatement(sql)) {

	        ps.setInt(1, bookId);

	        int rows = ps.executeUpdate();
	        return rows > 0;
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return false;
	}
	
	public boolean updateBorrowStatus(int borrowId, String newStatus) {
	    String sql = "UPDATE borrowed_books SET status = ? WHERE borrow_id = ?";
	    try (Connection con = DBConnection.getConnection();
	         PreparedStatement ps = con.prepareStatement(sql)) {

	        ps.setString(1, newStatus);
	        ps.setInt(2, borrowId);

	        int rows = ps.executeUpdate();
	        return rows > 0;
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return false;
	}
	
	public User getUserByBorrowId(int borrowId) {
	    String sql = "SELECT u.* FROM user u JOIN borrowed_books bb ON u.user_id = bb.user_id WHERE bb.borrow_id = ?";
	    try (Connection con = DBConnection.getConnection();
	         PreparedStatement ps = con.prepareStatement(sql)) {

	        ps.setInt(1, borrowId);

	        ResultSet rs = ps.executeQuery();
	        if (rs.next()) {
	            User user = new User();
	            user.setId(rs.getInt("user_id"));
	            user.setFname(rs.getString("fname"));
	            user.setLname(rs.getString("lname"));
	            user.setEmail(rs.getString("email"));
	            return user;
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return null;
	}

	// AUTO-CANCEL borrow requests that are still pending after 3 days
	public List<BorrowCancelInfo> autoCancelPendingBorrows() {
	    List<BorrowCancelInfo> cancelledList = new ArrayList<>();

	    String selectSql = "SELECT bb.borrow_id, u.email, u.fname, b.title " +
	                       "FROM borrowed_books bb " +
	                       "JOIN user u ON bb.user_id = u.user_id " +
	                       "JOIN books b ON bb.book_id = b.book_id " +
	                       "WHERE bb.status = 'Pending' " +
	                       "AND DATE(bb.borrow_date, '+3 days') <= DATE('now')";

	    String updateSql = "UPDATE borrowed_books " +
	                       "SET status = 'Cancelled' " +
	                       "WHERE borrow_id = ?";

	    try (Connection con = DBConnection.getConnection();
	         PreparedStatement selectPs = con.prepareStatement(selectSql);
	         PreparedStatement updatePs = con.prepareStatement(updateSql)) {

	        ResultSet rs = selectPs.executeQuery();

	        while (rs.next()) {
	            int borrowId = rs.getInt("borrow_id");
	            String email = rs.getString("email");
	            String fname = rs.getString("fname");
	            String bookTitle = rs.getString("title");

	            BorrowCancelInfo info = new BorrowCancelInfo(email, fname, bookTitle);
	            cancelledList.add(info);

	            // Update status to Cancelled
	            updatePs.setInt(1, borrowId);
	            updatePs.executeUpdate();
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return cancelledList;
	}
	
	// SEND REMINDER for books that will be due in 1 day
	public List<BorrowReminderInfo> getNearingDueBorrows() {
        List<BorrowReminderInfo> reminderList = new ArrayList<>();

        String sql = "SELECT bb.borrow_id, u.email, u.fname, b.title, bb.borrow_date " +
                     "FROM borrowed_books bb " +
                     "JOIN user u ON bb.user_id = u.user_id " +
                     "JOIN books b ON bb.book_id = b.book_id " +
                     "WHERE bb.status = 'Borrowed' " +
                     "AND DATE(bb.borrow_date, '+6 day') = DATE('now')";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                String email = rs.getString("email");
                String fname = rs.getString("fname");
                String bookTitle = rs.getString("title");
                String borrowDateString = rs.getString("borrow_date");

                // Convert the borrow_date string to LocalDate
                LocalDate borrowDate = LocalDate.parse(borrowDateString);

                // Calculate the return date (borrow_date + 7 days)
                LocalDate dueDate = borrowDate.plusDays(7);

                // Create BorrowReminderInfo with calculated return date
                BorrowReminderInfo info = new BorrowReminderInfo(email, fname, bookTitle, dueDate.toString());
                reminderList.add(info);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return reminderList;
    }

} 