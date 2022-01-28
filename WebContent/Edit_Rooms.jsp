<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.model.Rooms" %>
<!DOCTYPE html>
<html>
	<!-- Get existing room details with request -->
	<% Rooms existingRooms = (Rooms) request.getAttribute("existingRooms"); %>
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
	
	<!-- create edit room details form -->
	<div class="container col-md-4">
    	<div class="card">
        	<div class="card-body">
            			         	
            	<h2><b>Edit Room Details</b></h2>
                     	
                	<form action ="RoomsServer" method="POST">
            			<input type="hidden" name="action" value="/update" />
            			<input type="hidden" name="id" value="${existingRooms.id}">

                	<fieldset class="form-group">
                    	<label>Room Number</label> <input type="text" class="form-control" name="room_no"
                        value="${existingRooms.room_no}" >
                    </fieldset>
                	
                	<fieldset class="form-group">
                    	<label>Category</label> <input type="text" class="form-control" name="category"
                        value="${existingRooms.category}" > 
						
                    </fieldset>
                    
                    <fieldset class="form-group">
                    	<label>Amount Per Day</label> <input type="text" class="form-control" name="amount_per_day"
                         value="${existingRooms.amount_per_day}" >
                    </fieldset>
                    
                    <fieldset class="form-group">
                    	<label>Availability</label> <input type="text" class="form-control" name="availability"
                        value="${existingRooms.availability}" >
                    </fieldset>
                	       	
                    <button type="submit" class="btn btn-outline-success font-weight-bold" onclick="showAlert();">Save</button>
					<button type="button" class="btn btn-outline-danger font-weight-bold" onclick="history.back()">Cancel</button>
                    </form>
                    
			</div>
		</div>
	</div>
	
	<!-- get alert as successful -->
	<script>
		function showAlert() {
			alert('Room Details Successfully Updated');
		}
	</script>
            
    <!-- import site footer -->
	<jsp:include page="/View/Footer.jsp"></jsp:include>
</body>
</html>