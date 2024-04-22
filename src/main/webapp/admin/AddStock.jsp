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
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css">
<title>JSP Page</title>

<style>
body{
	margin: 0px;
	    background-color: #f7f7f7;
	}
	h2{
text-align: center;
}
img{
	height: 293px;
}
 .link-container {
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
.container {
  	margin-top:30px;
	display: flex;
}
.form-container {
  min-width: 772px;
  margin-left: 45px;
}
label {
	font-size:1em;
	font-weight:600;
	text-transform:uppercase;
}
span {
	font-weight:600;
}
.divshow {
	border:3px solid #333;
	border-radius:10px;
	padding:20px;
	margin:20px;
}
*, ::after, ::before {
    box-sizing: unset; !important
}

#preview-container {
	margin-bottom: 20px;
    border: 1px solid #ccc;
    padding: 10px;
    display: inline-block;
}

#preview {
	max-width: 300px;
    max-height: 300px;
}

.file-upload {
	margin-top: 10px;
}  
</style>
</head>
<body>

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
<script type="text/javascript">
        function previewImage(input) {
            var preview = document.getElementById('preview');
            var file = input.files[0];
            var reader = new FileReader();

            reader.onload = function (e) {
                preview.src = e.target.result;
            };

            reader.readAsDataURL(file);
        }
</script>

<div class="link-container">
    <a class="previous back-link" href="ViewBooks.jsf">&laquo; Back</a>
    <h2>Edit Book Details</h2>
</div>

<h:form enctype="multipart/form-data">
<div class="container">

<div id="preview-container">
    <img id="preview" src="#" alt="Preview Image">
	
	<div class="file-upload">
	    <h:inputFile value="#{fileBean.file}" onchange="previewImage(this)"></h:inputFile>
	</div>
</div>

	
	

  <div class="form-container">
	    <div class="form-group row">
	      <h:outputLabel value="Book Name : " styleClass="col-sm-2 col-form-label"/>
	      <div class="col-sm-5">
	       <h:inputText value="#{books.bookName}" styleClass="form-control"/>
	      </div>
	    </div>
	    <div class="form-group row">
	     <h:outputLabel value="Author Name : " styleClass="col-sm-2 col-form-label"/>
	      <div class="col-sm-5">
	        <h:inputText value="#{books.authorName}" styleClass="form-control"/>
	      </div>
	    </div>
	    <div class="form-group row">
	       <h:outputLabel value="Genre : " styleClass="col-sm-2 col-form-label"/>
	      <div class="col-sm-5">
		    <h:inputText value="#{books.genre}" styleClass="form-control"/>
	      </div>
	    </div>
	    <div class="form-group row">
	       <h:outputLabel value="Published Date : " styleClass="col-sm-2 col-form-label"/>
	      <div class="col-sm-5">
		    <h:inputText value="#{books.publishedDate}" styleClass="form-control">
		   <f:convertDateTime pattern = "yyyy-mm-dd" />
		    </h:inputText>
	      </div>
	    </div>
	    <div class="form-group row">
		   <h:outputLabel value="Price : " styleClass="col-sm-2 col-form-label"/>
	      <div class="col-sm-5">
		    <h:inputText value="#{books.price}" styleClass="form-control"/>
	      </div>
	    </div>
	    <h:commandButton action="#{booksImpl.AddBookDetail(books, fileBean.file)}" value="Add Stock" styleClass="btn btn-warning"/>
	    <%-- <h:commandButton action="" value="Reset" styleClass="btn btn-success"/> --%>
  </div>
</div>
  </h:form>
</body>
	</html>
</f:view>