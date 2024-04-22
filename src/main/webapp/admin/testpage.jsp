<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<f:view>
	<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdn.datatables.net/2.0.0/css/dataTables.dataTables.css" />
  
<script src="https://cdn.datatables.net/2.0.0/js/dataTables.js"></script>
<title>JSP Page</title>

<style>
body {
	background-color: #f7f7f7;
	margin: 0px;
}

h2 {
	text-align: center;
}

.link-container {
	display: flex;
	justify-content: flex-start;
	align-items: center;
}

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

img {
	width: 70px;
	height: 100px;
}

table {
	width: 90%;
	border-collapse: collapse;
	margin: 0 auto;
}

th {
	text-align: center;
	background-color: #666;
	color: white;
	padding: 8px;
	border-bottom: 1px solid #ddd;
	cursor: pointer;
}

tr:hover {
	background-color: #f5f5f5;
}

tr:nth-child(even) {
	background-color: #e9e9e9;
}

td {
	text-align: center;
	padding: 8px;
	border-bottom: 1px solid #ddd;
}
</style>
<script>
	$(document).ready(function() {
		var cookieExists = checkCookie('admin');
		if (cookieExists) {
			console.log('Cookie exists!');
		} else {
			window.location.href = "../Login.jsf";
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
</head>
<body>
	<div class="link-container">
		<a class="previous back-link" href="AdminDashboard.jsf">&laquo;
			Back</a>
		<h2>
			<h:outputText value="Book Store" />
		</h2>
	</div>
	<h:form id="form">
		<h:dataTable id="productTable" value="#{booksImpl.viewBooks()}" var="book">
			<h:column>
				<f:facet name="header">
					<h:outputText value="Book Id" />
				</f:facet>
				<h:graphicImage value="#{book.bookUrl}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="Book Id" />
				</f:facet>
				<h:outputText value="#{book.bookId}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="Book Name" />
				</f:facet>
				<h:outputText value="#{book.bookName}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="Genre" />
				</f:facet>
				<h:outputText value="#{book.genre}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="Published Date" />
				</f:facet>
				<h:outputText
					value="#{book.publishedDate.toString().substring(0, 10)}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="Action" />
				</f:facet>
				<h:commandButton
					action="#{booksImpl.redirectToEditStock(book.bookId)}" value="Edit" />
			</h:column>
		</h:dataTable>
	</h:form>
<script>
	$(document).ready( function () {
    	$('#myTable').DataTable();
	});
</script>
</body>
	</html>
</f:view>