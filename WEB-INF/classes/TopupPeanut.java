package com.auth;

import java.io.*;
import java.sql.*;

import javax.servlet.*;
import javax.servlet.http.*;

public class TopupPeanut extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	int morePeanuts=0, peanuts=0;
	String driver, url, dbname, dbpass, emailID, query;
	HttpSession session;
	ServletContext application;
	Connection connection;
	Statement stmt;
	ResultSet rs;
	int count=0;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		System.out.println("doPost initiated");
		session = request.getSession(false);
		application = getServletContext();
		driver = application.getInitParameter("Driver");
		url = application.getInitParameter("url");
		dbname =application.getInitParameter("dbname");
		dbpass =application.getInitParameter("dbpass");
		morePeanuts =Integer.parseInt(request.getParameter("updateValue"));
		emailID = (String) session.getAttribute("emailID");
		if(morePeanuts > 0){// Because update value should always be positive
			//update the value of peanuts
			
			try{
				Class.forName(driver);
				connection = DriverManager.getConnection(url, dbname, dbpass);
				String sql = "select Peanuts from User where emailID = '"+emailID+"'";
				stmt=connection.createStatement();
				rs=stmt.executeQuery(sql);
				rs.next();
				peanuts=rs.getInt(1);
				int update=peanuts+morePeanuts;
				query = "update User "
						+ "set Peanuts = "+update+"  where emailID = '"+emailID+"'"; 
				stmt=connection.createStatement();
				count =stmt.executeUpdate(query);
			}
			catch(ClassNotFoundException notFound){
				notFound.printStackTrace();
			}
			catch(SQLException sql){
				sql.printStackTrace();
			}
			finally {
				try {
					stmt.close();
					connection.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		session.setAttribute("emailID", emailID);
		request.getRequestDispatcher("topup.jsp").forward(request, response);
	}

}
