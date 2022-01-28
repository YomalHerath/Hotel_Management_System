<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>

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
			
	<!-- add new book form -->
	<div class="container col-md-4">
    	<div class="card">
        	<div class="card-body">
            			         	
            	<h2><b>Add New Room</b></h2>
                     	
                	<form action="RoomsServer" name="add_room_form" method="POST">
            			<input type="hidden" name="action" value="/insert" />
	
                	<fieldset class="form-group">
                    	<label>Room Number</label> <input type="text" class="form-control" name="room_no" >
                    </fieldset>
                	
                	<fieldset class="form-group">
                    	<label>Category</label>
                        <select class="custom-select" name="category">
  							<option value="">Select</option>
							<option value="Single Room">Single Room</option>
  							<option value="Double Room">Double Room</option>
						</select>
                    </fieldset>
                    
                    <fieldset class="form-group">
                    	<label>Amount Per Day</label> <input type="text" class="form-control" name="amount_per_day">
                    </fieldset>
                    
                    <fieldset class="form-group">
                    	<label>Availability</label> 
                    	<select class="custom-select" name="availability">
  							<option value="">Select</option>
							<option value="Available">Available</option>
  							<option value="Unavailable">Unavailable</option>
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
			var rno = document.add_room_form.room_no.value;
			var category = document.add_room_form.category.value;
			var amount = document.add_room_form.amount_per_day.value;
			var availability = document.add_room_form.availability.value;
			var character = /[\W_]/;
			
			if(rno == "" ){
    			alert("Please Enter Room No");
    			document.add_room_form.room_no.focus();
    			return false;
    		}
			if(category == "" ){
    			alert("Please Enter Cateory Field");
    			document.add_room_form.room_no.focus();
    			return false;
    		}
			if(amount == "" ){
    			alert("Please Enter Amot Per Day");
    			document.add_room_form.room_no.focus();
    			return false;
    		}
			if(availability == "" ){
    			alert("Please Enter Availaility");
    			document.add_room_form.room_no.focus();
    			return false;
    		}
			if(character.test(rno)){
    			alert("Room No contains illigal character");
    			document.add_room_form.room_no.focus();
    			return false;
    		}
			if(character.test(amount)){
    			alert("Amount Per Day contains illigal character");
    			document.add_room_form.amount_per_day.focus();
    			return false;
    		}
			else{
				alert('New Room Successfully Added');
				return true;
			}
			
		}
	</script>
            
    <!-- import site footer -->
	<jsp:include page="/View/Footer.jsp"></jsp:include>
</body>
</html>