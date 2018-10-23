package com.auth;

import java.io.*;
import java.sql.*;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class RegisterUser extends HttpServlet {
	private static final long serialVersionUID = 1L;

	String name, emailID, password1, password2, accountType;
	PrintWriter out = null;
	String checkQuery, insertQuery;
	String successMessage = "Registered! Login to your page!";
	String errorMessage="";
	
	ServletContext application=null;
	//HttpSession session = null;
	String driver = null, url = null, dbname = null, dbpass = null;

	Connection connection = null;
	ResultSet checkResultSet = null;
	Statement statement = null;
	PreparedStatement insertStatement = null;
	Boolean userAdded=false;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		out=response.getWriter();

		//Get Details from registration page register.jsp
		name=request.getParameter("name");
		emailID=request.getParameter("emailID");
		password1=request.getParameter("userPass1");
		password2=request.getParameter("userPass2");
		accountType=request.getParameter("accountType");

		System.out.println(name+", "+emailID+", "+password1+", "+password2+", "+accountType);

		//Get database connection details from web.xml
		//Get connection properties to connect to database
		application = getServletContext();
		driver = application.getInitParameter("Driver");
		url = application.getInitParameter("url");
		dbname = application.getInitParameter("dbname");
		dbpass = application.getInitParameter("dbpass");
		

		checkQuery="select * from USER where emailID = '" + emailID+ "'";
		insertQuery="INSERT INTO USER(fullname,emailID,password,accountType)"
				+ "VALUES(?,?,?,?)";

		if(password1.equals(password2)){
			try{
				Class.forName(driver);
				connection=DriverManager.getConnection(url, dbname, dbpass);
				statement=connection.createStatement();
				checkResultSet=statement.executeQuery(checkQuery);
				if(checkResultSet.isBeforeFirst()==false){
					/*Meaning that there is no user with that email-ID */
					insertStatement=connection.prepareStatement(insertQuery);
					insertStatement.setString(1, name);
					insertStatement.setString(2, emailID);
					insertStatement.setString(3, password1);
					insertStatement.setString(4, accountType);
					insertStatement.executeUpdate();
					//New User Added
					userAdded=true;
					insertStatement.close();
				}
				else{
					/* Means that there is already a member registered with the email-ID*/
					errorMessage="The email ID "+emailID+" is already registered!";
					checkResultSet.close();
				}
			}
			catch(ClassNotFoundException classNotFound){
				out.println(classNotFound.getStackTrace());
				System.out.println("Class Not Found Exception \n");
				classNotFound.printStackTrace();
			}
			catch (SQLException sqlException) {
				out.println(sqlException.getStackTrace());
				System.out.println("SQL Exception \n");
				sqlException.printStackTrace();
			}
			catch(Exception exception){
				out.println(exception.getStackTrace());
				System.out.println("Exception!! \n\n");
				exception.printStackTrace();
			}
			finally {
				try{
					statement.close();
					connection.close();
				}
				catch(SQLException sql){
					sql.printStackTrace();
				}
			}
		}
		else{
			System.out.println("Passwords do not match");
			//out.println("<p>The Passwords do not match </p>");
			errorMessage = "The two passwords do not match!";
		}
		//Forward depending on the outcome.
		if(userAdded==true){
			//New User Added, send them to login
			//session.setAttribute("sucessMessage", successMessage);
			request.getRequestDispatcher("login.jsp").forward(request, response);
		}
		else if(userAdded==false){
			//New user NOT added, send them to registration
			request.setAttribute("errorMessage", errorMessage);
			request.getRequestDispatcher("register.jsp").forward(request, response);
		}
		else{
			//Something else is wrong
			System.out.println("Something else is wrong, please check");
		}
		
	}

}
