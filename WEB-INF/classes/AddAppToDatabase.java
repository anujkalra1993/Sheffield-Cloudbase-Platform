package com.auth;

import java.io.*;
import java.sql.*;

import javax.servlet.*;
import javax.servlet.http.*;


/**
 * Servlet implementation class AddAppToDatabase
 */
//@WebServlet("/AddAppToDatabase")
public class AddAppToDatabase extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	int price=0;
	String emailID,appName,appDescription,photoName,photoPath,warFileName,filePath,appPath; //
	String driver, url, dbname,dbpass;
	String insertQuery;
	Connection connection;
	PreparedStatement insertApp;
	ServletContext application;
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Get Details from Upload Servlet and Add to Database
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		application=getServletContext();
		driver=application.getInitParameter("Driver");
		url=application.getInitParameter("url");
		dbname=application.getInitParameter("dbname");
		dbpass=application.getInitParameter("dbpass");
		HttpSession session=request.getSession(false);
		session.getAttribute("emailID");

		appPath=(String) request.getAttribute("appPath");		
		System.out.println("\n\n\n"+appPath+"\n\n\n");
		emailID=(String) request.getAttribute("emailID");
		appName=(String) request.getAttribute("appName");  
		appDescription=(String) request.getAttribute("appDescription");
		photoName=(String) request.getAttribute("photoName");
		photoPath=(String) request.getAttribute("photoPath");
		System.out.println("Say What???");
		warFileName=(String) request.getAttribute("fileName"); 
		filePath=(String) request.getAttribute("filePath");
		price=(int)request.getAttribute("price");
		
		try{
			Class.forName(driver);
			connection = DriverManager.getConnection(url, dbname, dbpass);
			insertQuery = "INSERT INTO appinfo	(owner,appName,appDescription,iconName,warFileName,price,filePath,imagePath)"
					+ " values (?,?,?,?,?,?,?,?)";
			insertApp = connection.prepareStatement(insertQuery);
			insertApp.setString(1, emailID);
			insertApp.setString(2, appName);
			insertApp.setString(3, appDescription);
			insertApp.setString(4, photoName);
			insertApp.setString(5, warFileName);
			insertApp.setInt(6, price);
			insertApp.setString(7, filePath);
			insertApp.setString(8, photoPath);
			int count = insertApp.executeUpdate();
			if(count!=0){
				session.setAttribute("emailID",emailID);
				request.setAttribute("success", "App Inserted!");
				//Create Destination Directory for war file extraction
				final String destinationDirectory = appPath +File.separator +".."+File.separator+appName;
				File webappDirectory = new File(destinationDirectory);
				if(!webappDirectory.exists())
					webappDirectory.mkdir();
				//Send App to Get Extracted
				PackageExtractor.extractWar(filePath+File.separator+warFileName, destinationDirectory /*appContext-webapps+appName.mkdir()*/);
				request.getRequestDispatcher("welcome.jsp").forward(request, response);
			}
			else
			{
				request.setAttribute("errorMessage", "error!");
			}
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
		finally{
			try{
				insertApp.close();
				connection.close();
			}
			catch(SQLException sql){
				sql.printStackTrace();
			}
			catch(Exception exception){
				exception.printStackTrace();
			}
			request.getRequestDispatcher("uploadWar.jsp").forward(request, response);
		}
	}
}
