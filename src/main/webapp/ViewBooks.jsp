<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<f:view>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<link rel="stylesheet" href="style/header.css" />
	<title>JSP Page</title>

	<style>
	body{
		margin: 0px;
	}
	
.container{
	display: flex;
    justify-content: center;
    height: 100vh; /* Ensure full viewport height */
    margin: 0; /* Remove default margins */
    padding: 0; /* Remove default padding */
}
.ui-panelgrid {
    display: flex;
    flex-direction: column;
    align-items: center; /* Center items horizontally */
}

/* Define grid container */
.grid-container {
    display: flex;
    flex-wrap: wrap; /* Allow items to wrap to next row */
    justify-content: center; /* Center items horizontally */
}
/* Style for grid items */
.grid-item {
    background-color: #C9DAEA;
    width: 247px; /* 190px */
    border: 1px solid #ccc;
    padding: 10px;
    margin: 10px;
    text-align: center;
    cursor: pointer;
    flex: 1 0 calc(33.33% - 20px);
    position: relative; /* Ensure position context for absolute positioning */
}

/* Hover effect for grid items */
.grid-item:hover {
    background-color: #f0f0f0;
}

/* Style for the image */
.grid-item #image {
    top: 10px;
    margin-bottom: 5px;
    position: relative;
}

/* Hover effect for the image */
.grid-item:hover #image img {
    transform: scale(1.1); /* Scale the image up on hover */
    transition: transform 0.3s ease; /* Add smooth transition effect */
}
.site-header__top {
    padding: 10px;
}
a{
	color: black;
}
tr{
	display: inline;
}
h2{
text-align: center;
}
img{
	width: 150px;
    height: 200px;
}
/* Style for buttons */
.button {
    background-color: black;
    border: none;
    color: white;
    padding: 10px 20px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
    margin: 4px 2px;
    cursor: pointer;
    width: 119px;
}

.button:hover {
    background-color: #45a049;
}

.sucess-box {
	position: relative;
	text-align: center;
}
ul {
	margin-right: 35px;
  	list-style-type: none;
}
.close-button {
	position: relative;
	top: -34px;
	right: 16px;
	color: black;
	cursor: pointer;
	float: right;
}
.main-container{
	position: absolute;
    top: 65px;
}

.dropbtn {
  background-color: #3498DB;
  color: white;
  padding: 16px;
  font-size: 16px;
  border: none;
  cursor: pointer;
}

.dropbtn:hover, .dropbtn:focus {
  background-color: #2980B9;
}

.dropdown {
  position: relative;
  display: inline-block;
}

.dropdown-content {
  display: none;
  position: absolute;
  right: 0px;
  top: 68px;
  background-color: #f1f1f1;
  min-width: 160px;
  overflow: auto;
  box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
  z-index: 1;
}

.dropdown-content a {
  color: black;
  padding: 12px 16px;
  text-decoration: none;
  display: block;
}

