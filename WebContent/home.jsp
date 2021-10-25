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
<style>
  .dropdown:hover .dropdown-menu {
  display: block;
}

</style>
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
        <a  href="posts.jsp" class="text-black-400 text-lg tracking-wide mr-3 cursor-pointer">Feed</a>
        <a href="home.jsp" class="text-black-400 text-lg tracking-wide mr-4 cursor-pointer border-b-2 rounded-sm border-blue-600">Home</a>
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
  <sql:query dataSource="${db}" var="count">  
		SELECT COUNT(*) FROM users AS u JOIN relations AS r ON r.usermail="${email}" AND u.email=r.frndmail AND r.status=TRUE;  
   </sql:query> 
  
   <sql:query dataSource="${db}" var="rs">  
		SELECT u.uname FROM users AS u JOIN relations AS r ON r.usermail="${email}" AND u.email=r.frndmail AND r.status=TRUE;  
   </sql:query>  
  
  <div class="master flex">
    	<div class="nav-section flex bg-white-50 w-2/6  rounded shadow-md card pt-10 pb-10 ml-10 mt-10 pl-10"> 
    	     <div class=" w-2/6 h-2/6 mr-7">
    	     	<img src="img/profile.svg" class="justify-center">
    	     </div> 
    	     <div class="flex-col mt-2">
    	      <c:forEach var = "user" items = "${users.rows}">
    	        <h2 class="mt-2  font-bold text-lg text-black-500 tracking-wider">${user.uname}</h2>
    	     <h3 class="mt-2 font-semi-bold text-lg text-black-500">${user.dob }</h3>
    	     <div class="mx-auto mt-2">
    	        <c:forEach items="${count.rows}" var="j">
    	     	<h4 class="inline-block  text-lg font-bold text-black-500">${j["COUNT(*)"]}</h4>
    	     	</c:forEach>
    	     <h4 class="text-lg text-black-500 font-semi-bold inline-block">Friends</h4>
    	     </div>
    	     <h5 class="text-lg  text-black-500 mt-2 tracking-wide">${user.gen}</h5>
    	     </c:forEach>
    	     <div class="flex mt-10">
    	    	 <a href="profile.jsp"><button class="px-3 tracking-wide py-2 rounded bg-yellow-400 text-lg font-semi-bold mr-2 text-gray-50">Edit Profile</button></a>
    	       <a href="myposts.jsp"><button class="px-3 py-2 tracking-wide rounded bg-green-500 text-lg font-semi-bold text-gray-50">My Posts</button></a> 
    	    </div>
    	     </div>
   		</div>
   		<div class="posts flex-col ml-10 mt-10 w-1/2 h-4/5">
   		  <div class="create-post card shadow-md rounded p-5">
   		  <h1 class="text-lg tracking-wider text-black-500 font-bold">Create a Post</h1>
   		  <hr class="text-gray-300 mt-2 font-semibold">
   		  <img src="" class=" mt-2 w-full h-3/5 rounded hidden" id="postimage"/> 		  
   		  <form class="mt-4" action="post" method="POST">
   		      	<textarea class="resize border rounded w-full h-40 p-5 text-lg font-semi-bold text-black-500" name="postcontent" placeholder="Write Something....."></textarea>
   		      	<button class="inline-block px-3 py-2 rounded text-gray-50 bg-blue-500 w-20 h-12 font-semi-bold text-lg tracking-wider mt-3" type="submit">Post</button>	  
   		      	<input id="fileurl" name="url" class="hidden" value=""> 
   		  </form>
   		  <div class="mt-2">
   		  <input type="file" id="files" multiple /><br /><br />
			<button id="send" class="px-3 py-2 rounded text-gray-50 bg-red-400 w-20 h-12 font-semi-bold text-sm tracking-wider mt-1">Upload</button>
			<p id="uploading"></p>
			<progress value="0" max="100" id="progress"></progress>
   		  </div>
   		    
   		    
   		    
   		  </div>		
   		</div>
   		
   		
   </div>	
 </div> 
  
<script src="https://www.gstatic.com/firebasejs/8.2.1/firebase-app.js"></script>

<script src="https://www.gstatic.com/firebasejs/7.13.1/firebase-storage.js"></script>       


<script src="https://www.gstatic.com/firebasejs/8.2.1/firebase-analytics.js"></script>

<script>
  // Your web app's Firebase configuration
  // For Firebase JS SDK v7.20.0 and later, measurementId is optional
  var firebaseConfig = {
    apiKey: "AIzaSyBGEyQjj_yV-2rSbRpfdVF16ma6s23V24k",
    authDomain: "sarathjava-4b970.firebaseapp.com",
    projectId: "sarathjava-4b970",
    storageBucket: "sarathjava-4b970.appspot.com",
    messagingSenderId: "1011257643309",
    appId: "1:1011257643309:web:36b83bcff0a6650a2283a4",
    measurementId: "G-LYT0XDR7NM"
  };
  // Initialize Firebase
  firebase.initializeApp(firebaseConfig);
  firebase.analytics();
</script>
  
<script>
var files = [];
document.getElementById("files").addEventListener("change", function(e) {
  files = e.target.files;
  for (let i = 0; i < files.length; i++) {
    console.log(files[i]);
  }
});

document.getElementById("send").addEventListener("click", function() {
  //checks if files are selected
  if (files.length != 0) {
    //Loops through all the selected files
    for (let i = 0; i < files.length; i++) {
      //create a storage reference
      var storage = firebase.storage().ref(files[i].name);
      var upload = storage.put(files[i]);

      upload.on("state_changed",function progress(snapshot) {
          var percentage =(snapshot.bytesTransferred / snapshot.totalBytes) * 100;
          document.getElementById("progress").value = percentage;},
        function error() {
          alert("error uploading file");
        },
        function complete() {
             storage.getDownloadURL()
             .then(function(url) {
            	 console.log(url);
            	 document.getElementById("fileurl").value=url;
            	 document.getElementById("postimage").src = url;
            	 document.getElementById("postimage").style.display="block";
            	 
            	 })
             .catch(function(error) {console.log("error encountered");});
    });
        
  } 
    
 }   
});


</script>  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
</body>
</html>