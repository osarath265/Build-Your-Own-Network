package com.sarath;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(urlPatterns ="/accept", name = "AcceptReq")

public class AcceptReq extends HttpServlet {
	
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException
	   {
		   String frndname = req.getParameter("acceptname");
		   HttpSession session = req.getSession();
		   String email = session.getAttribute("email").toString();
		   try
		   {
		    Class.forName("com.mysql.cj.jdbc.Driver");
			String username = "root";
			String password = "";
			String url = "jdbc:mysql://localhost:3306/testing";
			Connection con = DriverManager.getConnection(url,username,password);
			PreparedStatement st=con.prepareStatement("UPDATE relations SET status=TRUE WHERE usermail=(SELECT u.email FROM users as u WHERE u.uname=?) AND frndmail=? AND status=?");
			st.setString(1,frndname);
			st.setString(2, email);
			st.setString(3, "0");
			
			int i =  st.executeUpdate();
			if(i>0)
			{
		         System.out.println("successful 1.....");
		         
			}
			PreparedStatement st1 = con.prepareStatement("INSERT INTO relations (usermail, frndmail, status) VALUES (?,(SELECT u.email FROM users as u WHERE u.uname=?) ,?)");
			st1.setString(1,email);
			st1.setString(2,frndname);
			st1.setString(3,"1");
			int j =  st1.executeUpdate();
			if(j>0)
			{
				System.out.println("successful 2....");
				res.sendRedirect("friends.jsp");
			}
		   }
		   catch(Exception e)
		   {
			   System.out.println("error in executing the request" + e);
		   }
	   }
	

}
