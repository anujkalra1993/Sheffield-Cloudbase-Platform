<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Member Login</title>
  <script type="text/javascript">
  	
  </script>
<link rel="stylesheet" href="css/w3.css" />
</head>
<body class="w3-content">
	<%@include file="header.html" %>
    <jsp:include page="menu.jsp" />

	<div class="w3-card">
		<div class="w3-container w3-pale-red">
			<h2>Members Registration</h2>
		</div>
		<form class="w3-container" action="register" method="post" name="registrationForm">
			<div class="w3-panel w3-red">${errorMessage}</div>
			<label class="w3-label">Enter Name:</label>
			<input class="w3-input" type="text" name="name" required>
			<label class="w3-label">Enter email-id:</label>
			<input class="w3-input" type="email" name="emailID" required>
			<label class="w3-label">Enter Password:</label>
			<input class="w3-input" type="password" name="userPass1" required>
			<label class="w3-label">Retype Password</label>
			<input class="w3-input" type="password" name="userPass2" required>
			<label class="w3-label">Account Type</label>
			<select class="w3-input" name="accountType">
				<option value="Developer" class="w3-text-red" >Developer</option>
				<option value="General User" class="w3-text-blue" >General User</option>
			</select>
			<input class="w3-button w3-black" type="submit" />
		</form>
	</div>


	<%@include file="footer.html" %>
</body>
</html>