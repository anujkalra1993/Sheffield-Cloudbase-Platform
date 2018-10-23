<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="css/w3.css"/>
<%
	String emailID=(String)session.getAttribute("emailID");
if(emailID==null){
	session.invalidate();
	request.getRequestDispatcher("login.jsp").forward(request, response);
}
%>
<meta charset="utf-8">
<title>Top-Up Peanuts <%= emailID%></title>
</head>
<body class="w3-content">
	<%@include file="header.html" %>
	<jsp:include page="menu.jsp"/>
	<br/><br/>
	
	<%!int peanuts = 0;
	Connection conn;
	ResultSet rs;
	String sql;
	Statement stmt;
	ResultSet resultSet;%>
		<%!String driver, url, dbname, dbpass;%>
		<%
			driver = application.getInitParameter("Driver");
				url = application.getInitParameter("url");
				dbname = application.getInitParameter("dbname");
				dbpass = application.getInitParameter("dbpass");
				try {
					Class.forName(driver);
					conn = DriverManager.getConnection(url, dbname, dbpass);
					sql = "select Peanuts from User where emailID ='"+emailID+"'";
					stmt=conn.createStatement();
					resultSet=stmt.executeQuery(sql);
					if(resultSet.isBeforeFirst()){
						resultSet.next();
						peanuts=resultSet.getInt(1);
					}
					resultSet.close();
					stmt.close();
					conn.close();
				} catch (ClassNotFoundException notFound) {
					out.println(notFound.getMessage());
				} catch (SQLException sqlEx) {
					out.println(sqlEx.getMessage());
				} catch (Exception exp) {
					out.println(exp.getMessage());
				}
		%>
	
	<section class="w3-row w3-padding">
		<div class="w3-center w3-card-4">
			<header class="w3-lime">
				<h3>Top-Up Peanuts</h3>
			</header>
			<div class="w3-container">
				<form action="topupPeanuts" method="post">
				<label class="w3-text-green"> Your peanuts balance is: </label>
				<input class="w3-input w3-round-small" type="text" name="balance" value="<%= peanuts%>" disabled/>
				<label class="w3-text-green"></label>
				<input type="number" name="updateValue" maxlength="4" required/>
				<input type="submit" value="Add Peanuts" class="w3-btn w3-yellow" />
				</form>
			</div>
		</div>
	</section>
	
	<%@include file="footer.html" %>
</body>
</html>