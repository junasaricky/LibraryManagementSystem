package com.junasa.dbconnection;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

static Connection con = null;
	
	public static Connection getConnection() {
		try {
			Class.forName("org.sqlite.JDBC");
			String jdbcurl = "jdbc:sqlite:C:\\Users\\DELL\\lib_mgmt.db";
			con = DriverManager.getConnection(jdbcurl);
		} catch (Exception e) {
			System.out.println("SQLite JDBC driver not found.");
			e.printStackTrace();
		}
		return con;
	}
}
