package com.control;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.model.Employee;

@WebServlet("/EmployeeServer")
public class EmployeeControllerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private EmployeeDBUtil employeeDBUtil;
    
	public void init() {
		employeeDBUtil = new EmployeeDBUtil();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		// Read 'action' parameter from the request
		String action = request.getParameter("action");
				
		// Route to appropriate methods
		if (action == null)
			action = "list";
        
		try {
	         switch (action) {
	             case "/insert":
	            	 insertUser(request, response);
	                 break;
	             default:
	            	 Account(request, response);
	            	 break;
	         }
	     } catch (SQLException ex) {
	         throw new ServletException(ex);
	     }      
    }
	
	// Insert new user details
	private void insertUser(HttpServletRequest request, HttpServletResponse response) 
			throws SQLException, IOException {
		
		// Read data from the form
		String fullname = request.getParameter("Fullname");
		String email = request.getParameter("Email");
		String contact = request.getParameter("Contact");
		String username = request.getParameter("Username");
        String password = request.getParameter("Password");
        
        // Create a employee object using previously read data
        Employee employee = new Employee(fullname, email, contact, username, password);
        
        // Perform insert on database
        employeeDBUtil.writeData(employee);
		
        // Redirect back to login page
        response.sendRedirect("Login.jsp");
		
	}
	
	// Login user
	private void Account(HttpServletRequest request, HttpServletResponse response) 
			throws SQLException, IOException, ServletException {
		       
		// Read data from the form
		String username = request.getParameter("Username");
		String password = request.getParameter("Password");
		
		// Create a employee object
		Employee login = new Employee();
	
		// Create Cookies
        Cookie UsernameCookie = new Cookie("uname", username);
        
        // Set life span for cookies with total number of seconds
        UsernameCookie.setMaxAge(60*60*24*365);
        
        // Send cookies to browser
        response.addCookie(UsernameCookie);
		
        // Set previously read data to employee object
		login.setUsername(username);
		login.setPassword(password);

		try {
			if (employeeDBUtil.validateEmployee(login)) {
				int id = employeeDBUtil.getIdfromUsername(username);
		                
					// Get session object
		        	HttpSession session = request.getSession();
		        	
		        	// Set session for user id 
		            session.setAttribute("id",id);
		            response.sendRedirect("Home.jsp");
		    } else {
		            response.sendRedirect("Login.jsp");
		    }
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
