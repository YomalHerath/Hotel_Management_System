package com.control;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.model.Employee;

public class EmployeeDBUtil {

		//SQL Query
		private static final String INSERT_USER = "INSERT INTO employee" + "(fullname, email, contact, username, password) values" + "(?, ?, ?, ?, ?);";
		private static final String LOGIN_USER = "SELECT * FROM employee WHERE username = ? and password = ?";
		private static final String GETID_USER = "SELECT id FROM employee WHERE username = ?";
		
		public EmployeeDBUtil() {}
		
		//Make Database Connection
		protected Connection getConnection() {
			Connection connection = null;
				try {
					Class.forName("com.mysql.jdbc.Driver");
					connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/hotel_management?useSSL=false","root","root");
				} catch (SQLException e) {
					e.printStackTrace();
				} catch (ClassNotFoundException e) {	
					e.printStackTrace();
				}
			return connection;
		}
			
		//Insert user details
		public void writeData(Employee employee) throws SQLException {
			// Get a connection to the database
			try {Connection connection = getConnection();
				
				// Create a prepared statement and call the insert query
				PreparedStatement preparedstatment = connection.prepareStatement(INSERT_USER);	
					
	            // Prepare SQL statement and set parameters
				preparedstatment.setString(1,employee.getFullname());
				preparedstatment.setString(2,employee.getEmail());
				preparedstatment.setString(3,employee.getContact());
				preparedstatment.setString(4,employee.getUsername());
				preparedstatment.setString(5,employee.getPassword());

	            // Execute the query and get the result set
				preparedstatment.execute();
				
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		//Login user validate
		public boolean validateEmployee(Employee employee) throws ClassNotFoundException, SQLException {
			boolean status = false;
			
			// Get a connection to the database
			try (Connection connection = getConnection();
				
				// Create a prepared statement and call the login query
				PreparedStatement preparedStatement = connection.prepareStatement(LOGIN_USER);) {
					
						// Prepare SQL statement and set parameters
			            preparedStatement.setString(1, employee.getUsername());
			            preparedStatement.setString(2, employee.getPassword());
					
			            // Execute the statement
			            ResultSet rs = preparedStatement.executeQuery();
			            status = rs.next();

			        return status;
				}
		}
		
		// Get user id from valid user
		public int getIdfromUsername(String username) throws SQLException {
			int id = 0;
			
			// Get a connection to the database
			try (Connection connection = getConnection();
					
					// Create a prepared statement and call the get id query
					PreparedStatement preparedStatement = connection.prepareStatement(GETID_USER);) {
				
					// Prepare SQL statement and set parameters
					preparedStatement.setString(1,username);
					
					// Execute the statement
					ResultSet rs = preparedStatement.executeQuery();
					if(rs.next()) {
						id = rs.getInt("id"); 
					}
			}
			return id;
		}
}