.dropdown a:hover {background-color: #ddd;}

.show {display: block;}

	</style>
</head>
<body>
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
            <a href="MyCart.jsf" class="cart">
            <svg version="1.1" viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
				  <g>
				    <title>Cart</title>
				    <path fill="white" d="m95.398 23.699c-1.8008-2.3008-4.6016-3.6992-7.5-3.6992h-60.898l-1.8984-7.3984c-1.1016-4.3008-4.8984-7.3008-9.3008-7.3008h-10.199c-1.6992 0-3.1016 1.3984-3.1016 3.1016 0 1.6992 1.3984 3.1016 3.1016 3.1016h10.199c1.5 0 2.8008 1 3.1992 2.5l12.199 48.602c1.1016 4.3008 4.8984 7.3008 9.3008 7.3008h39.898c4.3984 0 8.3008-3 9.3008-7.3008l7.5-30.801c0.69922-2.8047 0.10156-5.8047-1.8008-8.1055zm-4.2969 6.6992-7.5 30.801c-0.39844 1.5-1.6992 2.5-3.1992 2.5h-39.902c-1.5 0-2.8008-1-3.1992-2.5l-8.6992-34.898h59.301c1 0 2 0.5 2.6016 1.3008 0.59766 0.79688 0.89453 1.7969 0.59766 2.7969z"/>
				    <path fill="white" d="m42.602 73.898c-5.6992 0-10.398 4.6992-10.398 10.398s4.6992 10.398 10.398 10.398c5.6992 0.003907 10.398-4.6953 10.398-10.395s-4.6992-10.402-10.398-10.402zm0 14.5c-2.3008 0-4.1016-1.8008-4.1016-4.1016s1.8008-4.1016 4.1016-4.1016c2.3008 0 4.1016 1.8008 4.1016 4.1016-0.003906 2.2031-1.9023 4.1016-4.1016 4.1016z"/>
				    <path fill="white" d="m77 73.898c-5.6992 0-10.398 4.6992-10.398 10.398s4.6992 10.398 10.398 10.398 10.398-4.6992 10.398-10.398c-0.097657-5.6953-4.6992-10.398-10.398-10.398zm0 14.5c-2.3008 0-4.1016-1.8008-4.1016-4.1016s1.8008-4.1016 4.1016-4.1016 4.1016 1.8008 4.1016 4.1016c0 2.2031-1.9023 4.1016-4.1016 4.1016z"/>
				  </g>
			</svg>
              
            </a>
            <a id="user-icon">
              <svg version="1.1" viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
                <title>Profile</title>
                <path fill="white"
                  d="m65.57 52.5c6.9336-4.5078 11.574-11.797 12.723-19.988 1.1484-8.1875-1.3047-16.473-6.7344-22.715-5.4258-6.2422-13.289-9.8242-21.559-9.8242s-16.133 3.582-21.559 9.8242c-5.4297 6.2422-7.8828 14.527-6.7344 22.715 1.1484 8.1914 5.7891 15.48 12.723 19.988-10.012 3.2812-18.73 9.6406-24.914 18.172-6.1836 8.5273-9.5117 18.793-9.5156 29.328h7.1445c0-15.312 8.168-29.461 21.426-37.117 13.262-7.6523 29.598-7.6523 42.859 0 13.258 7.6562 21.426 21.805 21.426 37.117h7.1445c-0.003906-10.535-3.332-20.801-9.5156-29.328-6.1836-8.5312-14.902-14.891-24.914-18.172zm-37-23.93c0-5.6836 2.2578-11.133 6.2773-15.152 4.0195-4.0156 9.4688-6.2734 15.152-6.2734s11.133 2.2578 15.152 6.2734c4.0195 4.0195 6.2773 9.4688 6.2773 15.152 0 5.6836-2.2578 11.137-6.2773 15.152-4.0195 4.0195-9.4688 6.2773-15.152 6.2773s-11.133-2.2578-15.152-6.2773c-4.0195-4.0156-6.2773-9.4688-6.2773-15.152z"
                />
              </svg>
            </a>
          </div>
        </div>
      </div>
     </header>
			
	<div id="myDropdown" class="dropdown-content">
		<a href="Profile.jsf">My Profole</a>
		<a href="Orders.jsf">My Orders</a>
	</div>
    <!-- Header End -->
    

<div class="main-container">
	<div Class="sucess-box" id="manageBox">
		<h:messages id="manageMsg" />
		<h:outputText value="#{orderMsg}" />
	</div>
	<h2>
		<h:outputText value="Book Store" />
	</h2>
<div class="container">
<h:form>
<h:panelGrid columns="1">
    <h:dataTable id="productTable" value="#{booksImpl.viewBooks()}" var="product" styleClass="grid-container">
        <h:column>
            <div class="grid-item" id="product">
                <!-- Display product information here -->
        <h:commandLink action="#{booksImpl.showBookDetail(product.bookId)}">
                <div id="image">
                	<h:graphicImage value="#{product.bookUrl}" />
                </div>
                <br/>
                <div>
                	<b>Name : </b>
	                <h:outputText value="#{product.bookName}" />
                </div>
                <div>
                	<b>Price : &#8377;</b>
	    	        <h:outputText value="#{product.price}" />
                </div>
                
        </h:commandLink>
                <div>
                	<h:commandButton action="#{booksImpl.buyOneBook(product.bookId)}" value="Buy" styleClass="button"/>
                	<h:commandButton action="#{cartImpl.addToCart(product.bookId)}" value="Add to Cart" styleClass="button"/>
                </div>
                
            </div>
        </h:column>
    </h:dataTable>
</h:panelGrid>
</h:form>
</div>
	</div>
<script>
function closeMessage() {
	var manageBox = document.getElementById('manageBox');
	manageBox.style.display = 'none';
}
setTimeout(closeMessage, 5000);

</script>


<script>
$(document).ready(function() {
    $(window).on('beforeunload', function() {
        $("#myDropdown").hide();
    });

    $("#user-icon").click(function(){
        $("#myDropdown").toggle();
    });

    // Close dropdown when clicking outside of it
    $(document).click(function(event) { 
        if(!$(event.target).closest('#user-icon').length) {
            $("#myDropdown").hide();
        }        
    });

    // Prevent closing dropdown when clicking inside it
    $('#myDropdown').click(function(event){
        event.stopPropagation();
    });
    
});
</script>
</body>
</html>
</f:view>