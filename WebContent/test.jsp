<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<% 
	Class.forName("com.mysql.cj.jdbc.Driver");
	String username = "root";
	String password = "";
	String url = "jdbc:mysql://localhost:3306/testing";
	String sql = "select * from users where email=email";
	Connection con = DriverManager.getConnection(url,username,password);
	Statement st = con.createStatement();
	ResultSet rs =  st.executeQuery(sql);
	rs.next();
	 String email = request.getParameter("email");
	String fname = request.getParameter("fname");
	   String lname = request.getParameter("lname");
	   String uname = fname+lname;
	   String pass = request.getParameter("password");
	   String date = request.getParameter("dob");
	   String gen = request.getParameter("gen");
	   String query= "insert into users(fname,lname,uname,email,dob,gen,password)"+  
			   " values('"+fname+"','"+lname+"','"+uname+"','"+email+"','"+date+"','"+gen+"','"+pass+"')";
	   int i=st.executeUpdate(query);
	   response.sendRedirect("index.jsp");

	%>
</body>
</html>