<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="styles.css">
    
</head>

<body>

<%
response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
if(session.getAttribute("username")!=null)
    response.sendRedirect("home.jsp");
%>

<div class="grid">
  <div class="titlesection grid grid-cols-2 mt-10">
    <div class="title text-2xl ml-20  tracking-wide text-blue-600 font-bold">
        BYON
    </div>
    <div class="loginoptions flex justify-end">
        <div class="login uppercase text-xs  tracking-wider text-blue-500 border-2 border-blue-500 px-3 py-2 font-bold rounded mr-5 cursor-pointer font-sans hover:text-gray-100 hover:bg-blue-500 transition ease-out duration-300" onclick="login()">
            <a href="index.jsp">Login</a>
        </div>
    </div>
    
  </div>
  <div class="formsection grid grid-cols-2">
    <div class="image mt-20 ml-10">
      <img src="img/social2.jpg"> 
    </div>
    <div class="form ml-5 mt-24 bg-white shadow-md rounded w-4/5 h-4/5 p-5" id="login">
        <h2 class="text-black-500 text-xl font-bold  tracking-wide">Reset Password</h2>
        <hr class="text-gray-300 mt-2 font-semibold">
        <form class="mt-5" action=reset method="POST">
            <input class="w-full h-12 p-2 border-2 rounded border-black-200 font-semi-bold text-lg mr-2" placeholder="Email" name="email" type="email" required>
            <input class="w-full mt-4 h-12 p-2 border-2 rounded border-black-200 font-semi-bold text-lg inline-block"
                placeholder="Enter new Password" type="password" required name="newpass">
            <input class="w-full mt-4 h-12 p-2 border-2 rounded border-black-200 font-semi-bold text-lg inline-block"
                placeholder="Re-enter new password" type="password" required name="confirmpass">    
            <button type="submit"
                class="mt-10 w-full h-12 rounded text-center text-white bg-blue-500 text-xl font-bold">Reset</button>
        </form>
    
    </div>
  </div>

</div>

<script src="index.js"></script>
</body>

</html>