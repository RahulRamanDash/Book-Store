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
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<!-- Bootstrap Table CSS -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-table/1.18.3/bootstrap-table.min.css">
<!-- Bootstrap JS -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
<!-- Bootstrap Table JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-table/1.18.3/bootstrap-table.min.js"></script>

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
.add-link {
	margin-left: 377px;
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
			window.location.href = "AdminLogin.jsf";
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
		<a class="previous back-link" href="AdminDashboard.jsf">&laquo; Back</a>
		<h2>
			<h:outputText value="Book Store" />
		</h2>
		<a class="add-link" href="AddStock.jsf">&#10010; Add Stock</a>
	</div>
	<h:form id="form">
		<h:dataTable id="productTable" value="#{booksImpl.viewBooks()}" var="book">
			<h:column>
				<f:facet name="header">
					<h:outputText value="Cover" />
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
    var thIndex = null,
        curThIndex = null,
        sortingOrder = 1; // 1 for ascending, -1 for descending

    $(function(){
        $('table thead tr th').click(function(){
            thIndex = $(this).index();
            if (thIndex != curThIndex) {
                curThIndex = thIndex;
                sortingOrder = 1; // Reset sorting order to ascending
            } else {
                sortingOrder *= -1; // Toggle sorting order
            }

            sorting = [];
            tbodyHtml = null;
            $('table tbody tr').each(function(){
                var value = $(this).children('td').eq(curThIndex).text().trim();
                sorting.push({ value: value, index: $(this).index() });
            });

            sorting.sort(function(a, b) {
                var aValue = a.value,
                    bValue = b.value;
                if (!isNaN(aValue) && !isNaN(bValue)) {
                    aValue = parseFloat(aValue);
                    bValue = parseFloat(bValue);
                }
                if (aValue === bValue) return 0;
                return (aValue > bValue ? 1 : -1) * sortingOrder;
            });

            sortIt();
        });
    });

    function sortIt(){
        for(var sortingIndex = 0; sortingIndex < sorting.length; sortingIndex++){
            rowId = sorting[sortingIndex].index;
            tbodyHtml = tbodyHtml + $('table tbody tr').eq(rowId)[0].outerHTML;
        }
        $('table tbody').html(tbodyHtml);

        // Change the arrow indicator based on sorting order
        var arrow = sortingOrder === 1 ? ' ▲' : ' ▼';
        $('table thead tr th').removeClass('sorted').find('span.arrow').remove();
        $('table thead tr th').eq(curThIndex).addClass('sorted').append('<span class="arrow">' + arrow + '</span>');
    }
</script>
</body>
	</html>
</f:view>