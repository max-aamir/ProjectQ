<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<title>Push quiz online</title>
	<link rel="stylesheet" type="text/css" href="css/mainstyle.css">	
	<link rel="stylesheet" type="text/css" href="css/quizhostingstyle.css">
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
	<%!	String eid,qid="";
%>
	<%
		response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
		if(session.getAttribute("whosthisadmin")==null){
			
			response.sendRedirect("login.jsp");
		}
		else{
			eid = String.valueOf(session.getAttribute("admineid"));
			qid = request.getParameter("qid");
		}
		
		%>
	<header>
		<h1>Quizy</h1>
		<div class="header-links">
			<h3><a href="profiled.jsp" >Back to profile</a></h3>
		</div>
	</header>

	<section>
		<aside>
			About Quiz
		</aside>
		<article>
			<form method="post" class="form-group" onsubmit="return validate_quizhosting()" action="Host">
				<div class="outer">
					<div class="inner-one">
						<textarea class="ques" id="qinfo" name="qinfo" placeholder="Add quiz information to be displayed to the candidates"></textarea>
					</div>
					<div class="inner-two">
						Start date and time: <input class="info" id="sdate" name="sdate" type="datetime-local" name="start-date" placeholder="Start Date">
						End date and time: <input class="info" id="edate" name="edate" type="datetime-local" name="end-date" placeholder="End Date">
						Last date to register:<input class="info" id="rdate" name="rdate" type="datetime-local" name="r-date" placeholder="">
					</div>
				</div>
				<input class="info" id="duration" type="number" name="duration" placeholder="Duration in minutes">
				<label class="difficulty-radio">Difficulty</label>
				<select name="diff" id="difficulty">
					<option value="none">None</option>
					<option  value="easy">Easy</option>
					<option  value="medium">Medium</option>
					<option  value="hard">Hard</option>
				</select>
				<input type="hidden" name="qid" value="<%= qid %>">
				<input class="submit" type="submit" name="submit" value="Send Online">
				<input class="reset" type="reset" name="reset" value="Reset">
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
    