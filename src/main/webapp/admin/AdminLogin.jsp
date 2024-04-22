<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<f:view>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style>

@import url(https://fonts.googleapis.com/css?family=Roboto:300);

.login-page {
  width: 360px;
  margin: auto;
}
.form {
  position: relative;
  z-index: 1;
  background: #FFFFFF;
  max-width: 360px;
  margin: 0 auto 100px;
  padding: 45px;
  box-shadow: 0 0 20px 0 rgba(0, 0, 0, 0.2), 0 5px 5px 0 rgba(0, 0, 0, 0.24);
}
.form .input {
  font-family: "Roboto", sans-serif;
  outline: 0;
  background: #f2f2f2;
  width: 100%;
  border: 0;
  margin: 0 0 15px;
  padding: 15px;
  box-sizing: border-box;
  font-size: 14px;
}
.login {
  font-family: "Roboto", sans-serif;
  text-transform: uppercase;
  outline: 0;
  background: #4CAF50;
  width: 100%;
  border: 0;
  padding: 15px;
  color: #FFFFFF;
  font-size: 14px;
  -webkit-transition: all 0.3 ease;
  transition: all 0.3 ease;
  cursor: pointer;
}
.login:hover, .login:focus {
  background: #43A047;
}
.form .message {
  margin: 15px 0 0;
  color: #b3b3b3;
  font-size: 12px;
}
.form .message a {
  color: #4CAF50;
  text-decoration: none;
}
.form .register-form {
  display: none;
}
.container {
  position: relative;
  z-index: 1;
  max-width: 300px;
  margin: 0 auto;
}
.container:before, .container:after {
  content: "";
  display: block;
  clear: both;
}
.container .info {
  margin: 50px auto;
  text-align: center;
}
.container .info h1 {
  margin: 0 0 15px;
  padding: 0;
  font-size: 36px;
  font-weight: 300;
  color: #1a1a1a;
}
.container .info span {
  color: #4d4d4d;
  font-size: 12px;
}
.container .info span a {
  color: #000000;
  text-decoration: none;
}
.container .info span .fa {
  color: #EF3B3A;
}
body {
background-color: darkslategray;
  font-family: "Roboto", sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;      
}
.heading-div{
	font-size: 30px;
	text-align: center;
	position: relative;
	top: 20px;
	color: white;	
 }
</style>

</head>
<body>

<script>
	$(document).ready(function() {
		var cookieExists = checkCookie('admin');
		if (cookieExists) {
			console.log('Cookie exists!');
			window.location.href = "AdminDashboard.jsf";
		} else {
			console.log('Cookie does not exist!');
		}

		function checkCookie(cookieName) {
			var cookies = document.cookie.split(';');
			for (var i = 0; i < cookies.length; i++) {
				var cookie = cookies[i].trim();
				if (cookie.startsWith(cookieName + '=')) {
					var cookieValue = cookie.substring(cookieName.length + 1);
					var cookieExpiration = new Date(cookieValue);
					if (cookieExpiration && cookieExpiration < new Date()) {
						return false;
					}
					return true;
				}
			}
			return false;
		}
	});
</script>

<div class="heading-div">
	<h2>Book Store</h2>
</div>

<div class="login-page">
  <div class="form">
    <h:form styleClass="login-form" id="form">
    <h:outputLabel value="UserName : " />
    <h:inputText value="#{user.username}" styleClass="input"/>
    <h:outputLabel value="Password : " />
    <h:inputText value="#{user.password}" styleClass="input"/>
    <h:commandButton action="#{loginImpl.authenticateAdmin(user)}" value="login" 
      		id="login" styleClass="login"/>
      <p class="message">Not registered? <a href="Register.jsf">Create an account</a></p>
      <br/>
      <h:message for="login"/>
    </h:form>
  </div>
</div>

</body>
</html>
</f:view>