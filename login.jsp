<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Member Login</title>
<link rel="stylesheet" href="css/w3.css" />
</head>
<body class="w3-content">
	<%@include file="header.html"%>
	<%@include file="menu.jsp"%>

	<div class="w3-card">
		<div class="w3-container w3-pale-red">
			<h2>Members Login</h2>
		</div>
		<%session.invalidate();%>
		<form class="w3-container" action="login" method="POST">
			<div class="w3-panel w3-red">${errorMessage}</div>
			<label class="w3-label">Enter email-id:</label> <input name="emailID"
				class="w3-input" type="email"> <label class="w3-label">Enter
				Password</label> <input name="userPass" class="w3-input" type="password">
			<input class="w3-button w3-black" type="submit" />
		</form>
		<!-- <a href="#" class="w3-text-blue">Forgot Password? </a> |  -->
		Not a User? <a
			href="register.jsp" class="w3-text-blue"> Register </a>
	</div>


	<%@include file="footer.html"%>
</body>
</html>