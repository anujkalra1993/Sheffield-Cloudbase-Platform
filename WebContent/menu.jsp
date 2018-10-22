<%@page import="java.sql.*"%>
<nav class="w3-topnav w3-black">
	<a href="index.jsp"> Home </a> <a href="about.jsp"> About Us </a>
	<%
		String emailID = (String) session.getAttribute("emailID");
		String accountType = (String) session.getAttribute("accountType");
		if (emailID == null) {
	%><a href="login.jsp"> Login </a>
	<%
		} else {
	%>
	<a href="welcome.jsp"> Apps </a>
	<a href="boughtApps.jsp"> Dashboard </a>
	<a href="searchApps.jsp">Search</a>
	<%
		if (accountType.equals("Developer")) {
	%>
	<a href="uploadWar.jsp"> Upload WAR </a>
	<%
		}
	%>
	<a href="logout"> Logout <%=emailID%></a>
	<div class="w3-bar-item w3-right">
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
		Peanuts: <b><%= peanuts%></b><a href="topup.jsp">&nbsp;(Top-up)&nbsp;</a>
	</div>
	<%
		}
	%>
</nav>