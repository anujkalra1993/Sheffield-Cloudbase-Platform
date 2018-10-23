package com.auth;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

/**
 * Servlet implementation class WelcomeServlet
 */
//@WebServlet("/WelcomeServlet")
public class WelcomeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	//Declaring the string variables to get connection values from DD
	String driver,url,dbname,dbpass;
	//Desclaring JDBC Objects
	Connection connection=null;
	Statement statement=null;
	ResultSet result=null;
	//Query string to fetch values of the freshly logged in user
	String query=null;
	//String variable to fetch accountType attribute from HttpSession
	String accountType=null,emailID=null;
	ServletContext application = null;
	HttpSession session=null;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//Get connection values from deployment descriptor
		application=getServletContext();
		driver=application.getInitParameter("Driver");
		url=application.getInitParameter("url");
		dbname=application.getInitParameter("dbname");
		dbpass=application.getInitParameter("dbpass");
		session=request.getSession(false);
		emailID=(String)session.getAttribute("emailID");
		//Connect to database
		try{
			Class.forName(driver);
			connection=DriverManager.getConnection(url, dbname, dbpass);
			query="SELECT * FROM user WHERE emailID='"+emailID+"'";
			statement=connection.createStatement();
			result=statement.executeQuery(query);
			if(result.isBeforeFirst())
			{
				result.next();//Since email is unique, there will only be a single entry in the result set
				//o need for loop
				accountType=result.getString("accountType");
			}
			request.setAttribute("accountType", accountType);
			request.setAttribute("emailID", emailID);
			result.close();
			statement.close();
			connection.close();
			request.getRequestDispatcher("welcome.jsp").forward(request, response);
		}
		catch(ClassNotFoundException notFound){
			notFound.printStackTrace();
		}
		catch(SQLException sqlException){
			sqlException.printStackTrace();
		}
		catch(Exception exception){
			exception.printStackTrace();
		}
	}

}
