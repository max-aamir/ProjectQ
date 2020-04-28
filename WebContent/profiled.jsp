<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<title>Admin profile </title>
	<link rel="stylesheet" type="text/css" href="css/mainstyle.css">
	<link rel="stylesheet" type="text/css" href="css/profiledstyle.css">
	<script type="text/javascript" src="js/info.js"></script>
	<link rel="stylesheet" type="text/css" href="css/infostyle.css">
</head>
<body>
	<div id="infobtn"  onclick="open_info()"><img src="img/infoblue.png"></div>
	<div class="modal-info" id="modal-info">
		<div class="modal-content">
			<span class="closeBtn" onclick="close_info()">&times;</span>
			<h3>Help </h3>
			<p>Contact the organizing team for any query. </p>
		</div>
	</div>
	<%! String username; %>
	<%
		response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
		if(session.getAttribute("whosthisadmin")==null){
			response.sendRedirect("login.jsp");
		}
		else{
			username = String.valueOf(session.getAttribute("whosthisadmin"));
		}
		if(request.getParameter("result")!=null){
			String str  = request.getParameter("result");
			if(str.equals("HostingSuccess")){
				out.print("<script>alert('You have successfully hosted your quiz');</script>");
			}
		}
	%>
	<header>
		<h1>Quizy</h1>
		<div class="header-links">
			<h3><a href="logoutd.jsp" >Logout</a></h3>
		</div>
	</header>

	<section>
		<h2>
			Welcome <%= username %>
		</h2>
		<hr>
		<article>
			
			<ul  class="user-options">
				<li><a href="#">Change password</a><small>&nbsp;&nbsp;&nbsp;Will be added later</small></li>
				<!-- <li><a href="#">Participate</a></li> -->
				<li><a href="quizer.jsp">Quizer - the quiz creator</a></li>
				<li><a href="hostquiz.jsp">Host Quiz</a></li>
				<li><a href="generate.jsp">Generate result</a></li>
				

			</ul>
		</article>

	</section>

	<div class="spacing">
	</div>
	<footer>
		Copyright &copy; 2020 Mohd Aamir TMU Moradabad
	</footer>
</body>
</html>