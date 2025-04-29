package com.junasa.bean;

public class User {
	
	int id;
	String fname;
	String lname;
	String email;
	String cnumber;
	String username;
	String password;
	String role;
	String emailChangeToken;  
	java.sql.Timestamp emailChangeTokenExpiry;  
	String passwordResetToken;
	java.sql.Timestamp passwordResetTokenExpiry;
	
	public User(int id) {
		this.id = id;
	}
	public User(String username) {
		this.username = username;
	}
	public User() {
	}
	public User(String email, int id, String fname) {
		this.email = email;
		this.id = id;
		this.fname = fname;
	}
	public User(String fname, String lname, String email, String cnumber,String username,String password, String role) {
		super();
		this.fname = fname;
		this.lname = lname;
		this.email = email;
		this.cnumber = cnumber;
		this.username = username;
		this.password = password;
		this.role = role;
	}
	public User(String fname, String lname, String email, String cnumber, String username, String password, String role, int id) {
		this.fname = fname;
		this.lname = lname;
		this.email = email;
		this.cnumber = cnumber;
		this.username = username;
		this.password = password;
		this.role = role;
		this.id = id;
	}
	public User(String username, String password, String role, int id) {
		this.username = username;
		this.password = password;
		this.role = role;
		this.id = id;
	}
	public User(String fname, String lname, String email, String cnumber, int id) {
		this.fname = fname;
		this.lname = lname;
		this.email = email;
		this.cnumber = cnumber;
		this.id = id;
	}
	public User(String fname, String lname, String cnumber, int id, boolean isBasicInfo) {
		this.fname = fname;
		this.lname = lname;
		this.cnumber = cnumber;
		this.id = id;
	}
	public User(String fname, String lname, String email, String cnumber, String username, String password, String role, int id, String emailChangeToken, java.sql.Timestamp emailChangeTokenExpiry) {
		this.fname = fname;
		this.lname = lname;
		this.email = email;
		this.cnumber = cnumber;
		this.username = username;
		this.password = password;
		this.role = role;
		this.id = id;
		this.emailChangeToken = emailChangeToken;
		this.emailChangeTokenExpiry = emailChangeTokenExpiry;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getFname() {
		return fname;
	}
	public void setFname(String fname) {
		this.fname = fname;
	}
	public String getLname() {
		return lname;
	}
	public void setLname(String lname) {
		this.lname = lname;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getCnumber() {
		return cnumber;
	}
	public void setCnumber(String cnumber) {
		this.cnumber = cnumber;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public String getEmailChangeToken() {
		return emailChangeToken;
	}
	public void setEmailChangeToken(String emailChangeToken) {
		this.emailChangeToken = emailChangeToken;
	}
	public java.sql.Timestamp getEmailChangeTokenExpiry() {
		return emailChangeTokenExpiry;
	}
	public void setEmailChangeTokenExpiry(java.sql.Timestamp emailChangeTokenExpiry) {
		this.emailChangeTokenExpiry = emailChangeTokenExpiry;
	}
	public String getPasswordResetToken() {
		return passwordResetToken;
	}
	public void setPasswordResetToken(String passwordResetToken) {
		this.passwordResetToken = passwordResetToken;
	}
	public java.sql.Timestamp getPasswordResetTokenExpiry() {
		return passwordResetTokenExpiry;
	}
	public void setPasswordResetTokenExpiry(java.sql.Timestamp passwordResetTokenExpiry) {
		this.passwordResetTokenExpiry = passwordResetTokenExpiry;
	}
	
}
