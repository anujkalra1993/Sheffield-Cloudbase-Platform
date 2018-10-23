<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Upload Application</title>
<link rel="stylesheet" href="css/w3.css" />

<%
	String emailID = (String) session.getAttribute("emailID");
	if (emailID == null || emailID.equals("")) {
		//No Active Session.
		session.invalidate();
		request.getRequestDispatcher("index.jsp").forward(request, response);
	}
%>
</head>
<body class="w3-content">
	<%@include file="header.html"%>
	<jsp:include page="menu.jsp" />

	<section class="w3-container">
		<%--This form will be multipart; refer professor's notes on webform and uploading servlet--%>
		<br /> <br /> <br />
		<div class="w3-container">
			<div class="w3-container w3-amber">
				<h2>Upload Application WAR</h2>
			</div>
			<div class="w3-panel w3-text">${errorMessage}</div>
			<form name="warUpload" action="uploadWar?emailID=<%= emailID%>"
				method="post" class="w3-container" enctype="multipart/form-data">
				<label class="w3-text-deep-purple"><b>Application Name: </b></label>
				<input class="w3-border w3-input" type="text" maxlength="20"
					name="appName" required /> <label class="w3-text-deep-purple"><b>Application
						Description:</b></label>
				<textarea class="w3-border w3-input" name="appDescription"
					maxlength="100" rows="7" cols="95" required></textarea>
				<label class="w3-text-deep-purple"><b>App Icon:</b></label> <input
					type="file" name="appIcon" class="w3-border" required
					accept="image/*" /> <label class="w3-text-deep-purple"><b>WAR
						File:</b></label> <input type="file" name="file" class="w3-border" required
					accept=".jar,.war" /> <label class="w3-text-deep-purple"><b>Price:</b></label>
				<input type="number" name="price" class="w3-border w3-input"
					required />
				<%--Hidden Form Field | Track Developer's emailID --%>
				<%-- <input type="hidden" name="<%=emailID%>" /> --%>
				<input type="submit" value="Upload" class="w3-btn w3-light-green" />
			</form>
		</div>
	</section>
	<br />
	<br />
	<br />
	<%@include file="footer.html"%>
</body>
</html>