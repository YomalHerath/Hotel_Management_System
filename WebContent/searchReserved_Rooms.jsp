<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.model.Reservation" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
	<!-- get searched reserved room details with request -->
	<% List<Reservation> searchRooms = (List<Reservation>) request.getAttribute("searchRooms"); %>
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
  
		<!--  Reserved Rooms -->	
		<h3 class="text-center" style="font-weight: bold;">Reserved Rooms</h3>
	    
	    <hr>
	        
	    <div class="container text-left">
	        
	        <!-- create search bar -->
		    <form class="form-inline my-2 my-lg-0" action="ReservedRoomControllerSevlet" method="POST">
		    	<input class="form-control mr-sm-2" type="search" placeholder="Search here..." name="search" aria-label="Search">
		    	<input type="hidden" name="action" value="/search">
		    	<button class="btn btn-info font-weight-bold" type="submit">Search</button>
		    </form>
		
			<br>
		
	    </div>
            
        <!-- create table view to show searched reserved room details -->  
        <table class="table table-striped" border="1" style="background-color:white">
        	
        	<thead class="table-dark">
            <tr>
                <th>Guest Name</th>
                <th>Contact No</th>
                <th>Category</th>
                <th>Room Number</th>
                <th>Status</th>
                <th>Action</th>
        	</tr>
            </thead>
            
            <tbody>
            
            	<!-- list all searched reserved room details in database with for each loop -->
	            <c:forEach var="listReservedRooms" items="${searchRooms}" >
    
    				<tr>
						<td><c:out value="${listReservedRooms.guest_name}" /></td>
						<td><c:out value="${listReservedRooms.contact_no}" /></td>
						<td><c:out value="${listReservedRooms.room_category}" /></td>
	            		<td>Room <c:out value="${listReservedRooms.room_no}" /></td>
	               		<td><div class="text-light bg-secondary font-weight-bold"><c:out value="${listReservedRooms.availability}" /></div></td>
	               		<td>
                			<a class="btn btn-outline-primary btn-sm font-weight-bold" href="ReservedRoomControllerSevlet?action=/view&id=<c:out value='${listReservedRooms.id}'/>">View</a>
                			
                			<a class="btn btn-outline-none btn-sm font-weight-bold">
                				<form action ="ReservedRoomControllerSevlet" method="POST">
	            					<input type="hidden" name="action" value="/edit" />
	            			
	            					<input type="hidden" name="id" value="${listReservedRooms.id}">
	            					<input type="hidden" name="availability" value="Returend">
	            				
	                				<button type="submit" class="btn btn-outline-secondary btn-sm font-weight-bold">Return</button>
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