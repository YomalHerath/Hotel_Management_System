<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.model.Rooms" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
	<!-- get available room details with request -->
	<% List<Rooms> listAvailableRooms = (List<Rooms>) request.getAttribute("listAvailableRooms"); %>
<head>
  	  <title>Hotel Management System</title>
	  <meta charset="utf-8">
	  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	  
	  <!-- import custom style sheet -->
	  <link rel="stylesheet" type="text/css" href="css/style.css">
	  
	  <!-- import bootstrap -->
	  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
	  
	  <!-- import font awesome icons -->
	  <link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
	  <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
</head>

<body>
	<!-- import site header -->
  	<jsp:include page="/View/Header.jsp"></jsp:include>

	<!-- create a login session -->
	<%
		if(session.getAttribute("id") == null){
			response.sendRedirect("Login.jsp");
		}
	%>

  	<div class="container">
  
    	<h3 class="text-center" style="font-weight: bold;">Available Rooms</h3>
    	<hr>

		<!-- create table view to show available room details -->    
        <table class="table table-striped" border="1" style="background-color:white">
        	
        	<thead class="table-success">
            <tr>
                <th>Category</th>
                <th>Room Number</th>
                <th>Status</th>
                <th>Action</th>
        	</tr>
            </thead>
            
            <tbody>
            
            	<!-- list all available room details in database with for each loop -->
	            <c:forEach var="listAvailableRooms" items="${listAvailableRooms}" >
		            
		            <tr>
						<td><c:out value="${listAvailableRooms.category}" /></td>
	            		<td>Room <c:out value="${listAvailableRooms.room_no}" /></td>
	               		<td><div class="text-light bg-success font-weight-bold"><c:out value="${listAvailableRooms.availability}" /></div></td>
	               		<td>
		                	<a class="btn btn-outline-success btn-sm font-weight-bold" href="AvailableRoomsControllerServlet?action=/edit&id=<c:out value='${listAvailableRooms.id}' />">Add Reservation</a>
		                
		                	<a class="btn btn-outline-none btn-sm font-weight-bold">
		                	
			                	<form action ="AvailableRoomsControllerServlet" method="POST">
	            					<input type="hidden" name="action" value="/change" />
	            			
	            					<input type="hidden" name="id" value="${listAvailableRooms.id}">
	            					<input type="hidden" name="availability" value="Reserved">
	            				
	                				<button class="btn btn-outline-secondary btn-sm font-weight-bold" type="submit">Mark As Reserved</button>
	                			</form>
	                		
	                		</a>
		                </td>
		         	</tr>
		         	
		       	</c:forEach>
		 
            </tbody>

		</table>
		
	</div>

	<!-- import site footer -->
  	<jsp:include page="/View/Footer.jsp"></jsp:include>

</body>
</html>
