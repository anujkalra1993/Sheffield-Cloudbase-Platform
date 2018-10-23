<%@page import="java.util.*, java.io.*"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Bought Apps for ${emailID}</title>
<link rel="stylesheet" href="css/w3.css"/>
</head>
<body class="w3-content">
	<%@include file="header.html" %>
	<jsp:include page="menu.jsp"/>
	<%!
	String driver,url,dbname,dbpass;
	Connection connection;
	String query;
	Statement statement;
	ResultSet rs,rs2;
	ResultSetMetaData metaData;
	int price=0;
	String owner,appName,appDescription,iconName,warFileName,filePath,imagePath;/* ,useCount,buyCount */
	int appID=0;
	String emailID,str;
	
	%>
	<%
	driver=application.getInitParameter("Driver");
	url=application.getInitParameter("url");
	dbname=application.getInitParameter("dbname");
	dbpass=application.getInitParameter("dbpass");
	emailID=(String)session.getAttribute("emailID");
	ArrayList<Integer> appList = new ArrayList();
	try{
		Class.forName(driver);
		connection=DriverManager.getConnection(url, dbname, dbpass);
		query = "select * from app_buy_info where buyer = '"+emailID+"'";
		statement=connection.createStatement();
		rs=statement.executeQuery(query);
		if(!rs.isBeforeFirst()){
			%>
			<div class="w3-panel w3-pale-red">
				<h1>No Apps Purchased Yet</h1>
			</div>
			<%
		}
		else{
			%>
			<section class="w3-row">
			<%
			while(rs.next()){
				//Get the List of appID from the resultset
				appList.add(rs.getInt("appID"));
			}
			//close the result set
			rs.close();
			//Iterate over the appList
			for(int i: appList){
				query = "select * from appinfo where id = "+i;
				rs2=statement.executeQuery(query);
				if(rs2.isBeforeFirst()){
					rs2.next();
					appID=rs2.getInt("id");
					owner=rs2.getString("owner");
					appName=rs2.getString("appName");
					appDescription=rs2.getString("appDescription");
					iconName=rs2.getString("iconName");
					warFileName=rs2.getString("warFileName");
					price=rs2.getInt("price");
					filePath=rs2.getString("filePath");
					imagePath=rs2.getString("imagePath");
					%>
					<div class="w3-third w3-padding">
					<div class="w3-card-4">
						<header class="w3-container w3-lime">
							<h3><%= appName%></h3>
							<h6><%= owner%></h6>
						</header>
						<div class="w3-image w3-padding">
		<%
		String network = application.getInitParameter("network_name");
		String newPath = "http://localhost:8080/"+appName;
		%>
							<a target="_blank" href="<%= newPath%>">
							<% str = "uploadedPhotos"+File.separator+owner+File.separator+iconName;
							%>
								<img src="<%= str%>" style="width: 100px;" alt="noimage" />
							</a>
						</div>
						<div class="w3-container">
							<p>
								<%= appDescription%>
								<%-- <a href="purchaseApp?appID=<%= appID%>&owner=<%= owner%>&client=${emailID}&price=<%= price%>">
									<button class="w3-button w3-small w3-green">
										<img src="images/pea.jpg" alt="peanut"
											style="width: 15px; height: 15px;" /> <%= price%>
									</button>
								</a> --%>
							</p>
						</div>
					</div>
					</div>
					<%
				}
			}
			%>
			</section>
			<%
		}
	}catch (ClassNotFoundException notFound) {
		out.println(notFound.getMessage());
		notFound.printStackTrace();
	} catch (SQLException sqlEx) {
		out.println(sqlEx.getMessage());
		sqlEx.printStackTrace();
	} catch (Exception exp) {
		out.println(exp.getMessage());
		exp.printStackTrace();
	}
	%>
	<%@include file="footer.html" %>
</body>
</html>