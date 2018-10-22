package com.auth;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class LoginController
 */
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	String emailID=null, userPassword=null;
	String driver=null, url=null, dbname=null, dbpass=null;
	ServletContext application=null;
	Connection connection;
	String sqlQuery;
	PreparedStatement selectStatement=null;
	ResultSet resultSet = null;
	HttpSession session=null;
	PrintWriter out=null;
	String errorMessage = null;
	String accountType=null;
	int peanuts=0;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		out=response.getWriter();
		// Get parameters from login page
		emailID = request.getParameter("emailID");
		userPassword = request.getParameter("userPass");
		
		//Get connection properties to connect to database
		application = getServletContext();
		driver = application.getInitParameter("Driver");
		url = application.getInitParameter("url");
		dbname = application.getInitParameter("dbname");
		dbpass = application.getInitParameter("dbpass");
		
		try{
			Class.forName(driver);
			connection = DriverManager.getConnection(url, dbname, dbpass);
			System.out.println("Connection Made!");
			sqlQuery = "select * from USER where emailID = ? AND password = ?";	
			selectStatement = connection.prepareStatement(sqlQuery);
			selectStatement.setString(1, emailID);
			selectStatement.setString(2, userPassword);
			resultSet = selectStatement.executeQuery();
			System.out.println(emailID);
			System.out.println(userPassword);
			if(resultSet.isBeforeFirst()){
				System.out.println("Found!");
				resultSet.next();
				accountType=resultSet.getString("accountType");
				peanuts=resultSet.getInt("peanuts");
				session = request.getSession();
				session.setAttribute("emailID", emailID);
				session.setAttribute("accountType", accountType);
				session.setAttribute("peanuts", peanuts);
				out.println("Success!");
				resultSet.close();
				selectStatement.close();
				connection.close();
				request.getRequestDispatcher("welcome").forward(request, response);
			}
			else{
				System.out.println("Not Found!");
				errorMessage = "Invalid Email or Password!";
				request.setAttribute("errorMessage", errorMessage);
				request.getRequestDispatcher("login.jsp").forward(request, response);
			}
		}
		catch(ClassNotFoundException classNotFound){
			classNotFound.printStackTrace();
		}
		catch(SQLException sqlException){
			sqlException.printStackTrace();
		}
	}

}
