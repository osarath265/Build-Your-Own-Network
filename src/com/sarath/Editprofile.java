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

@WebServlet(urlPatterns ="/updateprofile", name = "Editprofile")
public class Editprofile extends HttpServlet{

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException
	   {
		   HttpSession session = req.getSession();
		   String email = session.getAttribute("email").toString();
		   String fname = req.getParameter("fname");
		   String lname = req.getParameter("lname");
		   String uname = fname+lname;
		   String date = req.getParameter("dob");
		   String gen = req.getParameter("gen");
		   try
		   {
		    Class.forName("com.mysql.cj.jdbc.Driver");
			String username = "root";
			String password = "";
			String url = "jdbc:mysql://localhost:3306/testing";
			Connection con = DriverManager.getConnection(url,username,password);
			PreparedStatement st = con.prepareStatement("UPDATE users SET fname=?,lname=?,uname=?,dob=?,gen=? where email=?");
			st.setString(1,fname);
			st.setString(2,lname);
			st.setString(3, uname);
			st.setString(4,date);
			st.setString(5,gen );
			st.setString(6,email);
			int i =  st.executeUpdate();
			if(i>0)
			{
		         System.out.println("successful");
		         res.sendRedirect("home.jsp");
			}
		   }
		   catch(Exception e)
		   {
			   System.out.println("error in executing the request" + e);
		   }
	   }

	
}












