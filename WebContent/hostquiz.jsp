<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*,com.quizy.ConnectDb"%>
<!DOCTYPE html>
<html>
<head>
	<title>Quiz Dashboard</title>
<link rel="stylesheet" type="text/css" href="css/mainstyle.css">
	<link rel="stylesheet" type="text/css" href="css/indexstyle.css">
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
	<%!	String eid;
%>
	<%
		response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
		if(session.getAttribute("whosthisadmin")==null){
			
			response.sendRedirect("login.jsp");
		}
		else{
			eid = String.valueOf(session.getAttribute("admineid"));
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
			Created quizes waiting to be hosted
		</h2>
		<hr>
<%
			String qname, rdate,qinfo,qid,quescount;
			qid=qname=rdate=qinfo="";
			String rd;
			rd="";
			int flag=0; 
			String sql="";
			sql = "select qname,rdate,quiz.qid,quescount from quiz INNER JOIN creator ON quiz.qid=creator.qid where ?=creator.adminid and rdate IS null;";
			Connection con = ConnectDb.getConnection();
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1,eid);
			ResultSet rs = ps.executeQuery();
			if(rs.next()){
				qname=rs.getString(1);
				rdate=rs.getString(2);				
				qid=rs.getString(3);
				quescount=rs.getString(4);
				if(rdate!=null)
					rd = rdate.substring(8,10)+"-"+rdate.substring(5,7)+"-"+rdate.substring(0,4)+" "+rdate.substring(10);
				else	
					rd="not mentioned";
				flag=1;
			}
			if(flag==0){
				out.print("<article class=\"upcoming-quiz-article no-quiz\"><h4 class=\"upcoming-quiz-head\">No Quiz Created</h4><h5 class=\"upcoming-quiz-date\"></h5><h5 class=\"upcoming-quiz-read\"></h5></article>");
			}
			else{
				out.print("<article class=\"upcoming-quiz-article\"><h4 class=\"upcoming-quiz-head\">"+qname+"</h4><h5 class=\"upcoming-quiz-date\">Register by: "+rd+"</h5><form method=\"post\" action=\"quizhosting.jsp\" ><input type=\"hidden\" name=\"qid\" value=\""+qid+"\"><input class=\"submit\"  type=\"submit\" value=\"Host\"></form></article>");
				while(rs.next()){
					
					qname=rs.getString(1);
					rdate=rs.getString(2);
					qid=rs.getString(3);
					quescount=rs.getString(4);
					if(rdate!=null)
						rd = rdate.substring(8,10)+"-"+rdate.substring(5,7)+"-"+rdate.substring(0,4)+" "+rdate.substring(10);
					else	
						rd="not mentioned";
					out.print("<article class=\"upcoming-quiz-article\"><h4 class=\"upcoming-quiz-head\">"+qname+"</h4><h5 class=\"upcoming-quiz-date\">Register by: "+rd+"</h5><form method=\"post\" action=\"quizhosting.jsp\" ><input type=\"hidden\" name=\"qid\" value=\""+qid+"\"><input class=\"submit\" type=\"submit\" value=\"Host\"></form></article>");
				}
			}
		%>
<%con.close();%>
	</section>
	
	<div class="spacing">
	</div>
	<footer>
		Copyright &copy; 2020 Mohd Aamir TMU Moradabad
	</footer>

</body>
</html>