<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<title>Instructions </title>
	<link rel="stylesheet" type="text/css" href="css/mainstyle.css">
	<link rel="stylesheet" type="text/css" href="css/profiledstyle.css">
	<script type="text/javascript" src="js/functions.js"></script>
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
	<header>
		<h1>Quizy</h1>
		<div class="header-links">
			<h3><a href="profiled.jsp" >Back to profile</a></h3>
		</div>
	</header>

	<section>
		<h2>
			Create quiz
		</h2>
		<hr>
		<article>
			
			<h3> Some points to consider before proceeding: </h3>
			<ol class="user-instructions">
				<li>You will not be allowed to change the <strong>number of questions</strong> once entered. Be careful before you proceed.</li>
				<li>Make sure you have all your questions with you before you begin.</li>
				<li>You can create quiz only in one go, so don't leave the system if you haven't completed.</li>
				<li>This section only wants questions with answer choices you will supply. Additional data about quiz can be added later.</li>
				<li>Fill the number below to begin creation.</li>
			</ol>
		</article>
		<hr>
		<article class="for-input">
			<form action="creator.jsp" method="post" onsubmit="return validate_count();">
				<input type="text" id="qname" name="qname" value="" placeholder="Name your quiz">
				<input type="number" id="quescount" name="quescount" value="" placeholder="Number of questions">
				<input class="submit info" type="submit" name="submit" value="Begin">
			</form>
			
		</article>

	</section>

	<div class="spacing">
	</div>
	<footer>
		Copyright &copy; 2020 Mohd Aamir TMU Moradabad
	</footer>
</body>
</html>