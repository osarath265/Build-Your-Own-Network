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
            Login
        </div>
        <div class="signup uppercase text-xs tracking-wider text-blue-500 border-2 border-blue-500 mr-10 px-3 py-2 font-bold rounded cursor-pointer font-sans hover:text-gray-100 hover:bg-blue-500 transition ease-out duration-300" onclick="signup()">
            Signup
        </div>
    </div>
    
  </div>
  <div class="formsection grid grid-cols-2">
    <div class="image mt-20 ml-10">
      <img src="img/social2.jpg"> 
    </div>
    <div class="form ml-5 mt-24 bg-white shadow-md rounded w-4/5 h-4/5 p-5" id="signup">
    <h2 class="text-black-500 text-xl font-bold  tracking-wide">Sign up</h2>
    <hr class="text-gray-300 mt-2 font-semibold">
     <form class="mt-5" action="test" method="POST">
        <input class="w-2/5 h-12 p-2 border-2 rounded border-black-200 font-semi-bold text-lg mr-2" placeholder="First Name" name="fname" required>
        <input class="w-2/5 h-12 p-2 border-2 rounded border-black-200 font-semi-bold text-lg inline-block" placeholder="Last Name" name="lname" required>
        <input class="w-5/6 h-12 p-2 mt-4 border-2 rounded border-black-200 font-semi-bold text-lg" placeholder="Email" name="email" required>
        <input class="w-5/6 h-12 p-2 mt-4 border-2 rounded border-black-200 font-semi-bold text-lg inline-block" placeholder="Password" name="password" type="password" required>
        <input class="w-2/5 h-12 p-2 mt-4 mr-2 border-2 rounded border-black-200 font-semi-bold text-lg" placeholder="Date"  name="dob" type="date" required>
        <select class="w-2/5 h-12 p-2 mt-4 border-2 rounded border-black-200 font-semi-bold text-lg" name="gen" required>
            <option value="Male">Male</option>
            <option value="Female">Female</option>
        </select>
        <button type="submit" class="mt-5 w-2/5 h-12 rounded text-center text-white bg-green-500 text-xl font-bold">Create Account</button>
     </form>
    </div>
    <div class="form ml-5 hidden mt-24 bg-white shadow-md rounded w-3/5 h-4/5 p-10" id="login">
        <h2 class="text-black-500 text-xl font-bold  tracking-wide">Login</h2>
        <hr class="text-gray-300 mt-2 font-semibold">
        <form class="mt-5" action="login" method="POST">
            <input class="w-full h-12 p-2 border-2 rounded border-black-200 font-semi-bold text-lg mr-2" placeholder="Email" name="email" required>
            <input class="w-full mt-4 h-12 p-2 border-2 rounded border-black-200 font-semi-bold text-lg inline-block"
                placeholder="Password" type="password" required name="password">
            <div class="flex mt-4">
                <div class="flex-grow"></div>
            	<a href="forpass.jsp" class="tracking-wide text-black-500 font-semi-bold text-sm hover:text-red-300">Forgot Password?</a>
            </div>   
            
            <button type="submit"
                class="mt-5 w-full h-12 rounded text-center text-white bg-blue-500 text-xl font-bold">Login</button>
        </form>
    
    </div>
  </div>

</div>

<script src="index.js"></script>
</body>

</html>