<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<f:view>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" href="style/header.css" />
<title>Insert title here</title>
	<style>
	body{
		margin: 0px;
	}
	img{
	    width: 80px;
	    height: 105px;
	}
	form{
		margin-top: 80px;
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
           
          </div>
        </div>
      </div>
     </header>
    <!-- Header End -->
    
	<div class="link-container">
	    <a class="previous back-link" id="back-btn">&laquo; Back</a>
	    <h2><h:outputText value="My Orders" /></h2>
	</div>
    
    <h:form>
   <%--  <h:dataTable id="productTable" value="#{orderImpl.showOrderItems()}" var="order" styleClass="grid-container">
        <h:column>
	        <f:facet name="header">
	            <h:outputText value="Image" />
	        </f:facet>
	        <h:graphicImage value="#{booksImpl.searchBooks(order.bookId).bookUrl}" />
        </h:column>
        <h:column>
	        <f:facet name="header">
	            <h:outputText value="Book Name" />
	        </f:facet>
	        <h:outputText value="#{booksImpl.searchBooks(order.bookId).bookName}" />
        </h:column>
        <h:column>
	        <f:facet name="header">
	            <h:outputText value="Order Date" />
	        </f:facet>
	        <h:outputText value="#{orderImpl.searchOrder(order.orderId).orderDate.toString()}" />
        </h:column>
        <h:column>
	        <f:facet name="header">
	            <h:outputText value="Status" />
	        </f:facet>
	        <h:outputText value="#{orderImpl.searchOrder(order.orderId).orderStatus}" />
        </h:column>
        <h:column>
	        <f:facet name="header">
	            <h:outputText value="Price" />
	        </f:facet>
	        <h:outputText value="#{order.price}" />
        </h:column>
    </h:dataTable> --%>
    
     <h:dataTable id="productTable" value="#{orderImpl.showOrderItems()}" var="order" styleClass="grid-container">
        <h:column>
	        <f:facet name="header">
	            <h:outputText value="Image" />
	        </f:facet>
	        <h:graphicImage value="#{booksImpl.searchBooks(order.bookId).bookUrl}" />
        </h:column>
        <h:column>
	        <f:facet name="header">
	            <h:outputText value="Book Name" />
	        </f:facet>
	        <h:outputText value="#{bookOrdered.bookName}" />
        </h:column>
        <h:column>
	        <f:facet name="header">
	            <h:outputText value="Order Date" />
	        </f:facet>
	        <h:outputText value="#{orderImpl.searchOrder(order.orderId).orderDate}" />
        </h:column>
        <h:column>
	        <f:facet name="header">
	            <h:outputText value="Status" />
	        </f:facet>
	        <h:outputText value="#{orderedFound.orderStatus}" />
        </h:column>
        <h:column>
	        <f:facet name="header">
	            <h:outputText value="Price" />
	        </f:facet>
	        <h:outputText value="#{order.price}" />
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
