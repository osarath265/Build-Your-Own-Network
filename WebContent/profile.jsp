<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Profile</title>
    <link rel="stylesheet" href="styles.css">

</head>
<body>
<%
response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
if(session.getAttribute("username")==null)
    response.sendRedirect("index.jsp");
%>
<div class="profile w-screen h-screen">
  <div class="topnav grid grid-cols-2 card shadow-lg  h-20 items-center">
     <h2 class="ml-10 text-xl font-bold tracking-wideer text-blue-500">BYON</h2>
     <div class="flex justify-end">
        <a href="posts.jsp" class="text-black-400 text-lg tracking-wide mr-4 cursor-pointer">Feed</a>
        <a href="home.jsp" class="text-black-400 text-lg tracking-wide mr-4 cursor-pointer">Home</a>
        <a  href="friends.jsp" class="text-black-400 text-lg tracking-wide mr-3 cursor-pointer">Friends</a>
        <form action="logout">
        	<button class="text-red-500 text-lg tracking-wider mr-3 cursor-pointer active:border-opacity-0" type="submit">Logout</button>
        </form>
        
     </div>
  </div>
  <sql:setDataSource var="db" driver="com.mysql.jdbc.Driver"  
     			url="jdbc:mysql://localhost:3306/testing"  
     		user="root"  password=""/>
     		
     		
  <sql:query dataSource="${db}" var="users">  
			SELECT * FROM users AS u WHERE u.email="${email}"   		
  </sql:query>  
 <div class="formsection grid grid-cols-2">
    <div class="image mt-20 ml-10">
      <img src="img/social2.jpg"> 
    </div>
    <div class="form ml-5 mt-24 bg-white shadow-md rounded w-4/5 h-3/5 p-5" id="signup">
    <h2 class="text-black-500 text-xl font-bold  tracking-wide">Edit Profile</h2>
    <hr class="text-gray-300 mt-2 font-semibold">
    <c:forEach var = "user" items = "${users.rows}">
     <form class="mt-5" action="updateprofile" method="POST">
        <input class="w-2/5 h-12 p-2 border-2 rounded border-black-200 font-semi-bold text-lg mr-2" placeholder="First Name" name="fname" required value="${user.fname}">
        <input class="w-2/5 h-12 p-2 border-2 rounded border-black-200 font-semi-bold text-lg inline-block" placeholder="Last Name" name="lname" required value="${user.lname}">
        <input class="w-2/5 h-12 p-2 mt-4 mr-2 border-2 rounded border-black-200 font-semi-bold text-lg" placeholder="Date"  name="dob" type="date" required value="${user.dob}">
        <select class="w-2/5 h-12 p-2 mt-4 border-2 rounded border-black-200 font-semi-bold text-lg" name="gen" required value="${user.gen}">
            <option value="Male">Male</option>
            <option value="Female">Female</option>
        </select>
        <button type="submit" class="mt-5 w-2/5 h-12 rounded text-center text-white bg-green-500 text-xl font-bold">Save Changes</button>
     </form>
     </c:forEach>
    </div>
 </div>
</div>
</body>
</html>