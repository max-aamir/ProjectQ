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
<%!
	PreparedStatement ps;
	String uid,fullName,crtcount,incrtcount,crtmarks,incrtmarks,totalmarks,choice,noofrows,qid;
	String sql="";
	ResultSet rs;
%>
<%
	response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
	if(session.getAttribute("whosthisadmin")==null){
		response.sendRedirect("login.jsp");
	}
	Connection con = ConnectDb.getConnection();
	choice = request.getParameter("choice");
	noofrows = request.getParameter("noofrows");
	qid = request.getParameter("qid");
	if(qid==null){
		response.sendRedirect("error.jsp");
	}
	if(choice.equals("all"))
		sql = "select * from generatedResult_"+qid+" order by totalmarks desc";
	else if(choice.equals("specific"))
		sql = "select * from generatedResult_"+qid+" order by totalmarks desc "+" LIMIT "+noofrows;
	ps = con.prepareStatement(sql);
	rs = ps.executeQuery();
	
	%>
	<header>
		<h1>Quizy</h1>
		<div class="header-links">
			<h3><a href="generate.jsp" >Back</a></h3>
		</div>
	</header>

	<section class="result-section">
		<table class="result-table">
			<tr>
				<th>Enrollment ID</th>
				<th>Name</th>
				
				<th>Correct Count</th>
				<th>Incorrect Count</th>
				<th>Marks</th>
				<th>Negative marks</th>
				<th>Total marks</th>
				
			</tr>
			
			<%
				while(rs.next()){
					
					uid = rs.getString(1);
					fullName = rs.getString(2);
					crtcount = rs.getString(3);
					incrtcount = rs.getString(4);
					crtmarks = rs.getString(5);
					incrtmarks = rs.getString(6);
					totalmarks = rs.getString(7);
					
					out.print("<tr>");
					out.print("<td>"+uid+"</td>");
					out.print("<td>"+fullName+"</td>");
					out.print("<td>"+crtcount+"</td>");
					out.print("<td>"+incrtcount+"</td>");
					out.print("<td>"+crtmarks+"</td>");
					out.print("<td>"+incrtmarks+"</td>");
					out.print("<td>"+totalmarks+"</td>");
					out.print("</tr>");
				}
			%>	
		 </table>
	</section>
<%con.close();%>
	<div class="spacing">
	</div>
	<footer>
		Copyright &copy; 2020 Mohd Aamir TMU Moradabad
	</footer>
</body>
</html>