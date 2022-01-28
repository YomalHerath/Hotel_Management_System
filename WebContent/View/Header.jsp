<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>

<head>
	<meta charset="ISO-8859-1">
	<title>Header</title>
</head>

<body>
	
	<h1 class="display-4" align="center" style="font-weight: bold">
		<%= new String("Hotel Management System").toUpperCase()%>
	</h1>
	
	<nav class="navbar navbar-expand-lg navbar navbar-dark bg-dark font-weight-bold">
    <ul class="navbar-nav mr-auto mt-2 mt-lg-0">
      	<li class="nav-item">
        	<a class="nav-link" href="Home.jsp">Dashboard</a>
      	</li>
      	<li class="nav-item">
        	<a class="nav-link" href="RoomsServer">Room Details</a>
      	</li>
      	<li class="nav-item">
        	<a class="nav-link" href="AvailableRoomsControllerServlet">Available Rooms</a>
      	</li>
      	<li class="nav-item">
        	<a class="nav-link" href="ReservedRoomControllerSevlet">Reservation Details</a>
      	</li>
      	<li class="nav-item">
        	<a class="nav-link" href="Logout.jsp">Sign Out</a>
      	</li>
    </ul>
	</nav>
    <br>
    
</body>
</html>