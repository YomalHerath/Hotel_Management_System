<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

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

<body class=login_form>

	<!-- import  site header -->
 	<jsp:include page="/View/Signed_Header.jsp"></jsp:include>

  	<div class="container">
  
    <div class="row px-3">
      <div class="col-lg-10 col-xl-7 card flex-row mx-auto px-0">
        <div class="img-left d-none d-md-flex"></div>

		<!-- login form -->
        <div class="card-body">
          
	    	<h4 class="title text-center mt-5"><b>SIGN IN</b></h4>  
	        <form action ="EmployeeServer" name="login_form" method="POST">
	        	<input type="hidden" name="action" value="list" />
	
	            <div class="form-input">
	            	<span><i class="fa fa-user-circle"></i></span>
	              	<input type="text" name="Username" placeholder="Username">
	            </div>
	            
	            <div class="form-input">
	            	<span><i class="fa fa-key"></i></span>
	              	<input type="password" name="Password" placeholder="Password">
	            </div>
	
	            <div class="form-box mb-3">
	            	<button type="submit" onClick="return validate();" class="btn btn-block text-uppercase font-weight-bold">Sign In</button>
		        	<br>
	    			<p class="font-italic text-center">If you don't have account &nbsp; <a href="Register.jsp">Sign Up</a></p>
	        	</div>
	
			</form>
        </div>      
        
        </div>
      </div>
    </div>
    
    <!-- validation for login form field with onClick method -->
    <script>
    	function validate(){
    		var uname = document.login_form.Username.value;
    		var pass = document.login_form.Password.value;
    		var character = /[\W_]/;
    		
    		if(uname == ""){
    			alert("Please Enter Username");
    			document.login_form.Username.focus();
    			return false;
    		}
    		if((uname.length < 1) || (uname.length > 10)){
    			alert("Username is of Invalid Length");
    			document.login_form.Username.focus();
    			return false;
    		}
    		
    		if(pass == ""){
    			alert("Please Enter Password");
    			document.login_form.Password.focus();
    			return false;
    		}
    		if((pass.length < 1) || (pass.length > 15)){
    			alert("Password is of Invalid Length");
    			document.login_form.Password.focus();
    			return false;
    		}
    		if(character.test(pass)){
    			alert("Password contains illigal character");
    			document.login_form.Password.focus();
    			return false;
    		}
    	}
    </script>
    
    <!-- import site footer -->
  	<jsp:include page="/View/Footer.jsp"></jsp:include>

</body>

</html>
