<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<f:view>
	<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" href="style/header.css" />
<link rel="stylesheet" href="style/profile.css" />
<title>JSP Page</title>

<style>
body{
	margin: 0px;
	}
	h2{
text-align: center;
}
 .link-container {
		position: relative;
    	top: 55px;
        display: flex; /* Use flexbox */
        justify-content: flex-start; /* Align items to the start of the container */
        align-items: center; /* Center the content vertically */
    }

    /* Style for the <a> tag */
    .back-link {
    	cursor: pointer;
        margin-right: 38%;
		margin-left: 19px;
    }
    .previous {
  background-color: #f1f1f1;
  color: black;
}
a {
  text-decoration: none;
  display: inline-block;
  padding: 8px 16px;
}

</style>
</head>
<body>
<h:form id="form">

	    <script>
        $(document).ready(function() {

        	var cookieExists = checkCookie('username');
        	if (cookieExists) {
        	    console.log('Cookie exists!');
        	} else {
        		window.location.href = "Login.jsf";
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

  <!-- Header Start -->
    <header class="site-header">
      <div class="site-header__top">
        <div class="wrapper site-header__wrapper">
          
          <div class="site-header__middle">
            <a href="#" class="brand">Book Store</a>
          </div>
          <div class="site-header__end bottom">
           
          </div>
        </div>
      </div>
     </header>
    <!-- Header End -->

<div class="link-container">
    <a class="previous back-link" id="back-btn">&laquo; Back</a>
    <h2><h:outputText value="Profile" /></h2>
</div>


	<div class="page-content page-container" id="page-content">
		<div class="padding">
			<div class="row container d-flex justify-content-center">
				<div class="col-xl-6 col-md-12">
					<div class="card user-card-full">
						<div class="row m-l-0 m-r-0">
							<div class="col-sm-4 bg-c-lite-green user-profile">
								<div class="card-block text-center text-white">
									<div class="m-b-25">
										<img src="https://img.icons8.com/bubbles/100/000000/user.png"
											class="img-radius" alt="User-Profile-Image">
									</div>
									<h2 class="f-w-600">Rahul Raman</h2>
									<h:commandLink action="#{loginImpl.logout()}" value="logout"/>
									<i
										class=" mdi mdi-square-edit-outline feather icon-edit m-t-10 f-16"></i>
								</div>
							</div>
							<div class="col-sm-8">
								<div class="card-block">
								<%-- 	<div class="row">
										<div class="col-sm-6">
											<p class="m-b-10 f-w-600">Phone</p>
											<h6 class="text-muted f-w-400">98979989898</h6>
										</div>
									</div> --%>
								<div class="row">
									<div class="col-sm-6">
										<h:outputLabel styleClass="m-b-10 f-w-600" value="Email : " />
										<h:inputText value="#{loggedUser.email}" />
									</div>
									<div class="col-sm-6">
										<h:outputLabel styleClass="m-b-10 f-w-600" value="UserName : " />
										<h:inputText value="#{loggedUser.username}" />
									</div>
								</div>	
								
									
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

</h:form>
	<script>
		$(document).ready(function() {
			$('#back-btn').click(function() {
				parent.history.back();
				return false;
			});
		});
	</script>

</body>
	</html>
</f:view>