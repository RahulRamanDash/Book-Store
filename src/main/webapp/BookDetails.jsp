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
<title>JSP Page</title>

<style>
body{
    margin: 0px;
    }
.container {
	display: flex;
	padding: 0;
	margin-left: 50px;
	font-size: 20px;
}

.grid-item {
	font-style: oblique;
	margin-top: 25px;
	margin-left: 50px;
}

h2 {
	text-align: center;
}

img {
	width: 300px;
	height: 400px;
}
/* Style for buttons */
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
	width: 119px;
}

.button:hover {
	background-color: #45a049;
}

.button-container {
	margin-top: 30px;
}

.sucess-box {
	position: relative;
	text-align: center;
}

ul {
	margin-right: 35px;
	list-style-type: none;
}

.link-container {
	margin-top: 80px;
	display: flex; /* Use flexbox */
	justify-content: flex-start;
	/* Align items to the start of the container */
	align-items: center; /* Center the content vertically */
}

.back-link {
	cursor: pointer;
	margin-right: 38%;
	margin-left: 19px;
}

.med-font {
	margin-top: 35px;
	font-size: 30px;
}

.item {
	padding: 6px;
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

	<h:inputText value="#{successMsg}" id="sucessInput"
		style="display: none;" />
	<div Class="sucess-box" id="manageBox">
		<h:messages id="manageMsg" />
		<!-- <span class="close-button" onclick="closeMessage()">X</span> -->
	</div>

	<div class="link-container">
		<a class="previous back-link" id="back-btn">&laquo; Back</a>
		<h2>
			<h:outputText value="Book Details" />
		</h2>
	</div>
	<h:form>
		<div class="container">
			<div id="image">
				<h:graphicImage value="#{bookFound.bookUrl}" />
			</div>

			<div class="grid-item" id="product">
				<div class="item">
					Name : <b> <h:outputText value="#{bookFound.bookName}" />
					</b>
				</div>
				<div class="item">
					Author : <b> <h:outputText value="#{bookFound.authorName}" />
					</b>
				</div>
				<div class="item">
					Genre : <b> <h:outputText value="#{bookFound.genre}" />
					</b>
				</div>
				<div class="item">
					PublishedDate : <b> <h:outputText
							value="#{bookFound.publishedDate}">
							<f:convertDateTime pattern="yyyy-MM-dd" />
						</h:outputText>
					</b>
				</div>
				<div class="item">
					Description : <b> <h:outputText
							value="#{bookFound.description}" />
					</b>
				</div>

				<div class="med-font item">
					Price : <b> &#8377; <h:outputText value="#{bookFound.price}" />
					</b>
				</div>

				<div class="button-container">
					<h:commandButton action="#{booksImpl.buyOneBook(bookFound.bookId)}" value="Buy"
						styleClass="button" />
					<h:commandButton action="#{cartImpl.addToCart(bookFound.bookId)}"
						value="Add to Cart" styleClass="button" />
				</div>
			</div>
		</div>
	</h:form>

	<script>
		function closeMessage() {
			var manageBox = document.getElementById('manageBox');
			manageBox.style.display = 'none';
		}
		setTimeout(closeMessage, 3000);
	</script>
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