package com.sarath;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;


@WebServlet(urlPatterns ="/test", name = "Testing")
public class Testing extends HttpServlet{
   public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException
   {
	   String email = req.getParameter("email");
	   try
	   {
	    Class.forName("com.mysql.cj.jdbc.Driver");
		String username = "root";
		String password = "";
		String url = "jdbc:mysql://localhost:3306/testing";
		String sql = "select * from users where email='"+email+"'";
		Connection con = DriverManager.getConnection(url,username,password);
		Statement st = con.createStatement();
		ResultSet rs =  st.executeQuery(sql);
		if(rs.next())
		{
	         System.out.println("user already exists");
	         PrintWriter p = res.getWriter();
	         p.print("user already exists");
		}
		else
		{
			   String fname = req.getParameter("fname");
			   String lname = req.getParameter("lname");
			   String uname = fname+lname;
			   String pass = req.getParameter("password");
			   String date = req.getParameter("dob");
			   String gen = req.getParameter("gen");
			   String query= "insert into users(fname,lname,uname,email,dob,gen,password)"+  
					   " values('"+fname+"','"+lname+"','"+uname+"','"+email+"','"+date+"','"+gen+"','"+pass+"')";
			   int j=st.executeUpdate(query);
			   System.out.println("testing....."+j);
			   res.sendRedirect("index.jsp");
		}
	   }
	   catch(Exception e)
	   {
		   System.out.println("error in establishing the connection");
	   }
   }
}
