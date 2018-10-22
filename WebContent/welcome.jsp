<%@page import="java.io.*"%>
<%@page import="java.sql.*, java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<link rel="stylesheet" href="css/w3.css" />

<title>Welcome ${emailID}</title>
</head>
<body class="w3-content">
	<%@ include file="header.html"%>
	<jsp:include page="menu.jsp" />
	<section class="w3-container">
	
	<%!
	String driver,url,dbname,dbpass;
	Connection conn;
	String query;
	Statement statement;
	ResultSet rs;
	ResultSetMetaData metaData;
	int price=0;
	String owner,appName,appDescription,iconName,warFileName,filePath,imagePath;/* ,useCount,buyCount */
	int appID=0;
	String str;
	%>
	<%
	driver=application.getInitParameter("Driver");
	url=application.getInitParameter("url");
	dbname=application.getInitParameter("dbname");
	dbpass=application.getInitParameter("dbpass");
	try{
		Class.forName(driver);
		conn = DriverManager.getConnection(url, dbname, dbpass);
		query = "select * from appinfo";
		statement=conn.createStatement();
		rs=statement.executeQuery(query);
		if(rs.isBeforeFirst()){
			/* int numberOfRows =0;
			while(rs.next()){ numberOfRows++; }
			System.out.println(numberOfRows);
			rs.beforeFirst(); */
			%>
			<section class="w3-row">
			<%
				while(rs.next()){
					appID=rs.getInt("id");
					owner=rs.getString("owner");
					appName=rs.getString("appName");
					appDescription=rs.getString("appDescription");
					iconName=rs.getString("iconName");
					warFileName=rs.getString("warFileName");
					price=rs.getInt("price");
					filePath=rs.getString("filePath");
					imagePath=rs.getString("imagePath");
					%>
					<div class="w3-third w3-padding">
					<div class="w3-card-4">
						<header class="w3-container w3-indigo">
							<h3><%= appName%></h3>
							<h6><%= owner%></h6>
						</header>
						<div class="w3-image w3-padding">
						<% str = "uploadedPhotos"+File.separator+owner+File.separator+iconName; 
						//out.println(str);
						//imagePath+File.separator+iconName
						%>
							<img src="<%= str%>" style="width: 100px;" alt="noimage" />
						</div>
						<div class="w3-container">
							<p>
								<%= appDescription%>
								<a href="purchaseApp?appID=<%= appID%>&owner=<%= owner%>&client=${emailID}&price=<%= price%>">
									<button class="w3-button w3-small w3-green">
										<img src="images/pea.jpg" alt="peanut"
											style="width: 15px; height: 15px;" /> <%= price%>
									</button>
								</a>
							</p>
						</div>
					</div>
					</div>
					<%
				}
				%>
			</section>
			<%
		}
		else{
			%>
			<section class="w3-row">
				<p class="w3-panel w3-pale-red">No Apps to display yet</p>
			</section>
			<%
		}
	}
	catch(ClassNotFoundException cl){
		%>
			<p>
				<% cl.printStackTrace(); %>
			</p>
		<%
	}
	catch(SQLException sqle){
		%>
			<p>
				<% sqle.printStackTrace(); %>
			</p>
		<%
	}
	catch(Exception exl){
		%>
			<p>
				<% exl.printStackTrace(); %>
			</p>
		<%
	}
	%>
	<%-- c:if ${accountType.eq('Developer') }></c:if> --%>
	
		<!-- 
		<%-- Row 1 || Each row has 3 cards/apps--%>
		<section class="w3-row">
			<%--App 1 Started --%>
			<div class="w3-third w3-padding">
				<div class="w3-card-4">
					<header class="w3-container w3-indigo">
						<h3>App 1</h3>
						<h6>Developer Name</h6>
					</header>
					<div class="w3-image w3-padding">
						<a href="#"> <img src="images/no-image.png"
							style="width: 100px;" alt="noimage" />
						</a>
					</div>
					<div class="w3-container">
						<p>
							App Desription
							<button class="w3-button w3-small w3-green">
								<img src="images/pea.jpg" alt="peanut"
									style="width: 15px; height: 15px;" /> Price
							</button>
						</p>
					</div>
				</div>
			</div>
			<%--App 1 Finished --%>
			<%--App 2 Started --%>
			<div class="w3-third w3-padding">
				<div class="w3-card-4">
					<header class="w3-container w3-indigo">
						<h3>App 1</h3>
						<h6>Developer Name</h6>
					</header>
					<div class="w3-image w3-padding">
						<a href="#"> <img src="images/no-image.png"
							style="width: 100px;" alt="noimage" />
						</a>
					</div>
					<div class="w3-container">
						<p>
							App Desription
							<button class="w3-button w3-small w3-green">
								<img src="images/pea.jpg" alt="peanut"
									style="width: 15px; height: 15px;" /> Price
							</button>
						</p>
					</div>
				</div>
			</div>
			<%--App 2 Finished --%>
			<%--App 3 Started --%>
			<div class="w3-third w3-padding">
				<div class="w3-card-4">
					<header class="w3-container w3-indigo">
						<h3>App 1</h3>
						<h6>Developer Name</h6>
					</header>
					<div class="w3-image w3-padding">
						<a href="#"> <img src="images/no-image.png"
							style="width: 100px;" alt="noimage" />
						</a>
					</div>
					<div class="w3-container">
						<p>
							App Desription
							<button class="w3-button w3-small w3-green">
								<img src="images/pea.jpg" alt="peanut"
									style="width: 15px; height: 15px;" /> Price
							</button>
						</p>
					</div>
				</div>
			</div>
			<%--App 3 Finished --%>
			<%--Row 1 Finished --%>
		</section>
		<%-- Row 2 || Each row has 3 cards/apps--%>
		<section class="w3-row">
			<%--App 4 Started --%>
			<div class="w3-third w3-padding">
				<div class="w3-card-4">
					<header class="w3-container w3-indigo">
						<h3>App 1</h3>
						<h6>Developer Name</h6>
					</header>
					<div class="w3-image w3-padding">
						<a href="#"> <img src="images/no-image.png"
							style="width: 100px;" alt="noimage" />
						</a>
					</div>
					<div class="w3-container">
						<p>
							App Desription
							<button class="w3-button w3-small w3-green">
								<img src="images/pea.jpg" alt="peanut"
									style="width: 15px; height: 15px;" /> Price
							</button>
						</p>
					</div>
				</div>
			</div>
			<%--App 4 Finished --%>
			<%--App 5 Started --%>
			<div class="w3-third w3-padding">
				<div class="w3-card-4">
					<header class="w3-container w3-indigo">
						<h3>App 1</h3>
						<h6>Developer Name</h6>
					</header>
					<div class="w3-image w3-padding">
						<a href="#"> <img src="images/no-image.png"
							style="width: 100px;" alt="noimage" />
						</a>
					</div>
					<div class="w3-container">
						<p>
							App Desription
							<button class="w3-button w3-small w3-green">
								<img src="images/pea.jpg" alt="peanut"
									style="width: 15px; height: 15px;" /> Price
							</button>
						</p>
					</div>
				</div>
			</div>
			<%--App 5 Finished --%>
			<%--App 6 Started --%>
			<div class="w3-third w3-padding">
				<div class="w3-card-4">
					<header class="w3-container w3-indigo">
						<h3>App 1</h3>
						<h6>Developer Name</h6>
					</header>
					<div class="w3-image w3-padding">
						<a href="#"> <img src="images/no-image.png"
							style="width: 100px;" alt="noimage" />
						</a>
					</div>
					<div class="w3-container">
						<p>
							App Desription
							<button class="w3-button w3-small w3-green">
								<img src="images/pea.jpg" alt="peanut"
									style="width: 15px; height: 15px;" /> Price
							</button>
						</p>
					</div>
				</div>
			</div>
			<%--App 6 Finished --%>
			<%--Row 2 Finished --%>
		</section>
		-->
	</section>
	<%@ include file="footer.html"%>
</body>
</html>