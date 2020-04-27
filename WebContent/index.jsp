<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*,com.quizy.ConnectDb"%>
<!DOCTYPE html>
<html>
<head>
	<title>Quizy - Online Assessment for All</title>
	<link rel="stylesheet" type="text/css" href="css/mainstyle.css">
	<link rel="stylesheet" type="text/css" href="css/indexstyle.css">
	<link href="css/popupstyle.css" rel="stylesheet">
	<script type="text/javascript" src="js/modal_functions.js"></script>
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
		if(request.getParameter("result")!=null){
			String str  = request.getParameter("result");
			if(str.equals("AttemptSuccess")){
				out.print("<script>alert('All your responses are saved. Thanks for attempting. You may close this window.');</script>");
				}
			else if(str.equals("DuplicateAttempt")){
				out.print("<script>alert('You have already attempted this quiz.');</script>");
			}
			else if(str.equals("UserFailure")){
				out.print("<script>alert('User Sign up failed either you already have a profile or something unknown happened.');</script>");
			}
			else if(str.equals("AdminFailure")){
				out.print("<script>alert('Admin Sign up failed either you are already registered, entered wrong Key or something unknown happened.');</script>");
			}
			else if(str.equals("UserSuccess")){
				out.print("<script>alert('User Sign up complete, you can login now.');</script>");
			}
			else if(str.equals("AdminSuccess")){
				out.print("<script>alert('Admin Sign up complete, you can login now.');</script>");
			}
			else if(str.equals("NotRegistered")){
				out.print("<script>alert('You have not registered for the quiz. Sorry, you can not participate.');</script>");
			}
			else if(str.equals("adminlogoutSuccess")){
				out.print("<script>alert('You are successfully logged out');</script>");
				}
			else if(str.equals("userlogoutSuccess")){
				out.print("<script>alert('You are successfully logged out');</script>");
				}
			else {
				out.print("<script>alert('Unknown error caused this.');</script>");
			}
		}
		
	%>
	<header>
		<h1>Quizy</h1>
		<div class="header-links">
			<h3><a href="signup.jsp" >Sign up </a></h3>
			<h3><a href="login.jsp">Login </a></h3>
		</div>
	</header>

	<section>
		<h2>
			Upcoming Quizes
		</h2>
		<hr>
		<%
			String qname, rdate,qinfo,sdate,qid,edate;
			edate=qid=qname=rdate=qinfo=sdate="";
			String rd,sd,ed;
			rd=sd=ed="";
			int flag=0,modalCount=0; 
			String sql="";
			
			//	upcoming where current date time is less than start date
			sql = "select qname,rdate,qinfo,sdate,qid,edate from quiz where sdate > now();";
			Connection con = ConnectDb.getConnection();
			PreparedStatement ps = con.prepareStatement(sql);
			
			ResultSet rs = ps.executeQuery();
			if(rs.next()){
				qname=rs.getString(1);
				rdate=rs.getString(2);
				qinfo=rs.getString(3);
				sdate=rs.getString(4);
				qid=rs.getString(5);
				edate=rs.getString(6);
				rd = rdate.substring(8,10)+"-"+rdate.substring(5,7)+"-"+rdate.substring(0,4)+" "+rdate.substring(10);
				sd = sdate.substring(8,10)+"-"+sdate.substring(5,7)+"-"+sdate.substring(0,4)+" "+sdate.substring(10);
				ed = edate.substring(8,10)+"-"+edate.substring(5,7)+"-"+edate.substring(0,4)+" "+edate.substring(10);
				modalCount++;
				flag=1;
			}
			if(flag==0){
				out.print("<article class=\"upcoming-quiz-article no-quiz\"><h4 class=\"upcoming-quiz-head\">No Quiz Available</h4><h5 class=\"upcoming-quiz-date\"></h5><h5 class=\"upcoming-quiz-read\"></h5></article>");
			}
			else{
				out.print("<article onclick=\"open_modal("+modalCount+")\" class=\"upcoming-quiz-article\"><h4 class=\"upcoming-quiz-head\">"+qname+"</h4><h5 class=\"upcoming-quiz-date\">Register by: "+rd+"</h5><h5 class=\"upcoming-quiz-read\"><a onclick=\"open_modal("+modalCount+")\" class=\"upcoming-quiz-link\">Read more</a></h5></article>");
				
				out.print("<div class=\"modal-one\" id=\"modal-"+modalCount+"\"><div class=\"modal-content\"><span class=\"closeBtn\" onclick=\"close_modal("+modalCount+")\">&times;</span><h3> "+qname+" &nbsp; <small>Begins:  "+sd+" &nbsp; Ends: "+ed+" </small></h3><p>"+qinfo+"</p><h5>Login to participate</h5></div></div>");
				while(rs.next()){
					modalCount++;
					qname=rs.getString(1);
					rdate=rs.getString(2);
					qinfo=rs.getString(3);
					sdate=rs.getString(4);
					qid=rs.getString(5);
					edate=rs.getString(6);
					rd = rdate.substring(8,10)+"-"+rdate.substring(5,7)+"-"+rdate.substring(0,4)+" "+rdate.substring(10);
					sd = sdate.substring(8,10)+"-"+sdate.substring(5,7)+"-"+sdate.substring(0,4)+" "+sdate.substring(10);
					ed = edate.substring(8,10)+"-"+edate.substring(5,7)+"-"+edate.substring(0,4)+" "+edate.substring(10);
					modalCount++;
					out.print("<article onclick=\"open_modal("+modalCount+")\" class=\"upcoming-quiz-article\"><h4 class=\"upcoming-quiz-head\">"+qname+"</h4><h5 class=\"upcoming-quiz-date\">Register by: "+rd+"</h5><h5 class=\"upcoming-quiz-read\"><a onclick=\"open_modal("+modalCount+")\" class=\"upcoming-quiz-link\">Read more</a></h5></article>");
					
					out.print("<div class=\"modal-one\" id=\"modal-"+modalCount+"\"><div class=\"modal-content\"><span class=\"closeBtn\" onclick=\"close_modal("+modalCount+")\">&times;</span><h3> "+qname+" &nbsp; <small>Begins:  "+sd+" &nbsp; Ends: "+ed+" </small></h3><p>"+qinfo+"</p><h5>Login to participate</h5></div></div>");
				}
			}
		%>
	</section>
	<section>
		<h2>
			Ongoing Quizes
		</h2>
		<hr>
				<%
			sql = "select qname,rdate,qinfo,sdate,qid,edate from quiz where sdate <= now() and edate >= now();";
			PreparedStatement p = con.prepareStatement(sql);
			rs = p.executeQuery();
			flag=0;
			if(rs.next()){
				qname=rs.getString(1);
				rdate=rs.getString(2);
				qinfo=rs.getString(3);
				sdate=rs.getString(4);
				qid=rs.getString(5);
				edate=rs.getString(6);
				rd = rdate.substring(8,10)+"-"+rdate.substring(5,7)+"-"+rdate.substring(0,4)+" "+rdate.substring(10);
				sd = sdate.substring(8,10)+"-"+sdate.substring(5,7)+"-"+sdate.substring(0,4)+" "+sdate.substring(10);
				ed = edate.substring(8,10)+"-"+edate.substring(5,7)+"-"+edate.substring(0,4)+" "+edate.substring(10);
				modalCount++;
				flag=1;
			}
			if(flag==0){
				out.print("<article class=\"ongoing-quiz-article no-quiz\"><h4 class=\"upcoming-quiz-head\">No Ongoing quizes</h4><h5 class=\"upcoming-quiz-date\"></h5><h5 class=\"upcoming-quiz-read\"></h5></article>");
			}
			else{
				out.print("<article onclick=\"open_modal("+modalCount+")\"  class=\"ongoing-quiz-article\"><h4 class=\"upcoming-quiz-head\">"+qname+"</h4><h5 class=\"upcoming-quiz-date\">Register by: "+rd+"</h5><h5 class=\"upcoming-quiz-read\"><a onclick=\"open_modal("+modalCount+")\" class=\"upcoming-quiz-link\">Read more</a></h5></article>");
				
				out.print("<div class=\"modal-one\" id=\"modal-"+modalCount+"\"><div class=\"modal-content\"><span class=\"closeBtn\" onclick=\"close_modal("+modalCount+")\">&times;</span><h3> "+qname+" &nbsp; <small>Begins:  "+sd+" &nbsp; Ends: "+ed+" </small></h3><p>"+qinfo+"</p><form method=\"post\" action=\"Takequiz\"><input type=\"hidden\" name=\"qid\" value=\""+qid+"\"><input class=\"submitpop\" type=\"submit\" value=\"Take Now\"></form></div></div>");
				while(rs.next()){
					modalCount++;
					qname=rs.getString(1);
					rdate=rs.getString(2);
					qinfo=rs.getString(3);
					sdate=rs.getString(4);
					qid=rs.getString(5);
					edate=rs.getString(6);
					rd = rdate.substring(8,10)+"-"+rdate.substring(5,7)+"-"+rdate.substring(0,4)+" "+rdate.substring(10);
					sd = sdate.substring(8,10)+"-"+sdate.substring(5,7)+"-"+sdate.substring(0,4)+" "+sdate.substring(10);
					ed = edate.substring(8,10)+"-"+edate.substring(5,7)+"-"+edate.substring(0,4)+" "+edate.substring(10);
					modalCount++;
					out.print("<article onclick=\"open_modal("+modalCount+")\"  class=\"ongoing-quiz-article\"><h4 class=\"upcoming-quiz-head\">"+qname+"</h4><h5 class=\"upcoming-quiz-date\">Register by: "+rd+"</h5><h5 class=\"upcoming-quiz-read\"><a onclick=\"open_modal("+modalCount+")\" class=\"upcoming-quiz-link\">Read more</a></h5></article>");
					
					out.print("<div class=\"modal-one\" id=\"modal-"+modalCount+"\"><div class=\"modal-content\"><span class=\"closeBtn\" onclick=\"close_modal("+modalCount+")\">&times;</span><h3> "+qname+" &nbsp; <small>Begins:  "+sd+" &nbsp; Ends: "+ed+" </small></h3><p>"+qinfo+"</p><form method=\"post\" action=\"Takequiz\"><input type=\"hidden\" name=\"qid\" value=\""+qid+"\"><input class=\"submitpop\" type=\"submit\" value=\"Take Now\"></form></div></div>");
				}
			}
		%>

	</section>
	<section>
		<h2>
			Past Quizes
		</h2>
		<hr>
				<%
			sql = "select qname,rdate,qinfo,sdate,qid,edate from quiz where edate < now();";
			p = con.prepareStatement(sql);
			rs = p.executeQuery();
			flag=0;
			if(rs.next()){
				qname=rs.getString(1);
				rdate=rs.getString(2);
				qinfo=rs.getString(3);
				sdate=rs.getString(4);
				qid=rs.getString(5);
				edate=rs.getString(6);
				modalCount++;
				flag=1;
				rd = rdate.substring(8,10)+"-"+rdate.substring(5,7)+"-"+rdate.substring(0,4);
				sd = sdate.substring(8,10)+"-"+sdate.substring(5,7)+"-"+sdate.substring(0,4);
				ed = edate.substring(8,10)+"-"+edate.substring(5,7)+"-"+edate.substring(0,4);
			}
			if(flag==0){
				out.print("<article class=\"ongoing-quiz-article completed no-quiz\"><h4 class=\"upcoming-quiz-head\">No quiz yet</h4><h5 class=\"upcoming-quiz-date\"></h5><h5 class=\"upcoming-quiz-read\"></h5></article>");
			}
			else{
				out.print("<article onclick=\"open_modal("+modalCount+")\" class=\"ongoing-quiz-article completed\"><h4 class=\"upcoming-quiz-head\">"+qname+"</h4><h5 class=\"upcoming-quiz-date\">Register by: "+rd+"</h5><h5 class=\"upcoming-quiz-read\"><a onclick=\"open_modal("+modalCount+")\" class=\"upcoming-quiz-link\">Read more</a></h5></article>");
				
				out.print("<div class=\"modal-one\" id=\"modal-"+modalCount+"\"><div class=\"modal-content\"><span class=\"closeBtn\" onclick=\"close_modal("+modalCount+")\">&times;</span><h3> "+qname+" &nbsp; <small>Begins:  "+sd+" &nbsp; Ends: "+ed+" </small></h3><p>"+qinfo+"</p></div></div>");
				while(rs.next()){
					modalCount++;
					qname=rs.getString(1);
					rdate=rs.getString(2);
					qinfo=rs.getString(3);
					sdate=rs.getString(4);
					qid=rs.getString(5);
					edate=rs.getString(6);
					rd = rdate.substring(8,10)+"-"+rdate.substring(5,7)+"-"+rdate.substring(0,4);
					sd = sdate.substring(8,10)+"-"+sdate.substring(5,7)+"-"+sdate.substring(0,4);
					ed = edate.substring(8,10)+"-"+edate.substring(5,7)+"-"+edate.substring(0,4);
					out.print("<article onclick=\"open_modal("+modalCount+")\" class=\"ongoing-quiz-article completed\"><h4 class=\"upcoming-quiz-head\">"+qname+"</h4><h5 class=\"upcoming-quiz-date\">Register by: "+rd+"</h5><h5 class=\"upcoming-quiz-read\"><a onclick=\"open_modal("+modalCount+")\" class=\"upcoming-quiz-link\">Read more</a></h5></article>");
					
					out.print("<div class=\"modal-one\" id=\"modal-"+modalCount+"\"><div class=\"modal-content\"><span class=\"closeBtn\" onclick=\"close_modal("+modalCount+")\">&times;</span><h3> "+qname+" &nbsp; <small>Begins:  "+sd+" &nbsp; Ends: "+ed+" </small></h3><p>"+qinfo+"</p></div></div>");
				}
			}
		%>
<%con.close(); %>
	</section>
	
	<div class="spacing">
	</div>
	<footer>
		Copyright &copy; 2020 Mohd Aamir TMU Moradabad
	</footer>
</body>
</html>