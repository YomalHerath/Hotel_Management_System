<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*,java.sql.*" %>

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
  
</head>

<body>
	<!-- import site header -->
  	<jsp:include page="/View/Header.jsp"></jsp:include>
  	
  	<div class="container">
  	
  	<!-- get session and cookies -->
  	<%
  		//create the session
		if(session.getAttribute("id") == null){
			response.sendRedirect("Login.jsp");
		}

  		//get logged user's username as a cookie
		Cookie[] cookie = request.getCookies();
	
		out.println("<h3>"+cookie[0].getValue()+", Welcome To Hotel Management System Dashboard</h3>");
		out.println("<hr>");
		out.println("<br>");
	%>
	
	</div>

	<div class="container">
	
		<!-- get date and time from server -->
		<h5 align="right">Today's Date & Time:</h5> 
		<h4 align="right"><%= (new java.util.Date()).toLocaleString() %></h4>
		<br>
		
		<div class="row" style="padding-bottom:20px;">
		<!-- get available room count -->
		<div class="col-sm">
		<div class="card text-center font-weight-bold" style="width: 100%; height: 8rem; background-color: #EAFAF1;">
			<div class="card-body">
				<h4>Available Rooms</h4>
				<h3 style="color: #28B463;">
				<%
					try {
						//get database connection
						Class.forName("com.mysql.jdbc.Driver").newInstance();
						Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/hotel_management?useSSL=false","root","root");
						
						//create statment
						Statement st=con.createStatement();	
						//SQL query
						String strQuery = "SELECT COUNT(*) FROM rooms WHERE availability = 'Available' ";
						ResultSet rs = st.executeQuery(strQuery);
						String Count="";
					
						while(rs.next()){
							Count = rs.getString(1);
							out.print(Count);		
						}
					}
					catch (Exception e){
						e.printStackTrace();
					}
				%>
				</h3>
			</div>
		</div>
		</div>
		
		<!-- get reserved room count -->
		<div class="col-sm">
		<div class="card text-center font-weight-bold" style="width: 100%; height: 8rem; background-color: #FEF9E7;">
			<div class="card-body">
				<h4>Reserved Rooms</h4>
				<h3 style="color: #D4AC0D;">
				<%
					try {
						//get database connection
						Class.forName("com.mysql.jdbc.Driver").newInstance();
						Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/hotel_management?useSSL=false","root","root");
						
						//create statment
						Statement st=con.createStatement();	
						//SQL query
						String strQuery = "SELECT COUNT(*) FROM rooms WHERE availability = 'Reserved' ";
						ResultSet rs = st.executeQuery(strQuery);
						String Count="";
					
						while(rs.next()){
							Count = rs.getString(1);
							out.print(Count);		
						}
					}
					catch (Exception e){
						e.printStackTrace();
					}
				%>
				</h3>
			</div>
		</div>
		</div>
		
		<!-- get maintenance level room count -->
		<div class="col-sm">
		<div class="card text-center font-weight-bold" style="width: 100%; height: 8rem; background-color: #FDEDEC;">
			<div class="card-body">
				<h4>Maintenance Level Rooms</h4>
				<h3 style="color: #CB4335 ;">
				<%
					try {
						//get database connection
						Class.forName("com.mysql.jdbc.Driver").newInstance();
						Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/hotel_management?useSSL=false","root","root");
						
						//create statment
						Statement st=con.createStatement();	
						//SQL query
						String strQuery = "SELECT COUNT(*) FROM rooms WHERE availability = 'Unavailable' ";
						ResultSet rs = st.executeQuery(strQuery);
						String Count="";
					
						while(rs.next()){
							Count = rs.getString(1);
							out.print(Count);		
						}
					}
					catch (Exception e){
						e.printStackTrace();
					}
				%>
				</h3>
			</div>
		</div>
		</div>
		
		</div>
		
		<div class="row">
			<div class="col-4">
			
				<!-- create weather card -->
				<div class="card text-center font-weight-bold" id="weather_card" style="width: 100%; height: 100%;">
  					<div class="card-body">
  						<h2>Today's Weather Forecast</h2>
  						<h4><i class="fa fa-map-marker"></i>&nbsp;<span id="location"></span></h4>
						<h6 id="weather"></h6>
						<img src="" id="icon" style="width: 50%;">
						<h2><span id="temp"></span><sup>0</sup>C</h2>
						<br>
						<div>
							<button onClick="window.location.reload();" class="btn btn-info"><i class="fa fa-refresh"></i></button>	
						</div>
					</div>
				</div>
			</div>
			<div class="col-8">
			    <div class="card">
				      <img class="d-block" style="height: 28rem;" src="images/night-hotel.jpg" alt="First slide">
				</div>
			</div>
		</div>
		
	</div>
	
	<!-- get weather details with open weather map API -->
  	<script type="text/javascript">
  		link="http://api.openweathermap.org/data/2.5/weather?q=Colombo&appid=eae2b1b23a9e505cc54fce36db55bcc4";
  		
  		var request = new XMLHttpRequest();
  		request.open('GET',link,true);
  		
  		request.onload = function(){
  			var obj= JSON.parse(this.response);
  			console.log(obj);
  			document.getElementById('weather').innerHTML = obj.weather[0].description;
  			document.getElementById('location').innerHTML = obj.name;
  			document.getElementById('temp').innerHTML = obj.main.temp - 273.15;
  			document.getElementById('icon').src = "http://openweathermap.org/img/w/"+obj.weather[0].icon+".png";
  		}
  		if(request.status == 200){
  			console.log("ERROR");
  		}
  		request.send();
  	</script>
  	
  	<!-- import site footer -->
  	<jsp:include page="/View/Footer.jsp"></jsp:include>

</body>
</html>
