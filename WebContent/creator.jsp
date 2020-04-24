<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*,com.quizy.ConnectDb"
    errorPage="error.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>Add questions</title>
	<link rel="stylesheet" type="text/css" href="css/mainstyle.css">
	<link rel="stylesheet" type="text/css" href="css/creatorstyle.css">
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
	<%!	String eid,fullName,quescount,qname,sql,qid;
		int flag=0,quesn;
		%>
	<%
	response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
	if(session.getAttribute("whosthisadmin")==null){
		response.sendRedirect("login.jsp");
	}
	Connection con = ConnectDb.getConnection();
	
	eid=fullName=quescount=qname="";
	if(request.getAttribute("qid")==null){
	eid = String.valueOf(session.getAttribute("admineid"));
	fullName =  String.valueOf(session.getAttribute("whosthisadmin"));
	quescount = request.getParameter("quescount");
	qname = request.getParameter("qname");
	sql = "insert into quiz(qname,quescount) values(?,?)";
	PreparedStatement ps=con.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS);
	ps.setString(1,qname);
	ps.setString(2,quescount);
	int status=ps.executeUpdate();
		if(status>=1){
			flag=1;
			quesn=1;
			ResultSet rs = ps.getGeneratedKeys();
			if(rs.next()){
				qid = rs.getString(1);
				PreparedStatement ps2 = con.prepareStatement("insert into creator(adminid,qid) values('"+eid+"',"+qid+")");
				int st = ps2.executeUpdate();
				if(st<1){
					response.sendRedirect("error.jsp");
				}
			}
		}
		else{
			flag=0;
			response.sendRedirect("error.jsp");
		}
	}
	else{
		flag=1;
		qid=String.valueOf(request.getAttribute("qid"));
		quesn++;
		quescount = request.getParameter("quescount");
	}
	
	
	%>
	<header>
		<h1>Quizy</h1>
	</header>

	<section>
		<aside>
			Ques. <%=quesn %>
		</aside>
		<article>
			<form method="post" class="form-group" action="Creator" onsubmit="return validate_create();">
				<div class="outer">
					<div class="inner-one">
						<textarea class="ques" id="ques" name="ques" placeholder="Enter question"></textarea>
					</div>
					<div class="inner-two">
						<input class="ans" id="c1" type="text" name="c1" placeholder="Choice 1">
						<input class="ans" id="c2" type="text" name="c2" placeholder="Choice 2">
						<input class="ans" id="c3"  type="text" name="c3" placeholder="Choice 3">
						<input class="ans" id="c4"  type="text" name="c4" placeholder="Choice 4">
					</div>
				</div>
				<input class="info" type="number"  id="nmarks" name="nmarks" placeholder="Negative marks">
				<input class="info" type="number"  id="marks" name="marks" placeholder="Marks">
				<input class="info" type="number"  id="cc" name="cc" placeholder="Correct choice">
				<input class="info-subject" type="text"  id="topic"  name="topic" placeholder="Subject of question">
				<label class="difficulty-radio">Difficulty</label>
				<select name="diff" id="diff">
					<option  value="none" selected>None</option>
					<option  value="easy">Easy</option>
					<option  value="medium">Medium</option>
					<option  value="hard">Hard</option>
				</select>
				<input type="hidden" name="qid" value="<%= qid %>">
				<input type="hidden" name="quesn" value="<%= quesn %>">
				<input type="hidden" name="quescount" value="<%= quescount %>">
				<input class="submit" type="submit" name="submit" value="Save & Next">
				<input class="reset" type="reset" name="reset" value="Clear all">
			</form>
		</article>
	</section>
<%con.close();%>
	<div class="spacing">
	</div>
	<footer>
		Copyright &copy; 2020 Mohd Aamir TMU Moradabad
	</footer>
</body>
</html>