<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*,com.quizy.ConnectDb"%>
<%
String qid,uid,quesid,remtime,ca;
String sql,sql2;
sql=sql2="";
qid = request.getParameter("qid");
uid = request.getParameter("uid");
quesid = request.getParameter("quesid");
remtime = request.getParameter("remtime");
ca = request.getParameter("ca");

//ca = ca.charAt(0)+"";
try {
		Connection con = ConnectDb.getConnection();
		PreparedStatement ps,ps2;
		int st=0;
		ResultSet rs;
		sql="select * from result where qid=\""+qid+"\" and userid=\""+uid+"\" and quesid=\""+quesid+"\"";
		ps = con.prepareStatement(sql);
		rs = ps.executeQuery();
		if(rs.next()) {
			sql = "update result set ca="+ca+",remainingtime='"+remtime+"' where qid="+qid+" and userid=\""+uid+"\" and quesid="+quesid+";";
			ps = con.prepareStatement(sql);
			st = ps.executeUpdate(); 
/* 			if(st<1) {
				response.sendRedirect("error.jsp");
			}
			else {
				RequestDispatcher rd = request.getRequestDispatcher("iamonline.jsp");
				rd.forward(request,response);
			} */
		
		/*
		 * if(st>=1) { session.invalidate();
		 * response.sendRedirect("index.jsp?result=AttemptSuccess"); }
		 */
		
		
	}
		else {// if first time storing
			sql2 = "insert into result(qid,userid,quesid,ca,remainingtime) values('"+qid+"','"+uid+"',"+quesid+","+ca+",'"+remtime+"');";
			ps2 = con.prepareStatement(sql2);
			st= ps2.executeUpdate(); 
/* 			if(st<1) {
				response.sendRedirect("error.jsp");
			}
			else {
				RequestDispatcher rd = request.getRequestDispatcher("iamonline.jsp");
				rd.forward(request,response);
			} */
		}
		con.close();
}catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
%>