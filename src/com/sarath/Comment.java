package com.sarath;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(urlPatterns ="/comment", name = "Comment")
public class Comment extends HttpServlet {

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException
	   {
		
		   String id = req.getParameter("id");
		   String comment = req.getParameter("commentcontent");
		   System.out.println(id);
		   HttpSession session = req.getSession();
		   String email = session.getAttribute("email").toString();
		   try
		   {
		    Class.forName("com.mysql.cj.jdbc.Driver");
			String username = "root";
			String password = "";
			String url = "jdbc:mysql://localhost:3306/testing";
			Connection con = DriverManager.getConnection(url,username,password);
			
			PreparedStatement st = con.prepareStatement("insert into comments (postid,email,content) values (?,?,?)");
			st.setString(1,id);
			st.setString(2,email);
			st.setString(3,comment);
			int i =  st.executeUpdate();
			if(i>0)
			{
			     System.out.println("successful");
			     res.sendRedirect("posts.jsp");
			}
			
		   }
		   catch(Exception e)
		   {
			   System.out.println("error in executing the request" + e);
		   }
		   
	   }
  
	
}
