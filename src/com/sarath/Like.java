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

@WebServlet(urlPatterns ="/like", name = "Like")
public class Like extends HttpServlet {

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException
	   {
		
		   String id = req.getParameter("id");
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
			PreparedStatement st1 = con.prepareStatement("select * from dislikes where postid=? AND email=?");
			st1.setString(1,id);
			st1.setString(2,email);
			ResultSet r = st1.executeQuery();
			PreparedStatement st2 = con.prepareStatement("select * from likes where postid=? AND email=?");
			st2.setString(1,id);
			st2.setString(2,email);
			ResultSet r1 = st2.executeQuery();
			if(r.next() || r1.next()) {
				
				System.out.println("You have already liked or disliked this post");
				res.sendRedirect("posts.jsp");
				
			}			
			else
			{
				PreparedStatement st = con.prepareStatement("insert into likes (postid,email) values (?,?)");
				st.setString(1,id);
				st.setString(2,email);
				int i =  st.executeUpdate();
				if(i>0)
				{
			         System.out.println("successful");
			         res.sendRedirect("posts.jsp");
				}
			}
			
		   }
		   catch(Exception e)
		   {
			   System.out.println("error in executing the request" + e);
		   }
		   
	   }
  
	
}
