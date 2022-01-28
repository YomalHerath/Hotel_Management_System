package com.control;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.model.Reservation;
import com.model.Rooms;

public class RoomsDbUtil {
	
		//SQL Query from rooms table
		private static final String INSERT_ROOM = "INSERT INTO rooms" + "(room_no, category, amount_per_day, availability) values" + "(?, ?, ?, ?);";
		private static final String SELECT_ROOM = "SELECT * FROM rooms";
		private static final String DELETE_ROOM = "DELETE FROM rooms WHERE id = ?;";
		private static final String UPDATE_ROOM = "UPDATE rooms set room_no = ?, category = ?, amount_per_day = ?, availability = ? WHERE id = ?;"; 
		private static final String SEARCH_ROOM = "SELECT * FROM rooms WHERE (room_no LIKE ? OR category LIKE ? OR amount_per_day LIKE ? OR availability LIKE ?)";
		private static final String SELECT_ROOM_BY_ID = "SELECT * FROM rooms WHERE id = ?";
		private static final String SELECT_AVAILABLE_ROOM = "SELECT * FROM rooms WHERE availability = 'available'";
		private static final String UPDATE_RETRUNED_STATUS = "UPDATE rooms set availability = 'Available' WHERE id = ?;";
		private static final String UPDATE_STATUS = "UPDATE rooms set availability = 'Reserved' WHERE id = ?;";

		//SQL Query from reservations table
		private static final String INSERT_RESERVATION = "INSERT INTO reservations" + "(guest_name, contact_no, nic, reserved_date, stayed_day, availability, room_no, room_category, room_price) values" + "(?, ?, ?, ?, ?, ?, ?, ?, ?);";
		private static final String SELECT_RESERVED_ROOM = "SELECT * FROM reservations ORDER BY availability";
		private static final String SEARCH_RESERVED_ROOM = "SELECT * FROM reservations WHERE (guest_name LIKE ? OR contact_no LIKE ? OR room_category LIKE ? OR room_no LIKE ? OR availability LIKE ?)";
		private static final String UPDATE_RESERVATION_STATUS = "UPDATE reservations set availability = ? WHERE id = ?;";
		private static final String VIEW_INVOICE_BY_ID = "SELECT * FROM reservations WHERE id = ?;";
		
		public RoomsDbUtil() {}
		
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
		
		
		
