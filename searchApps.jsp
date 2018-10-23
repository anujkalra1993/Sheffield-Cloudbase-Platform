<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Search for Apps</title>
<link rel="stylesheet" href="css/w3.css"/>
</head>
<body class="w3-content">
	<%@include file="header.html" %>
	<jsp:include page="menu.jsp"/>
	<section class="w3-container">
		<form class="w3-form" action="<!-- searchApps -->" method="post">
			<label>Enter Search String: </label>
			<input type="search" name="searchString"/>
			<input type="submit" value="Search"/>
		</form>
	</section>
	<%@include file="footer.html" %>
</body>
</html>