package com.control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.model.Rooms;

@WebServlet("/RoomsServer")
public class RoomsControllerServlet extends HttpServlet {
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
             	case "/insert":
             		insertNewRoom(request, response);
             		break;
             	case "/delete":
             		deleteRoom(request, response);
             		break;
             	case "/edit":
             		showEditForm(request, response);
                    break;
                case "/update":
               	 	updateRoomDetails(request, response);
                    break;
                case "/search":
               	 	searchRoomDetails(request, response);
               	 	break;
                default:
             		listRoomDetails(request, response);
             		break;
			}
		} catch (SQLException ex) {
			throw new ServletException(ex);
		}
	}
	
	// Search room details 
	private void searchRoomDetails(HttpServletRequest request, HttpServletResponse response) 
			throws SQLException, IOException, ServletException {
			
		// Read data from the search form
		String search = request.getParameter("search");
			
		// Perform listing all room searched method on database
		List<Rooms> searchRooms = roomsDbUtil.listSearch(search);
			
		// Get room details and send to searched room details page
		request.setAttribute("searchRooms", searchRooms);
		RequestDispatcher dispatcher = request.getRequestDispatcher("searchRooms.jsp");
		dispatcher.forward(request, response);
	}
	
	// Edit room details 
	private void showEditForm(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException, ServletException {
		
		// Read id form button click
		int id = Integer.parseInt(request.getParameter("id"));
		
		// Perform select id method for edit details on database
		Rooms existingRooms = roomsDbUtil.selectData(id);
		
		// Get room details and send to edit room form page
		RequestDispatcher dispatcher = request.getRequestDispatcher("Edit_Rooms.jsp");
		request.setAttribute("existingRooms", existingRooms);
		dispatcher.forward(request, response);
	}
	
	//Update room details 
	private void updateRoomDetails(HttpServletRequest request, HttpServletResponse response) 
			throws SQLException, IOException {
		
		// Read data from the form
		int id = Integer.parseInt(request.getParameter("id"));
		int room_no = Integer.parseInt(request.getParameter("room_no"));
		String category = request.getParameter("category");
		float amount_per_day = Float.parseFloat(request.getParameter("amount_per_day"));
		String availability = request.getParameter("availability");
		
		// Create a room object using previously read data
		Rooms room = new Rooms(id,room_no,category,amount_per_day,availability);
		
		// Perform update on database
		roomsDbUtil.updateRoomData(room);

		// Redirect back to room detail view page with server
		response.sendRedirect("RoomsServer");
	}

	//List all room details 
	private void listRoomDetails(HttpServletRequest request, HttpServletResponse response)  
			throws SQLException, IOException, ServletException {
		
		// Perform list data method for list all room details
		List<Rooms> listRooms = roomsDbUtil.listData();
		
		// Get room details and send to room details page
		request.setAttribute("listRooms", listRooms);
		RequestDispatcher dispatcher = request.getRequestDispatcher("Rooms.jsp");
		dispatcher.forward(request, response);
		
	}

	//Delete room details
	private void deleteRoom(HttpServletRequest request, HttpServletResponse response) 
			throws SQLException, IOException {
		
		// Read id from the button click
		int id = Integer.parseInt(request.getParameter("id"));
		
		// Perform delete data method on database
		roomsDbUtil.deleteData(id);
		
		// Redirect back to room detail view page with server
		response.sendRedirect("RoomsServer");
	}

	//Insert new room details
	private void insertNewRoom(HttpServletRequest request, HttpServletResponse response)  	
			throws SQLException, IOException {
		
		// Read data from the form
		int room_no = Integer.parseInt(request.getParameter("room_no"));
		String category = request.getParameter("category");
		float amount_per_day = Float.parseFloat(request.getParameter("amount_per_day"));
		String availability = request.getParameter("availability");
		
		// Create a room object using previously read data
		Rooms room = new Rooms(room_no,category,amount_per_day,availability);
		
		// Perform insert on database
		roomsDbUtil.writeData(room);
		
		// Redirect back to room detail view page with server
		response.sendRedirect("RoomsServer");
		
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
