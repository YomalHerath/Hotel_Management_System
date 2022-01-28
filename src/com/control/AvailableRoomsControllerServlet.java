package com.control;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.model.Reservation;
import com.model.Rooms;

import java.util.List;

@WebServlet("/AvailableRoomsControllerServlet")
public class AvailableRoomsControllerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	private RoomsDbUtil roomsDbUtil;
	
    @Override
	public void init() {
		roomsDbUtil = new RoomsDbUtil(); 
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// Read 'action' parameter from the request
		String action = request.getParameter("action");
		
		// Route to appropriate methods
		if (action == null)
			action = "list";
		
		try {
			switch (action) {
             	case "/add":
             		addReservation(request, response);
             		break;
             	case "/edit":
             		getId(request, response);
                    break;
             	case "/change":
             		updateStatus(request, response);
                    break;
             	default:
                 	listAvailableRoomDetails(request, response);
                 	break;
    			}
    		} catch (SQLException ex) {
    			throw new ServletException(ex);
    		}
	}

	// update room availability status 
	private void updateStatus(HttpServletRequest request, HttpServletResponse response) 
			throws SQLException, IOException {
		
		// Read data from the form
		int id = Integer.parseInt(request.getParameter("id"));
		String availability = request.getParameter("availability");
		
		// Create a room object using previously read data
		Rooms room = new Rooms(id, availability);
		
		// Perform update on database
		roomsDbUtil.updateStatus(room);
		
		// Redirect back to available rooms details page
		response.sendRedirect("AvailableRoomsControllerServlet");
	}
		
	//Get room_id and other details from table for reservation form
	private void getId(HttpServletRequest request, HttpServletResponse response) 
			throws SQLException, IOException, ServletException {
		
		// Read data
		int id = Integer.parseInt(request.getParameter("id"));
		
		// Perform select data with id method on database
		Rooms reservedRooms = roomsDbUtil.selectData(id);
		
		// Get and send room ID to add reservation page
		RequestDispatcher dispatcher = request.getRequestDispatcher("Add_Reservation.jsp");
		request.setAttribute("reservedRooms", reservedRooms);
		dispatcher.forward(request, response);
	
	}

	//List all available room details
	private void listAvailableRoomDetails(HttpServletRequest request, HttpServletResponse response) 
			throws SQLException, IOException, ServletException {
		
		// Perform listing available room method on database
		List<Rooms> listAvailableRooms = roomsDbUtil.listAvailableRoomData();
		
		//Get available room details and send to reservation page
		request.setAttribute("listAvailableRooms", listAvailableRooms);
		RequestDispatcher dispatcher = request.getRequestDispatcher("Reservations.jsp");
		dispatcher.forward(request, response);
	}

	//Add new Reservation
	private void addReservation(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException {
			
		// Read data from the form
		String guestName = request.getParameter("guestName");
		int contact_no = Integer.parseInt(request.getParameter("contact_no"));
		int nic = Integer.parseInt(request.getParameter("nic"));
		String reservedDate = request.getParameter("reservedDate");
		int stayedDays = Integer.parseInt(request.getParameter("stayedDays"));
		String availability = request.getParameter("availability");
		int room_no = Integer.parseInt(request.getParameter("id"));
		String room_category = request.getParameter("room_category");
		float room_price = Float.parseFloat(request.getParameter("room_price"));
		
		// Create a reservation object using previously read data
		Reservation reservation = new Reservation(guestName, contact_no, nic, reservedDate, stayedDays, availability, room_no, room_category, room_price);
			
		// Perform insert on database
		roomsDbUtil.addReservation(reservation);
		response.sendRedirect("AvailableRoomsControllerServlet");
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
