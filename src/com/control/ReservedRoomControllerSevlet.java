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

import com.model.Reservation;

@WebServlet("/ReservedRoomControllerSevlet")
public class ReservedRoomControllerSevlet extends HttpServlet {
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
					case "/view":
						viewInvoice(request, response);
						break;	
					case "/edit":
						makeReturn(request, response);
						break;	
					case "/search":
	               	 	searchDetails(request, response);
	               	 	break;
					default:
	             		listReservedDetails(request, response);
	             		break;
				}
		} catch (SQLException ex) {
				throw new ServletException(ex);
		}
	}
	
	//search Reserved Rooms
	private void searchDetails(HttpServletRequest request, HttpServletResponse response) 
			throws SQLException, IOException, ServletException {
			
		// Read data from the form
		String search = request.getParameter("search");
				
		// Perform listing reserved room searched method on database
		List<Reservation> searchRooms = roomsDbUtil.listReservedSearch(search);
		
		//Get searched room details and send to searched reservation details page
		request.setAttribute("searchRooms", searchRooms);
		RequestDispatcher dispatcher = request.getRequestDispatcher("searchReserved_Rooms.jsp");
		dispatcher.forward(request, response);
	}

	//Make Return Reserved Room Details
	private void makeReturn(HttpServletRequest request, HttpServletResponse response) 
		throws SQLException, IOException {
			
		// Read data from the form
		int id = Integer.parseInt(request.getParameter("id"));
		String availability = request.getParameter("availability");
		
		// Create a reservation object using previously read data
		Reservation reservation = new Reservation(id, availability);
		
		// Perform update on database
		roomsDbUtil.updateRetrunStatus(reservation);
		response.sendRedirect("ReservedRoomControllerSevlet");
		
	}

	//Table View Data
	private void listReservedDetails(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException, ServletException {
		
		// Perform listing reserved room searched method on database
		List<Reservation> listReservedRooms = roomsDbUtil.listReservedRoomData();
		
		//Get room details and send to reservation details page
		request.setAttribute("listReservedRooms", listReservedRooms);
		RequestDispatcher dispatcher = request.getRequestDispatcher("/Reserved_Rooms.jsp");
		dispatcher.forward(request, response);
		
	}

	//View Invoice Data 
	private void viewInvoice(HttpServletRequest request, HttpServletResponse response) 
			throws SQLException, IOException, ServletException {
		
		// Read data from the form
		int id = Integer.parseInt(request.getParameter("id"));
		
		// Perform update on database
		Reservation listReservedRooms = roomsDbUtil.selcetInvoiceData(id);
		
		//Get room details and send to reservation invoice page
		RequestDispatcher dispatcher = request.getRequestDispatcher("Reservation_Invoice.jsp");
		request.setAttribute("listReservedRooms", listReservedRooms);
		dispatcher.forward(request, response);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