		//Insert new room details
		public void writeData(Rooms room) throws SQLException {
			// Get a connection to the database
			try {Connection connection = getConnection();
				
				// Create a prepared statement and call the insert query to add new room details
				PreparedStatement preparedstatment = connection.prepareStatement(INSERT_ROOM);	
					
				// Prepare SQL statement and set parameters
				preparedstatment.setInt(1,room.getRoom_no());
				preparedstatment.setString(2,room.getCategory());
				preparedstatment.setFloat(3,room.getAmount_per_day());
				preparedstatment.setString(4,room.getAvailability());
				
				// Execute the query and get the result set
				preparedstatment.execute();
				
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		//Insert Reservation for Customer
		public void addReservation(Reservation reservation) throws SQLException {
			// Get a connection to the database
			try {Connection connection = getConnection();

				// Create a prepared statement and call the insert query to add new reservation
				PreparedStatement preparedstatment = connection.prepareStatement(INSERT_RESERVATION);	
	
				// Prepare SQL statement and set parameters
				preparedstatment.setString(1,reservation.getGuest_name());
				preparedstatment.setInt(2,reservation.getContact_no());
				preparedstatment.setInt(3,reservation.getNic());
				preparedstatment.setString(4,reservation.getReserved_date());
				preparedstatment.setInt(5,reservation.getStayed_day());
				preparedstatment.setString(6,reservation.getAvailability());
				preparedstatment.setInt(7,reservation.getRoom_no());
				preparedstatment.setString(8,reservation.getRoom_category());
				preparedstatment.setFloat(9,reservation.getRoom_price());
				
				// Execute the query and get the result set
				preparedstatment.execute();
						
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		//List all room details
		public List<Rooms> listData() {
			
			// create array list to save all room details
			List<Rooms> room = new ArrayList<>();
			
			// Get a connection to the database
			try (Connection connection = getConnection();

				// Create a prepared statement and call the select query to list room details
				PreparedStatement prepaStatement = connection.prepareStatement(SELECT_ROOM);) {
				
				// Execute the statement
				ResultSet rs = prepaStatement.executeQuery();
				
				// Get details from database to list details with loop
				while(rs.next()) {
					int id = rs.getInt("id");
					int room_no = rs.getInt("room_no");
					String category = rs.getString("category");
					float amount_per_day = rs.getFloat("amount_per_day");
					String availability = rs.getString("availability");
					
					room.add(new Rooms(id, room_no, category, amount_per_day, availability));
				}
			}catch (SQLException e) {
				e.printStackTrace();
			}
			return room;
		}
		
		//List all available room details
		public List<Rooms> listAvailableRoomData() {
			
			// create array list to save available room details
			List<Rooms> room = new ArrayList<>();
			
			// Get a connection to the database
			try (Connection connection = getConnection();
					
				// Create a prepared statement and call the select query to list available room details		
				PreparedStatement prepaStatement = connection.prepareStatement(SELECT_AVAILABLE_ROOM);) {

				// Execute the statement	
				ResultSet rs = prepaStatement.executeQuery();

				// Get details from database to list details with loop	
				while(rs.next()) {
					int id = rs.getInt("id");
					int room_no = rs.getInt("room_no");
					String category = rs.getString("category");
					float amount_per_day = rs.getFloat("amount_per_day");
					String availability = rs.getString("availability");
							
					room.add(new Rooms(id, room_no, category, amount_per_day, availability));
				}
			}catch (SQLException e) {
				e.printStackTrace();
			}
			return room;
		}
		
		//List all reserved room details
		public List<Reservation> listReservedRoomData() {

			// create array list to save reserved room details
			List<Reservation> reservations = new ArrayList<>();
			
			// Get a connection to the database
			try (Connection connection = getConnection();
					
			// Create a prepared statement and call the select query to list reserved room details	
			PreparedStatement prepaStatement = connection.prepareStatement(SELECT_RESERVED_ROOM);) {

				// Execute the statement					
				ResultSet rs = prepaStatement.executeQuery();

				// Get details from database to list details with loop					
				while(rs.next()) {
					int id = rs.getInt("id");
					String guest_name = rs.getString("guest_name");
					int contact_no = rs.getInt("contact_no");
					int nic = rs.getInt("nic");
					String reserved_date = rs.getString("reserved_date");
					int stayed_day = rs.getInt("stayed_day");
					String availability = rs.getString("availability");
					int room_no = rs.getInt("room_no");
					String room_category = rs.getString("room_category");
					float room_price = rs.getFloat("room_price");
										
					reservations.add(new Reservation(id, guest_name, contact_no, nic, reserved_date, stayed_day, availability, room_no, room_category, room_price));
				}
			}catch (SQLException e) {
				e.printStackTrace();
			}
				return reservations;
		}
		
		//List Invoice Details for customer reservation
		public Reservation selcetInvoiceData(int id) {
			Reservation reservation = null;
			
			// Get a connection to the database
			try (Connection connection = getConnection();
							
				// Create a prepared statement and call the select query to list reserved room details	
				PreparedStatement preparedStatement = connection.prepareStatement(VIEW_INVOICE_BY_ID);) {
				
				// Execute the statement					
				preparedStatement.setInt(1, id);
				ResultSet rs = preparedStatement.executeQuery();

				// Get details from database to list details with loop
				while(rs.next()) {
					int res_id = rs.getInt("id");
					String guest_name = rs.getString("guest_name");
					int contact_no = rs.getInt("contact_no");
					int nic = rs.getInt("nic");
					String reserved_date = rs.getString("reserved_date");
					int stayed_day = rs.getInt("stayed_day");
					String availability = rs.getString("availability");
					int room_no = rs.getInt("room_no");
					String room_category = rs.getString("room_category");
					float room_price = rs.getFloat("room_price");
								
					reservation = new Reservation(res_id, guest_name, contact_no, nic, reserved_date, stayed_day, availability, room_no, room_category, room_price);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
				return reservation;
		}
		
		//List Room Details by Id
		public Rooms selectData(int room_id) {
			Rooms room = null;
			
			// Get a connection to the database
			try (Connection connection = getConnection();

				// Create a prepared statement and call the select id query to get room details by id	
				PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ROOM_BY_ID);) {
				
				// Execute the statement	
				preparedStatement.setInt(1, room_id);
				ResultSet rs = preparedStatement.executeQuery();
				
				// Get details from database to get room details with loop
				while(rs.next()) {
					int id = rs.getInt("id");
					int room_no = rs.getInt("room_no");
					String category = rs.getString("category");
					float amount_per_day = rs.getFloat("amount_per_day");
					String availability = rs.getString("availability");
					
					room = new Rooms(id, room_no, category, amount_per_day, availability);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			return room;
		}
		
		//Delete room details
		public boolean deleteData(int id) throws SQLException {
			boolean rowDelete;
			
			// Get a connection to the database
			try (Connection connection = getConnection();
				
				// Create a prepared statement and call the delete query
				PreparedStatement statement = connection.prepareStatement(DELETE_ROOM);) {

					// Execute the statement
					statement.setInt(1, id);
					rowDelete = statement.executeUpdate() > 0;
					
			}
			return rowDelete;
		}
		
		//Update Room Details
		public boolean updateRoomData(Rooms room) throws SQLException{
			boolean rowUpdate;
			
			// Get a connection to the database
			try (Connection connection = getConnection();

				// Create a prepared statement and call the update query to update room details
				PreparedStatement statment = connection.prepareStatement(UPDATE_ROOM);) {
				
				// Prepare SQL statement and set parameters
				statment.setInt(1,room.getRoom_no());
				statment.setString(2,room.getCategory());
				statment.setFloat(3,room.getAmount_per_day());
				statment.setString(4,room.getAvailability());
				statment.setInt(5,room.getId());
				
				// Execute the statement
				rowUpdate = statment.executeUpdate() > 0;
			}
			return rowUpdate;
		}

		//Update reservation return status
		public boolean updateRetrunStatus(Reservation reservation) throws SQLException{
			boolean updateStatus;	
			
			// Get a connection to the database
			try (Connection connection = getConnection();

				// Create a prepared statement and call the update query to update return status
				PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_RETRUNED_STATUS);
				// Create a prepared statement and call the update query to update reservation status
				PreparedStatement statment = connection.prepareStatement(UPDATE_RESERVATION_STATUS);) {
				
					// Prepare SQL statements and set parameters
					statment.setString(1,reservation.getAvailability());
					statment.setInt(2,reservation.getId());
					preparedStatement.setInt(1,reservation.getId());
				
					// Execute the statements
					updateStatus = preparedStatement.execute();
					updateStatus = statment.executeUpdate() > 0;
				}
			System.out.println(updateStatus);
			return updateStatus;
		}
		
		//Update Reserved Status from Available Rooms
		public boolean updateStatus(Rooms rooms) throws SQLException{
			boolean updateStatus;
			
			// Get a connection to the database
			try (Connection connection = getConnection();

				// Create a prepared statement and call the update query to update status
				PreparedStatement statment = connection.prepareStatement(UPDATE_STATUS);) {

				// Prepare SQL statements and set parameters
				statment.setInt(1,rooms.getId());
				
				// Execute the statement
				updateStatus = statment.execute();
			}
			return updateStatus;
		}
		
		//Search All Room Details
		public List<Rooms> listSearch(String search) throws SQLException {
			List<Rooms> rooms = new ArrayList<>();

			// Get a connection to the database
			try (Connection connection = getConnection();		

				// Create a prepared statement and call the update query to search room details
				PreparedStatement preparStatement = connection.prepareStatement(SEARCH_ROOM);) {
				
					// Prepare SQL statements and set parameters
					preparStatement.setString(1, "%"+search+"%");
					preparStatement.setString(2, "%"+search+"%");
					preparStatement.setString(3, "%"+search+"%");
					preparStatement.setString(4, "%"+search+"%");
					
					// Execute the statement
					ResultSet rs = preparStatement.executeQuery();
					
					// Get details from database to list details with loop
					while(rs.next()) {
						int room_no = rs.getInt("room_no");
						String category = rs.getString("category");
						float amount_per_day = rs.getFloat("amount_per_day");
						String availability = rs.getString("availability");
							
						rooms.add(new Rooms(room_no, category, amount_per_day, availability));
					}
				
				}catch (SQLException e) {
					e.printStackTrace();
				}
				return rooms;
			}
		
		//Search reserved room details
		public List<Reservation> listReservedSearch(String search) throws SQLException {
			List<Reservation> reservation = new ArrayList<>();
				
			// Get a connection to the database
			try (Connection connection = getConnection();

				// Create a prepared statement and call the update query to search reserved room details
				PreparedStatement preparStatement = connection.prepareStatement(SEARCH_RESERVED_ROOM);) {
				
				// Prepare SQL statements and set parameters
				preparStatement.setString(1, "%"+search+"%");
				preparStatement.setString(2, "%"+search+"%");
				preparStatement.setString(3, "%"+search+"%");
				preparStatement.setString(4, "%"+search+"%");
				preparStatement.setString(5, "%"+search+"%");
					
				// Execute the statement
				ResultSet rs = preparStatement.executeQuery();
					
				// Get details from database to list details with loop
				while(rs.next()) {
					String guest_name = rs.getString("guest_name");
					int contact_no = rs.getInt("contact_no");
					int room_no = rs.getInt("room_no");
					String category = rs.getString("room_category");
					String availability = rs.getString("availability");
									
					reservation.add(new Reservation(guest_name, contact_no, availability, room_no, category));
				}
			}catch (SQLException e) {
				e.printStackTrace();
			}
			return reservation;
		}
		
}
