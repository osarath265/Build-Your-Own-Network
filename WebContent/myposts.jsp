<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>   


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>BYON</title>
</head>
<link rel="stylesheet" href="styles.css">
<body>
   <%
      response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
      if(session.getAttribute("username")==null)
      response.sendRedirect("index.jsp");
  %>
  <div class="home w-screen h-screen">
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
         <sql:setDataSource var="db" driver="com.mysql.cj.jdbc.Driver"  
     			url="jdbc:mysql://localhost:3306/testing"  
     		user="root"  password=""/>
     
  		<sql:query dataSource="${db}" var="posts">  
			SELECT * from posts where email="${email}" ORDER BY post_time DESC;  
		</sql:query>
  
  <div class="posts flex-col mx-80 mt-10 w-1/2 ">
   		  <div class="post rounded p-5">
   		  <h1 class="text-lg tracking-wider text-black-500 font-bold">My Posts</h1>
   		  <hr class="text-gray-300 mt-2 font-semibold">
   		  <c:forEach var="j" items="${posts.rows}" >
	        <div class="rounded card shadow-md mb-4 p-5 mt-3">
	         <div class="flex rounded mb-4">
	         <img src="img/short_avatar.svg" class="w-10 h-10 mr-3"> 
	         <h3 class="text-lg font-semi-bold text-black-500 tracking-wide">Me</h3>   
	        </div>
	        <hr class="text-gray-300 mt-2 font-semibold">
	        <c:if test="${j.image!=null}">
	        <img src="${j.image}" class=" mt-2 w-full h-3/5 rounded "/> 
	        </c:if>
	         <p  class="text-lg text-black-500 w-full h-auto p-5 text-lg font-semi-bold text-black-500">${j.content}</p>
	         <div class="flex">
	            <sql:query dataSource="${db}" var="likes">  
			   		SELECT COUNT(*) from likes where postid="${j.postid}";
				</sql:query>
				<sql:query dataSource="${db}" var="dislikes">  
			   		SELECT COUNT(*) from dislikes where postid="${j.postid}";
				</sql:query>
				
				 <c:forEach items="${likes.rows}" var="k">
				 <span class="flex text-lg font-bold text-black-500">
				 <img src="img/fblike.svg" class="w-7 h-7 mr-3">
    	     			${k["COUNT(*)"]}
				 </span>
				 
    	     	</c:forEach>
    	     	<c:forEach items="${dislikes.rows}" var="k">
				 <span class="flex text-lg font-bold text-black-500 ml-3">
				 <img src="img/dislike.svg" class="w-7 h-7 mr-3">
    	     			${k["COUNT(*)"]}
				 </span>
				 
    	     	</c:forEach>  
	           <div class="flex-grow"></div>
	         </div>
	          <form action="comment" method="POST" class="mt-2">
	                <input class="hidden" value="${j.postid}" name="id">
       				<input name="commentcontent" class="rounded px-3 py-2 mt-5 mb-5 ml-2 border-2 border-gray-400 w-80 h-12" placeholder="Add your comments..."  required>
       				<button class="rounded px-3 py-2 w-30 h-12 bg-blue-400 font-lg font-bold text-gray-50" type="submit">Comment</button>   
      		 </form>
      		 <h1 class="text-sm mt-2 tracking-wider text-black-500 font-bold">Comments</h1>
   		  	 <hr class="text-gray-300 mt-2 font-semibold">
      		  <sql:query dataSource="${db}" var="comments">  
			   		SELECT * FROM comments JOIN users ON comments.email=users.email WHERE comments.postid="${j.postid}";
			  </sql:query>
      		  <c:forEach var="cm" items="${comments.rows}">
      		     <div class="mb-2 card rounded bg-gray-100 p-3 mt-2">
      		     <h5 class="font-bold text-black-400 text-sm">${cm.uname}</h5>
      		     <p class="text-xs">${cm.content}</p>
      		     </div>
      		     
      		  </c:forEach> 
      		  
	        </div>
	      </c:forEach>
   		  </div>		
   		  
   		</div>
   		
  
  </div> 
   
   
   
   
</body>
</html>