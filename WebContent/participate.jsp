<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*,com.quizy.ConnectDb"%>
<!DOCTYPE html>
<html>
<head>
	<title>Available quizes</title>
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
</head>
<body>
	<%! String username,uid;	
	%>
	<%
		response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
		if(session.getAttribute("whosthis")==null){
			
			response.sendRedirect("login.jsp");
		}
		else{
			username = String.valueOf(session.getAttribute("whosthis"));
			uid = String.valueOf(session.getAttribute("useruid"));
			if(request.getParameter("result")!=null){
				String result = request.getParameter("result");
				if(result.equals("Success")){
					out.print("<script>alert('You have successfully registered.');</script>");
				}
				else if(result.equals("duplicate")){
					out.print("<script>alert('You are already registered.');</script>");
				}
			}
		}
	%>
	<header>
		<h1>Quizy</h1>
		<div class="header-links">
			<h3><a href="profile.jsp" >Back to profile</a></h3>
		</div>
	</header>

	<section>
		<h2>
			Available Quizes
		</h2>
		<hr>
		<%
			String qname, rdate,qinfo,sdate,qid,edate;
			qid=qname=rdate=qinfo=sdate=edate="";
			String rd,ed,sd;
			rd=sd=ed="";
			int flag=0,modalCount=0; 
			String sql="";
			sql = "select qname,rdate,qinfo,sdate,qid,edate from quiz where rdate > now();";
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
				out.print("<article class=\"upcoming-quiz-article\"><h4 class=\"upcoming-quiz-head\">"+qname+"</h4><h5 class=\"upcoming-quiz-date\">Register by: "+rd+"</h5><h5 class=\"upcoming-quiz-read\"><a onclick=\"open_modal("+modalCount+")\" class=\"upcoming-quiz-link\">Register</a></h5></article>");
				
				out.print("<div class=\"modal-one\" id=\"modal-"+modalCount+"\"><div class=\"modal-content\"><span class=\"closeBtn\" onclick=\"close_modal("+modalCount+")\">&times;</span><h3> "+qname+" &nbsp; <small>Begins:  "+sd+" &nbsp; Ends: "+ed+" </small></h3><p>"+qinfo+"</p><form method=\"post\" action=\"Participate\"><input type=\"hidden\" name=\"fullName\" value=\""+username+"\" ><input type=\"hidden\" name=\"uid\" value=\""+uid+"\" ><input type=\"hidden\" name=\"qid\" value=\""+qid+"\" ><input class=\"submit\" type=\"submit\" value=\"Confirm\"></form></div></div>");
				while(rs.next()){
					modalCount++;
					qname=rs.getString(1);
					rdate=rs.getString(2);
					qinfo=rs.getString(3);
					sdate=rs.getString(4);
					qid=rs.getString(5);
					out.print("<article class=\"upcoming-quiz-article\"><h4 class=\"upcoming-quiz-head\">"+qname+"</h4><h5 class=\"upcoming-quiz-date\">Register by: "+rd+"</h5><h5 class=\"upcoming-quiz-read\"><a onclick=\"open_modal("+modalCount+")\" class=\"upcoming-quiz-link\">Register</a></h5></article>");
					
					out.print("<div class=\"modal-one\" id=\"modal-"+modalCount+"\"><div class=\"modal-content\"><span class=\"closeBtn\" onclick=\"close_modal("+modalCount+")\">&times;</span><h3> "+qname+" &nbsp; <small>Begins:  "+sd+" &nbsp; Ends: "+ed+" </small></h3><p>"+qinfo+"</p><form method=\"post\" action=\"Participate\"><input type=\"hidden\" name=\"fullName\" value=\""+username+"\" ><input type=\"hidden\" name=\"uid\" value=\""+uid+"\" ><input type=\"hidden\" name=\"qid\" value=\""+qid+"\" ><input class=\"submit\" type=\"submit\" value=\"Confirm\"></form></div></div>");
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