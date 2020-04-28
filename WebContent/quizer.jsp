<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<title>Quizer </title>
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
	<%
		response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
		if(session.getAttribute("whosthisadmin")==null){
			response.sendRedirect("login.jsp");
		}
	%>
	<%
		if(request.getParameter("result")!=null){
			String str  = request.getParameter("result");
			if(str.equals("CreateSuccess")){
				out.print("<script>alert('All provided questions are added. You can host this quiz now.');</script>");
				}
 			else if(str.equals("EditSuccess")){
				out.print("<script>alert('You have successfully edited your quiz');</script>");
				}
 			else if(str.equals("DeleteSuccess")){
				out.print("<script>alert('Quiz deletion successful.');</script>");
				response.sendRedirect("logout.jsp");
			} 
		}
	%>
	<header>
		<h1>Quizy</h1>
		<div class="header-links">
			<h3><a href="profiled.jsp" >Back to profile</a></h3>
		</div>
	</header>

	<section>
		<h2>
			Quizer
		</h2>
		<hr>
		<article>
			
			<ul  class="user-options">
				<li><a href="create.jsp">Create quiz</a></li>
				<li><a href="edit.jsp">Edit quiz</a></li>
				<li><a href="delete.jsp">Delete quiz</a></li>
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