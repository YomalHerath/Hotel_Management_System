<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.model.Rooms" %>
<!DOCTYPE html>
<html>
	<!-- get reserved room details with request -->
	<% Rooms reservedRooms = (Rooms) request.getAttribute("reservedRooms"); %>
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
			
	<!-- make new reservation form -->
	<div class="container col-md-4">
    	<div class="card">
        	<div class="card-body">
            			         	
            	<h2><b>Add New Reservation</b></h2>
                     	
                	<form action ="AvailableRoomsControllerServlet" name="reservation_form" method="POST">
            			<input type="hidden" name="action" value="/add" />
            			
            			<input type="hidden" name="id" value="${reservedRooms.room_no}">
            			<input type="hidden" name="room_category" value="${reservedRooms.category}">
                    	<input type="hidden" name="room_price" value="${reservedRooms.amount_per_day}"> 

                	<fieldset class="form-group">
                    	<label>Guest Name</label> <input type="text" class="form-control" name="guestName" >
                    </fieldset>

                	<fieldset class="form-group">
                    	<label>Contact Number</label> <input type="text" class="form-control" name="contact_no" >
                    </fieldset>

                	<fieldset class="form-group">
                    	<label>NIC Number</label> <input type="text" class="form-control" name="nic" >
                    </fieldset>
                	
                	<fieldset class="form-group">
                    	<label>Reserved Date</label> <input type="Date" class="form-control" name="reservedDate" >
                    </fieldset>
                    
                    <fieldset class="form-group">
                    	<label>Days of Stays</label> <input type="text" class="form-control" name="stayedDays" >
                    </fieldset>
                    
                    <fieldset class="form-group">
                    	<label>Availability</label> 
                    	<select class="custom-select" name="availability">
  							<option value="">Select</option>
  							<option value="Reserved">Reserved</option>
						</select>
                    </fieldset>
                	       	
                    <button type="submit" class="btn btn-outline-success font-weight-bold" onclick="return validate();">Save</button>
					<button type="button" class="btn btn-outline-danger font-weight-bold" onclick="history.back()">Cancel</button>
                    </form>
                    
			</div>
		</div>
	</div>
	
	<!-- validation for form fields -->
	<script>
		function validate() {
			var guestName = document.reservation_form.guestName.value;
			var contact_no = document.reservation_form.contact_no.value;
			var nic = document.reservation_form.nic.value;
			var availability = document.reservation_form.availability.value;
			var character = /[\W_]/;
			
			if(guestName == "" ){
    			alert("Please Enter Guest Name");
    			document.reservation_form.guestName.focus();
    			return false;
    		}
			if(contact_no == "" ){
    			alert("Please Enter Contact No");
    			document.reservation_form.contact_no.focus();
    			return false;
    		}
			if(nic == "" ){
    			alert("Please Enter NIC");
    			document.reservation_form.nic.focus();
    			return false;
    		}
			if(availability == "" ){
    			alert("Please Select Availability Status");
    			document.reservation_form.availability.focus();
    			return false;
    		}
			if(character.test(guestName)){
    			alert("Guest Name contains illigal character");
    			document.reservation_form.guestName.focus();
    			return false;
    		}
			if(character.test(contact_no)){
    			alert("Cotact No contains illigal character");
    			document.reservation_form.contact_no.focus();
    			return false;
    		}
			if(character.test(nic)){
    			alert("NIC contains illigal character");
    			document.reservation_form.nic.focus();
    			return false;
    		}
			else{
				alert('New Room Reservation Successfully Added');
				return true;
			}
			
		}
	</script>
	
    <!-- import site footer -->        
	<jsp:include page="/View/Footer.jsp"></jsp:include>
</body>
</html>