package com.sarath;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet(urlPatterns ="/login", name = "Login")


public class Login extends HttpServlet {
	
	public void doPost(HttpServletRequest req,HttpServletResponse res) throws IOException
	{
		String email = req.getParameter("email");
		String pass = req.getParameter("password");
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
				System.out.println(rs.getString(7));
				if(rs.getString(7).equals(pass))
				{
					HttpSession session = req.getSession();
					session.setAttribute("username", rs.getString(3));
					session.setAttribute("email", rs.getString(4));
					session.setMaxInactiveInterval(3600);
					res.sendRedirect("home.jsp");
				}
				else
				{
					System.out.println("wrong password");
					PrintWriter  p = res.getWriter();
					p.print("Invalid credentials");
					//res.sendRedirect("index.jsp");
				}
			}
			else
			{
				System.out.println("Account doesnt exist please sign up");
				PrintWriter  p = res.getWriter();
				p.print("Account does'nt exists please sign up");
			}
		}
		catch(Exception e)
		{
			System.out.println("error in connecting to database"+e);
		}
	}
	

}




























