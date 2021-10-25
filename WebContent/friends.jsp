<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>  


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>BYON</title>
<link rel="stylesheet" href="styles.css">
</head>
<body class="bg-gray-50">
  <%
      response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
      if(session.getAttribute("username")==null)
      response.sendRedirect("index.jsp");
      String email = session.getAttribute("email").toString();
  %>
  <div class="home w-screen h-screen">
  <div class="topnav grid grid-cols-2 card shadow-md  h-20 items-center">
     <h2 class="ml-10 text-xl font-bold tracking-wideer text-blue-500">BYON</h2>
     <div class="flex justify-end">
        <a href="posts.jsp"class="text-black-400 text-lg tracking-wide mr-4 cursor-pointer">Feed</a>
        <a href="home.jsp"class="text-black-400 text-lg tracking-wide mr-4 cursor-pointer">Home</a>
        <a  href="friends.jsp" class="text-black-400 text-lg tracking-wide mr-3 cursor-pointer border-b-2 rounded-sm border-blue-600">Friends</a>
        <form action="logout">
        	<button class="text-red-500 text-lg tracking-wider mr-3 cursor-pointer active:border-opacity-0" type="submit">Logout</button>
        </form>
     </div>
  </div>
  
        <sql:setDataSource var="db" driver="com.mysql.cj.jdbc.Driver"  
     			url="jdbc:mysql://localhost:3306/testing"  
     		user="root"  password=""/>
  
        <sql:query dataSource="${db}" var="rs">  
			SELECT u.uname FROM users AS u JOIN relations AS r ON r.usermail="${email}" AND u.email=r.frndmail AND r.status=TRUE;  
		</sql:query> 
		<sql:query dataSource="${db}" var="nonfriends">  
			SELECT * FROM users AS u LEFT JOIN relations AS r ON r.usermail="${email}"  AND u.email=r.frndmail AND r.status=TRUE WHERE STATUS IS NULL AND u.email!="${email}";  
		</sql:query>
		 
  <div class="friends grid grid-cols-3 w-full mt-5 gap-x-5">
    <div class="all-friends card shadow-md ml-5 p-5 rounded">
      <h2 class="text-xl font-bold text-black-500 tracking-wide mb-4">Friends</h2>
      <hr class="text-gray-300 mt-2 font-semibold">
           <div class="friend-list mt-4">
	      <c:forEach var="j" items="${rs.rows}">
	        <div class="flex rounded card mb-4">
	         <img src="img/short_avatar.svg" class="w-10 h-10 mr-3"> 
	         <h3 class="text-lg font-semi-bold text-black-500">${j.uname}</h3>   
	        </div>
	      </c:forEach>
    	  </div>
    </div>	  
    <div class="add-friend card shadow-md p-5">
    <h2 class="text-xl font-bold text-black-500 tracking-wide mb-4">Connect</h2>
    <hr class="text-gray-300 mt-2 font-semibold">
       <img class="w-32 h-32 mx-auto mt-4" src="img/add-user.svg">
       <form action="req" method="POST">
       <input name="frndname" class="rounded px-3 py-2 mt-5 mb-5 ml-2 border-2 border-gray-400 w-80 h-12" placeholder="Connect to any available user.." required>
       <button class="rounded px-3 py-2 w-30 h-12 bg-blue-400 font-lg font-bold text-gray-50" type="submit">Connect</button>   
       
       </form>      
       <c:forEach var="j" items="${nonfriends.rows}">
	        <div class="flex rounded card mb-4">
	         <img src="img/short_avatar.svg" class="w-10 h-10 mr-3"> 
	         <h3 class="text-lg font-semi-bold text-black-500">${j.uname}</h3>   
	        </div>
	      </c:forEach>
    </div>
    
    <sql:query dataSource="${db}" var="nonfriends">  
			SELECT * FROM users AS u LEFT JOIN relations AS r ON r.usermail="${email}"  AND u.email=r.frndmail AND r.status=TRUE WHERE STATUS IS NULL AND u.email!="${email}";  
	</sql:query>
	
	<sql:query dataSource="${db}" var="requests">  
			SELECT * from users AS u JOIN relations as r ON r.frndmail="${email}" WHERE u.email=r.usermail AND r.status=FALSE;  
	</sql:query>
	
    
   <div class="requests card shadow-md p-5">
   <h2 class="text-xl font-bold text-black-500 tracking-wide mb-4">Requests</h2>
   <hr class="text-gray-300 mt-2 font-semibold">
       <form action="accept" method="POST" class="mt-4">
       <input name="acceptname" class="rounded px-3 py-2 mt-5 mb-5 ml-2 border-2 border-gray-400 w-80 h-12" placeholder="Enter user name to accept request.." required>
       <button class="rounded px-3 py-2 w-30 h-12 bg-green-400 font-lg font-bold text-gray-50" type="submit">Add</button>
       </form>   
      
       <c:forEach var="j" items="${requests.rows}">
	        <div class="flex rounded card mb-4">
	         <img src="img/short_avatar.svg" class="w-10 h-10 mr-3"> 
	         <h3 class="text-lg font-semi-bold text-black-500">${j.uname}</h3>   
	        </div>
	      </c:forEach>
      
   </div>
  
  
  
  </div>
  
  
     
 </div> 
  
  
  
</body>
</html>