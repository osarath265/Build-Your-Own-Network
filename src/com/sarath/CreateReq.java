package com.sarath;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(urlPatterns ="/req", name = "CreateReq")
public class CreateReq extends HttpServlet{

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException
	   {
		   String frndmail = req.getParameter("frndname");
		   HttpSession session = req.getSession();
		   String email = session.getAttribute("email").toString();
		   try
		   {
		    Class.forName("com.mysql.cj.jdbc.Driver");
			String username = "root";
			String password = "";
			String url = "jdbc:mysql://localhost:3306/testing";
			Connection con = DriverManager.getConnection(url,username,password);
			PreparedStatement st = con.prepareStatement("insert into relations (usermail, frndmail, status) values (?,(select u.email FROM users as u where u.uname=?),?)");
			st.setString(1,email);
			st.setString(2, frndmail);
			st.setString(3, "0");
			int i =  st.executeUpdate();
			if(i>0)
			{
		         System.out.println("successful");
		         res.sendRedirect("friends.jsp");
			}
		   }
		   catch(Exception e)
		   {
			   System.out.println("error in executing the request" + e);
		   }
	   }

	
}
