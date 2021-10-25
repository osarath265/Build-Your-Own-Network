package com.sarath;

import java.io.IOException;
import java.io.PrintWriter;
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


@WebServlet(urlPatterns ="/reset", name = "Resetpass")


public class Resetpass extends HttpServlet {
	
	public void doPost(HttpServletRequest req,HttpServletResponse res) throws IOException
	{
		String email = req.getParameter("email");
		String pass = req.getParameter("newpass");
		String pass1 = req.getParameter("confirmpass");
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
				if(pass.equals(pass1))
				{
				PreparedStatement st1 = con.prepareStatement("UPDATE users SET password=? WHERE email=?");
				st1.setString(1,pass);
				st1.setString(2,email);
				int i = st1.executeUpdate();
				if(i>0)
				{
					System.out.println("updated password successfullyy");
					res.sendRedirect("index.jsp");
				}
				else
				{
					System.out.println("Updation failed");
					PrintWriter p = res.getWriter();
					p.print("Error occured in updating the password");
				}
				}
			}
			else
			{
				PrintWriter  p = res.getWriter();
				p.print("Account doesnt exist please sign up");
				System.out.println("Account doesnt exist please sign up");
			}
		}
		catch(Exception e)
		{
			System.out.println("error in connecting to database"+e);
		}
	}
	

}
