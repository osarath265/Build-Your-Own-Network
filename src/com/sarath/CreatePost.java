package com.sarath;

import java.io.File;
import java.io.IOException;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.List;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;



@WebServlet(urlPatterns ="/post", name = "CreatePost")
public class CreatePost extends HttpServlet {

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException
	   {
		   String postcontent = req.getParameter("postcontent");
		   HttpSession session = req.getSession();
		   String email = session.getAttribute("email").toString();
		   String fileurl= req.getParameter("url");	   
		   System.out.println("got image url...."+fileurl);
		   try
		   {
		    Class.forName("com.mysql.cj.jdbc.Driver");
			String username = "root";
			String password = "";
			String url = "jdbc:mysql://localhost:3306/testing";
			Connection con = DriverManager.getConnection(url,username,password);
            if(fileurl.equals(""))
            {
            	
            	PreparedStatement st = con.prepareStatement("insert into posts (postid,email,content) values (UUID(),?,?)");
    			st.setString(1,email);
    			st.setString(2,postcontent);
    			int j =  st.executeUpdate();
    			if(j>0)
    			{
    			         System.out.println("content successful");
    			         res.sendRedirect("home.jsp");
    			}            	
            	
            }
            else
            {
            	PreparedStatement st1 = con.prepareStatement("insert into posts (postid,email,content,image) values (UUID(),?,?,?)");
    			st1.setString(1,email);
    			st1.setString(2,postcontent);
    			st1.setString(3, fileurl);
    			int j =  st1.executeUpdate();
    			if(j>0)
    			{
    			         System.out.println("content successful");
    			         res.sendRedirect("home.jsp");
    			}
    			

            }
		   }
		   catch(Exception e)
		   {
			   System.out.println("error in executing the request" + e);
		   }
	   }
  
	
}




















