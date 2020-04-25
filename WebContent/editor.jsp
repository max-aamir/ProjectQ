<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*,com.quizy.ConnectDb"
     %>
<!DOCTYPE html>
<html>
<head>
	<title>Edit questions</title>
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
<%!	String eid,fullName,quescount,qname,sql,qid,quesid;
		int flag=0,quesn,quescurr;
		String c1,c2,c3,c4,cc,diff,topic,nmarks,marks,ques;
		%>
	<%
	response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
	if(session.getAttribute("whosthisadmin")==null){
		response.sendRedirect("login.jsp");
	}
	Connection con = ConnectDb.getConnection();
	
	eid=fullName=quescount=qname="";
	if(request.getAttribute("quesn")==null){
		quesn = 1;
		quescount = request.getParameter("quescount");
		qid = request.getParameter("qid");
	}
	else{
		quesn = Integer.parseInt(String.valueOf(request.getAttribute("quesn")));
		quescount = String.valueOf(request.getAttribute("quescount"));
		qid = String.valueOf(request.getParameter("qid"));
	}
	eid = String.valueOf(session.getAttribute("admineid"));
	sql = "select quesid from collects where qid="+qid;
	PreparedStatement ps=con.prepareStatement(sql);

	ResultSet rs=ps.executeQuery();
		
			flag=1;
			if(request.getAttribute("quesn")==null){
				rs.next();
			}
			else{
			for(int i=1;i<=quesn;i++){
				rs.next();
			}
			}
		quescurr = Integer.parseInt(rs.getString(1));
		sql = "select c1,c2,c3,c4,cc,diff,topic,nmarks,marks,ques from question where quesid="+quescurr;
		quesid = Integer.toString(quescurr);
		PreparedStatement ps1 = con.prepareStatement(sql);
		ResultSet rs1 = ps1.executeQuery();
		
		
		if(rs1.next()){
			c1=rs1.getString(1);
			c2=rs1.getString(2);
			c3=rs1.getString(3);
			c4=rs1.getString(4);
			cc=rs1.getString(5);
			diff = rs1.getString(6);
			topic = rs1.getString(7);
			nmarks = rs1.getString(8);
			marks = rs1.getString(9);
			ques = rs1.getString(10);
		}
	%>
	<header>
		<h1>Quizy</h1>
	</header>

	<section>
		<aside>
			Ques. <%= quesn %>
		</aside>
		<article>
			<form method="post" class="form-group" action="Editor" onsubmit="return validate_create();">
				<div class="outer">
					<div class="inner-one">
						<textarea class="ques" name="ques" id="ques" placeholder="Enter question"><%=ques %></textarea>
					</div>
					<div class="inner-two">
						<input class="ans" id="c1" type="text" name="c1" placeholder="Choice 1" value="<%=c1 %>">
						<input class="ans" id="c2"  type="text" name="c2" placeholder="Choice 2" value="<%=c2 %>">
						<input class="ans" id="c3"  type="text" name="c3" placeholder="Choice 3" value="<%=c3 %>">
						<input class="ans" id="c4"  type="text" name="c4" placeholder="Choice 4" value="<%=c4 %>">
					</div>
				</div>
				<input class="info" type="number"  id="nmarks" name="nmarks" placeholder="Negative marks" value="<%=nmarks %>">
				<input class="info" type="number" id="marks" name="marks" placeholder="Marks" value="<%=marks %>">
				<input class="info" type="number" id="cc"  name="cc" placeholder="Correct choice" value="<%=cc %>">
				<input class="info-subject" type="text" id="topic" name="topic" placeholder="Subject of question" value="<%=topic %>">
				<label class="difficulty-radio">Difficulty</label>
				<select name="diff" id="diff">
				
				<%	
					String arr[] = {"<option  value=\"none\">None</option>",
									"<option  value=\"easy\">Easy</option>",
									"<option  value=\"medium\">Medium</option>",
									"<option  value=\"hard\">Hard</option>"};
					
						if(diff.equals("none")){
							out.print("<option  value=\"none\" selected>None</option>");
							out.print(arr[1]);
							out.print(arr[2]);
							out.print(arr[3]);
						}
						if(diff.equals("easy")){
							out.print(arr[0]);
							out.print("<option  value=\"easy\" selected>Easy</option>");
							out.print(arr[2]);
							out.print(arr[3]);
						}
						if(diff.equals("medium")){
							out.print(arr[0]);
							out.print(arr[1]);
							out.print("<option  value=\"medium\" selected>Medium</option>");
							out.print(arr[3]);
						}
						if(diff.equals("hard")){
							out.print(arr[0]);
							out.print(arr[1]);
							out.print(arr[2]);
							out.print("<option  value=\"hard\" selected>Hard</option>");
						}
					
					%>
				</select>
				
				<input type="hidden" name="quesid" value="<%= quesid %>" >
				<input type="hidden" name="qid" value="<%= qid %>">
				<input type="hidden" name="quesn" value="<%= quesn %>">
				<input type="hidden" name="quescount" value="<%= quescount %>">
				<input class="submit" type="submit" name="submit" value="Save Changes">
				<input class="reset" type="submit" name="submit" value="Discard Changes">
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