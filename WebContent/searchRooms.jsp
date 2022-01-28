<%@page import="com.sun.org.apache.xerces.internal.impl.xpath.regex.REUtil"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.model.Rooms" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
	<!-- get searched all room details with request -->
	<% List<Rooms> searchRooms = (List<Rooms>) request.getAttribute("searchRooms"); %>
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

	<div class="row">

	    <div class="container">
	    
		    <h3 class="text-center" style="font-weight: bold;">All Room Details</h3>
		    <hr>
			
			<div class="container text-left">
		        
		        <!-- create search bar -->
			    <form class="form-inline my-2 my-lg-0" action="RoomsServer" method="POST">
			    	<input class="form-control mr-sm-2" type="search" placeholder="Search here..." name="search" aria-label="Search">
			    	<input type="hidden" name="action" value="/search">
			    	<button class="btn btn-info font-weight-bold" type="submit">Search</button>
			    </form>
			    
			    <br>
			    
				<a href="Add_New_Room.jsp" class="btn btn-outline-info font-weight-bold"><i class="fa fa-bed">&nbsp;Add New Room</i></a>
			
		    </div>
		    
		    <br>
        
        
        <!-- create table view to show searched all room details -->  
        <table class="table table-striped" border="1" style="background-color:white">
        	
        	<thead class="table-primary">
            <tr>
                <th>Category</th>
                <th>Room Number</th>
                <th>Amount Per Day</th>
                <th>Status</th>
                <th>Action</th>
        	</tr>
            </thead>
            
            <tbody>
            
            	<!-- list all searched all room details in database with for each loop -->
	            <c:forEach var="rooms" items="${searchRooms}">
	            <tr>
					<td><c:out value="${rooms.category}" /></td>
	            	<td>Room <c:out value="${rooms.room_no}" /></td>
					<td>Rs <c:out value="${rooms.amount_per_day}" /></td>
	                <td><div class="text-light bg-info font-weight-bold"><c:out value="${rooms.availability}" /></div></td>
	                <td>
	                	<a class="btn btn-outline-primary btn-sm font-weight-bold" href="RoomsServer?action=/edit&id=<c:out value='${rooms.id}' />">Edit</a> 
		                &nbsp; 
	                    <a class="btn btn-outline-danger btn-sm font-weight-bold" href="RoomsServer?action=/delete&id=<c:out value='${rooms.id}' />">Delete</a>
	                </td>
	         	</tr>
	            </c:forEach>
	            
            </tbody>

		</table>
	</div>
    </div>  
            
    <!-- import site footer -->
    <jsp:include page="/View/Footer.jsp"></jsp:include>
</body>
</html>