package com.auth;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;


public class PurchaseAppServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   

	//<a href="purchaseApp?appID=<%= appID%>?owner=<%= owner%>?client=${emailID}?price=<%= price%>">\
	String owner, buyer;
	int appID, price;
	String driver, url, dbname, dbpass;
	ServletContext application;
	Connection connection;
	Statement stmt;
	ResultSet peanutResultSet;
	PreparedStatement preparedStmt;
	boolean appBought=false;
	String message;
	HttpSession session;
	String updateQuery;
	int pea;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		//Create a print Writer to print out statements to HTML pages in case of exceptions
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		
		//Get data from request
		String s = request.getParameter("appID");
		appID = Integer.parseInt(s);
		owner = request.getParameter("owner");
		buyer = request.getParameter("client");
		String s1 = request.getParameter("price");
		price = Integer.parseInt(s1);
		
		//Get db connection strings from the DD
		application=getServletContext();
		driver = application.getInitParameter("Driver");
		url = application.getInitParameter("url");
		dbname = application.getInitParameter("dbname");
		dbpass = application.getInitParameter("dbpass");
		
		session = request.getSession(false);
		session.setAttribute("emailID", buyer);
		System.out.println(appID+" "+owner+" "+buyer+" "+price);
		
		//Connect to the database
		try{
			Class.forName(driver);
			connection=DriverManager.getConnection(url, dbname, dbpass);
			String getBalance = "select Peanuts from User where emailID = '"+buyer+"'";
			stmt=connection.createStatement();
			peanutResultSet = stmt.executeQuery(getBalance);
			if(peanutResultSet.isBeforeFirst()){
				//Balance returned
				peanutResultSet.next();
				pea=peanutResultSet.getInt(1);
				if(price>pea){
					//Can't purchase apps
					message = "Insufficient Balance";
					appBought=false;
				}
				else{
					String query = "INSERT INTO app_buy_info(appID,owner,buyer,price) VALUES(?,?,?,?)";
					preparedStmt = connection.prepareStatement(query);
					preparedStmt.setInt(1, appID);
					preparedStmt.setString(2, owner);
					preparedStmt.setString(3, buyer);
					preparedStmt.setInt(4, price);
					preparedStmt.executeUpdate();
					//Deduct peanuts from user balance
					String deductQuery="UPDATE user "
							+ " SET Peanuts = ? "
							+ " WHERE emailID = ?";
					String creditQuery="UPDATE user "
							+ " SET Peanuts = ? "
							+ " WHERE emailID = ?";
					int balance = pea-price;
					
					preparedStmt=connection.prepareStatement(deductQuery);
					preparedStmt.setInt(1, balance);
					preparedStmt.setString(2, buyer);
					preparedStmt.executeUpdate();
					//App bought and Transaction complete
					appBought=true;
					System.out.println("DONE!");
					preparedStmt.close();
				}
			} 
			
			//updateQuery = "UPDATE";
			stmt.close();
			connection.close();
		}
		catch(ClassNotFoundException notFound){
			String err = notFound.getMessage();
			out.println(err);
		}
		catch(SQLException sqlExp){
			String err = sqlExp.getMessage();
			out.println(err);
		}
		catch(Exception exp){
			String err = exp.getMessage();
			out.println(err);
			
		}
		System.out.println(appBought);
		if(appBought==true){
			message = "success";
			session.setAttribute("message", message);
			request.getRequestDispatcher("boughtApps.jsp").forward(request, response);
		}
		else{
			session.setAttribute("message", message);
			request.getRequestDispatcher("welcome.jsp").forward(request, response);
		}
	}

}
