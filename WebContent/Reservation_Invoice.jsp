<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.model.Reservation" %>
<!DOCTYPE html>
<html>
	<!-- get reserved room details with request -->
	<% Reservation listReservedRooms = (Reservation) request.getAttribute("listReservedRooms"); %>
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

	<!-- Create Invoice view -->
	<div class="container">
		<div class="my-2">
  			<h3><b>Room Reservation Invoice</b></h3>
		</div>

	<div class="my-3" id="printarea">
  		<div class="card">
    		<div class="card-body" style="margin:20px">

      		<div class="row">

        	<div class="col">
          		<div style="font-size: 5rem;">
            		<i class="fa fa-user"></i>
          		</div>
        	</div>

        	<div class="col">
        	<table>
            	<tr>
              		<th>Guest Name</th>
              		<td>&nbsp;<c:out value="${listReservedRooms.guest_name}" /></td>
            	</tr>
            	<tr>
              		<th>Contact Number</th>
              		<td>&nbsp;<c:out value="${listReservedRooms.contact_no}" /></td>
            	</tr>
            	<tr>
              		<th>NIC Number</th>
              		<td>&nbsp;<c:out value="${listReservedRooms.nic}" /></td>
            	</tr>
        	</table>
        	</div>

	        <div class="col">
    	    <table>
            	<tr>
                	<th>Room Category</th>
                	<td>&nbsp;<c:out value="${listReservedRooms.room_category}" /></td>
              	</tr>
              	<tr>
                	<th>Reserved Date</th>
                	<td>&nbsp;<c:out value="${listReservedRooms.reserved_date}" /></td>
              	</tr>
              	<tr>
                	<th>Number of Stayed Days</th>
                	<td>&nbsp;<c:out value="${listReservedRooms.stayed_day}" /></td>
            	</tr>
        	</table>
        	</div>

      		<table class="table table-bordered">
       	 		<thead class="text-white bg-dark">
        			<tr>
          				<th scope="col">#</th>
          				<th scope="col">Room Detail</th>
         	 			<th scope="col">Amount Per Day</th>
          				<th scope="col">Days of Stay</th>
        			</tr>
       		 	</thead>
        		<tbody>
        			<tr>
          				<th scope="row">#</th>
          				<th><c:out value="${listReservedRooms.room_category}" /></th>
          				<th><c:out value="${listReservedRooms.room_price}" /></th>
          				<th><c:out value="${listReservedRooms.stayed_day}" /></th>
        			</tr>
        		</tbody>
      		</table>
      		
  			</div>
  			
  			</div>
		</div>
	</div>
	 		<button type="submit" class="btn btn-primary font-weight-bold" onClick="setDivPrint()">Print</button>&nbsp;
			<button type="submit" class="btn btn-danger font-weight-bold" onclick="history.back()">Back</button>
	</div>
	
	<!-- make print view with button click -->
	<script>
	function setDivPrint(val){
		var printdata=document.getElementById('printarea').innerHTML;
		var srcOriginalContent=document.body.innerHTML;
		document.body.innerHTML=printdata;
		window.print();
		document.body.innerHTML=srcOrigionalContent;
	}
	</script>

	<!-- import site footer -->
	<jsp:include page="/View/Footer.jsp"></jsp:include>
</body>
</html>