<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*,com.quizy.ConnectDb,java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
	<title>Let the fun begin</title>
	<link rel="stylesheet" type="text/css" href="css/iamonlinestyle.css">
	<script type="text/javascript" src="js/functions.js"></script>
	<script type="text/javascript" src="js/functions2.js"></script>
	<script type="text/javascript" src="js/submitFunctions.js"></script>
<script type="text/javascript" src="js/info.js"></script>
	<link rel="stylesheet" type="text/css" href="css/infostyle.css">
	<!-- <script type="text/javascript">	</script> -->
</head>
<body>
	<div id="infobtn"  onClick="open_info()"><img src="img/infoblue.png"></div>
	<div class="modal-info" id="modal-info">
		<div class="modal-content">
			<span class="closeBtn" onClick="close_info()">&times;</span>
			<h3>Help </h3>
			<p>Contact the organizing team for any query. </p>
		</div>
	</div>
	<%! String username,uid,qid,sql,sql2,duration,sql3,sql4;	
		int quesn,quescount,quescurr,i,j,k,minr;
		String ques[],c1[],c2[],c3[],c4[],quesid[];
		String diff[],topic[];
		ArrayList<String> ca = new ArrayList<>();
		ArrayList<String> remtime = new ArrayList<>();
		ArrayList<String> quesidat = new ArrayList<>();
	%>
	<%
		response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
		if(session.getAttribute("whosthis")==null && session.getAttribute("qid")==null){
			
			response.sendRedirect("login.jsp?result=unknown");
		}
		else{
			username = String.valueOf(session.getAttribute("whosthis"));
			uid = String.valueOf(session.getAttribute("useruid"));
			qid = String.valueOf(session.getAttribute("qid"));
			
		}
		sql = "select ques,c1,c2,c3,c4,collects.quesid,diff,topic from collects INNER JOIN question on collects.quesid=question.quesid where collects.qid="+qid;
		sql2 = "select quescount,duration from quiz where qid="+qid;
		sql3 = "select ca,remainingtime,quesid from result where userid='"+uid+"'and qid="+qid;
		sql4 = "select userid,qid from participate where userid='"+uid+"' and qid='"+qid+"';";
		Connection con = ConnectDb.getConnection();
		PreparedStatement ps = con.prepareStatement(sql);
		PreparedStatement ps1 = con.prepareStatement(sql2);
		PreparedStatement ps2 = con.prepareStatement(sql3);
		PreparedStatement ps3 = con.prepareStatement(sql4);
		ResultSet rs3 = ps3.executeQuery();
		if(!rs3.next()){
			session.invalidate();
			response.sendRedirect("index.jsp?result=NotRegistered");
		}
		ResultSet rs2 = ps2.executeQuery();
		if(rs2.next()){
			ca.add(rs2.getString(1));
			remtime.add(rs2.getString(2));
			quesidat.add(rs2.getString(3));
			while(rs2.next()){
				ca.add(rs2.getString(1));
				remtime.add(rs2.getString(2));
				quesidat.add(rs2.getString(3));
			}
			/* minr = Integer.parseInt(remtime.get(0));
			System.out.println("minr="+minr);
			for(String arr:ca){
			System.out.println("ca arr = "+arr);}
			for(String arr:remtime){
				System.out.println("remtim arr = "+arr);}
			for(String arr:quesidat){
				System.out.println("quesid arr= "+arr);} */
			for(int i=1;i<remtime.size();i++) {
				if(minr>Integer.parseInt(remtime.get(i)))
					minr = Integer.parseInt(remtime.get(i));
			}
			if(minr==0){
				session.invalidate();
				response.sendRedirect("index.jsp?result=DuplicateAttempt");
			}
		}
		ResultSet rs=ps.executeQuery();
		ResultSet rs1 = ps1.executeQuery();
		if(rs1.next()){
			quescount=Integer.parseInt(rs1.getString(1));
			duration=rs1.getString(2);
		}
		quesn = 1;
		quescurr = 1;
		ques = new String[quescount];
		c1 = new String[quescount];
		c2 = new String[quescount];
		c3 = new String[quescount];
		c4 = new String[quescount];
		quesid = new String[quescount];
		diff = new String[quescount];
		topic = new String[quescount];
		i=0;
		while(rs.next() && i<quescount){
			ques[i]=rs.getString(1);
			c1[i]=rs.getString(2);
			c2[i]=rs.getString(3);
			c3[i]=rs.getString(4);
			c4[i]=rs.getString(5);
			quesid[i]=rs.getString(6);
			diff[i]=rs.getString(7);
			topic[i]=rs.getString(8);
			i++;
		}
		if(ca.size()>=1){
			duration = minr+"";
		}
		
	%>
	<script> alert('Click OK to continue. Your timer will go as you click.');check(<%= duration%>);</script>
	<div class="question-div">
		<header>
			<h1>Quizy</h1>
			<div class="header-links">
				<h3><%= username %></h3>
			</div>
		</header>
		<section>
			<%
				for(i=1;i<=quescount;i++){
					j=i-1;
					if(topic[j]==null)
						topic[j]="not defined";
					out.print("<h3 style=\"display:none;\" class=\"auto-hide-"+i+"\">Ques "+i+" <span id=\"souter\"> Difficulty -  <span id=\"sinner\"> "+diff[j]+" </span> Topic - <span id=\"sinner\"> "+topic[j]+" </span></span></h3>");
					out.print("<pre  style=\"display:none;\"  class=\"auto-hide-"+i+"\">"+ques[j]+"</pre>");
				}
			%>
			<!-- <h3>Ques #</h3>
			<pre>question</pre> -->
		</section>
	</div>
	<div class="palette-div">
		<section class="submit-section">
			<input class="submit" type="submit" form="answers" value="Final Submit"/>
		</section>
		<section class="timer-section" >
			<h3 id="timer"><span id="hour"></span><small> h </small> : <span id="min"></span><small> m </small> : <span id="sec"></span><small> s </small></h3>
		</section>
		<section class="palette-section">
			<h5>Click to jump to question</h5>
			
			<%
				for(i=1;i<=quescount;i++){
					j=i-1;
					out.print("<button name=\"btn"+i+"\" onClick=\"auto_modal_show("+i+","+quescount+")\" class=\"palette-button\" >"+i+"</button>");
				}
			%>
