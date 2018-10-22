<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>About</title>
<link rel="stylesheet" href="css/w3.css" />
</head>
<body class="w3-content">

	<%@include file="header.html"%>
	<jsp:include page="menu.jsp" />

	<section class="w3-contaier w3-pale-green">
		<h2>Welcome to Sheffield Cloudbase Platform.</h2>
		<p>This platform is a place for Java web developers to collaborate
			and upload their apps. Developers may upload new apps on the
			platform. The platform runs on the Apache Tomcat 8.5 Web Server.
			Users first need to register and log into the platform before they
			can upload apps or use the apps that already exist on the
			server.Users can search throught the app page to view a list of the
			apps. They may purchase an app by clicking on the green button
			showing the number of peanuts that is the cost of the app.</p>

		<p>Developers can collaborate on the platform by uploading apps on
			the upload WAR form. They must also supply an image file (any size)
			that will be used to identify their apps and add a visual element to
			their apps on the dashboard. If the developer wishes, they may use
			the CreateDatabase and the GetConnection classes to connect with the
			app.</p>

		<p>The users may also topup their peanuts using the top-up peanuts
			page accessible to them after they log in. The peanuts are used to
			purchase and use apps on the platform. Then the purchased apps can be
			launched after clicking on the image file of the new app once it is
			available on their personal dashboard.</p>
	</section>

	<%@include file="footer.html"%>

</body>
</html>