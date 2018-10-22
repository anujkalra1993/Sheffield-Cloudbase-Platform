package com.auth;

import java.io.IOException;

import javax.servlet.*;
import javax.servlet.http.*;

/**
 * Servlet implementation class LogoutServlet
 */
//@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		if(session!=null){
			session.invalidate();
		}
		request.getRequestDispatcher("index.jsp").forward(request, response);
	}

}