<!-- 			<button name="btn1" class="palette-button" >1</button>
			<button name="btn1" class="palette-button" >2</button>
			<button name="btn1" class="palette-button" >3</button>
			<button name="btn1" class="palette-button" >4</button>
			<button name="btn1" class="palette-button" >5</button> -->

		</section>
		<section class="choice-section">
			<form method="post" id="answers" action="SaveAttempt" onSubmit="return submit_confirmation();">
			
			<%
				for(i=1;i<=quescount;i++){
					j=i-1;
					k=i+1;
					if(quesidat.contains(quesid[j])){
						int z = quesidat.indexOf(quesid[j]);
						//System.out.println("z="+z+" ca of z = "+ca.get(z));
						int selca = Integer.parseInt(ca.get(z));
						if(selca==1){
							out.print("<div style=\"display=none;\"  class=\"auto-hide-"+i+"\"><input  type=\"radio\" name=\"selected-answer-"+i+"\"  value=\"1-"+quesid[j]+"\" checked=\"checked\"><label>"+c1[j]+"</label></div>");
						}
						else{
							out.print("<div style=\"display=none;\"  class=\"auto-hide-"+i+"\"><input  type=\"radio\" name=\"selected-answer-"+i+"\" value=\"1-"+quesid[j]+"\"><label>"+c1[j]+"</label></div>");
						}
						if(selca==2){
							out.print("<div style=\"display=none;\"  class=\"auto-hide-"+i+"\"><input  type=\"radio\" name=\"selected-answer-"+i+"\"  value=\"2-"+quesid[j]+"\" checked=\"checked\"><label>"+c2[j]+"</label></div>");
						}
						else{
							out.print("<div style=\"display=none;\"  class=\"auto-hide-"+i+"\"><input  type=\"radio\" name=\"selected-answer-"+i+"\"  value=\"2-"+quesid[j]+"\"><label>"+c2[j]+"</label></div>");
						}
						if(selca==3){
							out.print("<div style=\"display=none;\"  class=\"auto-hide-"+i+"\"><input  type=\"radio\" name=\"selected-answer-"+i+"\"  value=\"3-"+quesid[j]+"\" checked=\"checked\"><label>"+c3[j]+"</label></div>");
						}
						else{
							out.print("<div style=\"display=none;\"  class=\"auto-hide-"+i+"\"><input  type=\"radio\" name=\"selected-answer-"+i+"\"  value=\"3-"+quesid[j]+"\"><label>"+c3[j]+"</label></div>");
						}
						if(selca==4){
							out.print("<div style=\"display=none;\"  class=\"auto-hide-"+i+"\"><input  type=\"radio\" name=\"selected-answer-"+i+"\"  value=\"4-"+quesid[j]+"\" checked=\"checked\"><label>"+c4[j]+"</label></div>");
						}
						else{
							out.print("<div style=\"display=none;\"  class=\"auto-hide-"+i+"\"><input  type=\"radio\" name=\"selected-answer-"+i+"\"  value=\"4-"+quesid[j]+"\"><label>"+c4[j]+"</label></div>");
						}
						
					}else{
					out.print("<div style=\"display=none;\"  class=\"auto-hide-"+i+"\"><input  type=\"radio\" name=\"selected-answer-"+i+"\" value=\"1-"+quesid[j]+"\"><label>"+c1[j]+"</label></div>");
					out.print("<div style=\"display=none;\" class=\"auto-hide-"+i+"\"><input  type=\"radio\" name=\"selected-answer-"+i+"\" value=\"2-"+quesid[j]+"\"><label>"+c2[j]+"</label></div>");
					out.print("<div style=\"display=none;\" class=\"auto-hide-"+i+"\"><input   type=\"radio\" name=\"selected-answer-"+i+"\" value=\"3-"+quesid[j]+"\"><label>"+c3[j]+"</label></div>");
					out.print("<div style=\"display=none;\" class=\"auto-hide-"+i+"\"><input  type=\"radio\" name=\"selected-answer-"+i+"\" value=\"4-"+quesid[j]+"\"><label>"+c4[j]+"</label></div>");
					}
					out.print("<input type=\"hidden\" name=\""+i+"\" value=\""+quesid[j]+"\">");
				}
			%>
				<!-- <div>
					<input type="radio" name="selected-answer" value="0">
					<label>Choice1</label>
				</div>
				<div>
					<input type="radio" name="selected-answer" value="0">
					<label>Choice1</label>
				</div>
				<div>
					<input type="radio" name="selected-answer" value="0">
					<label>Choice1</label>
				</div>
				<div>
					<input type="radio" name="selected-answer" value="0">
					<label>Choice1</label>
				</div>
				<div class="button-div">
					<button name="save-next" class="submit">Next</button>
					<input type="reset" name="reset" value="Clear">
				</div> -->
				<input type="hidden" name="qid" value="<%= qid %>">
				<input type="hidden" name="uid" value="<%= uid %>">
				<input type="hidden" name="quescount" value="<%= quescount %>">
			</form>
			<%
			for(i=1;i<quescount;i++){
				k=i+1;
			out.print("<div style=\"display=none;\" class=\"auto-hide-"+i+"\" ><button  name=\"next"+k+"\" class=\"next\" onClick=\"partialSubmit("+k+","+quescount+")\">Next</button><button name=\"clr"+k+"\" class=\"clear\" onClick=\"current_radio_clear("+i+")\">Clear</div>");				
			}
			k=1;
			out.print("<div style=\"display=none;\" class=\"auto-hide-"+i+"\" ><button  name=\"next"+k+"\" class=\"next\" onClick=\"partialSubmit("+k+","+quescount+")\">Next</button><button name=\"clr"+k+"\" class=\"clear\" onClick=\"current_radio_clear("+i+")\">Clear</div>");	
			ca.clear();
			quesidat.clear();
			remtime.clear();
			 %>
			 <%con.close();%>
		</section>
	</div>
	<div class="spacing">
	</div>
	<footer>
		Copyright &copy; 2020 Mohd Aamir TMU Moradabad
	</footer>
<!-- 	<script>
		var i = document.getElementsByClassName('auto-hide-1');
		var j;
		for(j=0;j<i.length;j++){
			i[j].style.display = 'block';
		}
	</script> -->
	<script>auto_modal_show(1,<%= quescount %>);</script>
</body>
</html>