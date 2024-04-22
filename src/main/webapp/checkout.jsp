<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<f:view>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="style/header.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<title>Insert title here</title>
	<style>
	body{
	    margin: 0px;
	}
	form{
		margin-top: 80px;
	}
	img{
	    width: 80px;
	    height: 105px;
	}
	table{
		text-align: center;
		width: 70%;
		border-collapse: collapse; /* Collapse borders */
		margin: 0 auto; /* Center the table */
	}
	tr:nth-child(even) {
	    background-color: #f2f2f2; /* Alternate row background color */
	}
	td, th {
		padding: 8px;
		border-bottom: 1px solid #ddd; /* Add bottom border to cells */
	}
	th {
		background-color: #f2f2f2; /* Header background color */
	}
	
h2{
	text-align: center;
}

.button-container {
		display: flex;
		justify-content: space-evenly;
	}
	.buy-button {
		background: none;
		border: none;
		font-size: 16px;
		cursor: pointer;
	}
	.buy-button:hover {
		color: red; /* Change color on hover */
	}
	.remove-button {
		background: none;
		border: none;
		font-size: 16px;
		cursor: pointer;
	}
	.remove-button:hover {
		color: red; /* Change color on hover */
	}
	
	.right-block{
		background-color: #ECEBF3;
		height: 100%;
		width: 30%;
		float: right;
		padding: 20px; /* Add padding */
		box-sizing: border-box;
	}
	.show-price{
		font-size: 20px;
		float: right;
	}
	
.button {
    background-color: #4CAF50;
    border: none;
    color: white;
    padding: 10px 20px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
    margin: 4px 2px;
    cursor: pointer;
    width: 100%;
}

.button:hover {
    background-color: #45a049;
}
	 .link-container {
	 	position: relative;
    	top: 80px;
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
    .sucess-box {
	position: relative;
	text-align: center;
}
ul {
	margin-right: 35px;
  	list-style-type: none;
}

a {
  text-decoration: none;
  display: inline-block;
  padding: 8px 16px;
}
.previous {
  background-color: #f1f1f1;
  color: black;
}

.next {
  background-color: #04AA6D;
  color: white;
}

.round {
  border-radius: 50%;
}

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
           
          </div>
        </div>
      </div>
     </header>
    <!-- Header End -->

<div class="link-container">
	<a class="previous back-link" id="back-btn">&laquo; Back</a>
    <h2><h:outputText value="Place Order" /></h2>
</div>
    
    
    <h:form>
    <div Class="sucess-box" id="manageBox">
		<h:messages id="orderMsg" />
	</div>
    
        <div class="right-block">
    	<br/>
    	<div class="show-price">
    		<h:outputText value="Total Price : #{totalPrice} Rs" />
    	</div>
    	
    	<br/><br/>
    	<div>
			<h:commandButton action="#{orderImpl.placeOrder(bookFound)}" value="Confirm Order" styleClass="button"/>
        </div>
    </div>
    
    <h:dataTable id="productTable" value="#{bookFound}" var="item" styleClass="grid-container">
        <h:column>
	        <f:facet name="header">
	            <h:outputText value="Image" />
	        </f:facet>
	        <h:graphicImage value="#{item.bookUrl}" />
        </h:column>
        <h:column>
	        <f:facet name="header">
	            <h:outputText value="Book Name" />
	        </f:facet>
	        <h:outputText value="#{item.bookName}" />
        </h:column>
        <h:column>
	        <f:facet name="header">
	            <h:outputText value="Book Id" />
	        </f:facet>
	        <h:outputText value="#{item.bookId}" />
        </h:column>
        <h:column>
	        <f:facet name="header">
	            <h:outputText value="Price" />
	        </f:facet>
	        <h:outputText value="#{item.price}" />
        </h:column>                
    </h:dataTable>
    </h:form>
    <script>
    $(document).ready(function(){
        $('#back-btn').click(function(){
            parent.history.back();
            return false;
        });
    });
    </script>
</body>
</html>
</f:view>
