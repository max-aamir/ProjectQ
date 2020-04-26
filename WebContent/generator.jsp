<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*,com.quizy.ConnectDb"%>
<!DOCTYPE html>
<html>
<head>
	<title>Generator</title>
	<link rel="stylesheet" type="text/css" href="css/mainstyle.css">
	<link rel="stylesheet" type="text/css" href="css/generatorstyle.css">
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
	String qid = request.getParameter("qid");
	%>
	<header>
		<h1>Quizy</h1>
		<div class="header-links">
			<h3><a href="profiled.jsp" >Back to profile</a></h3>
		</div>
	</header>

	<section>
		<h2>
			Fill below fields
		</h2>
		<hr>
		<article class="input-form">
			<form method="post" action="generated.jsp" class="result-form" id="result-form" onsubmit="return validate_rowCount();">
				<input type="radio" name="choice" value="all" onclick="return field_specificrow();" checked="checked"><label>All</label>
				<input type="radio" name="choice" value="specific" onclick="return field_specificrow();"><label>Specific</label>
				<input class="number" id="row-count" type="number" name="noofrows" placeholder="Number of rows to return" disabled>
				<input class="submit" type="submit" name="submit" value="Display">
				<input type="hidden" name="qid" value="<%= qid %>" >
				<input class="submit" onclick="export_csv()"type="button" name="export-result" value="Save as CSV" onclick="alert('Option will be available soon.');">
			</form>
		</article>
		<hr>
	</section>
	<div class="spacing">
	</div>
	<footer>
		Copyright &copy; 2020 Mohd Aamir TMU Moradabad
	</footer>
</body>
</html>