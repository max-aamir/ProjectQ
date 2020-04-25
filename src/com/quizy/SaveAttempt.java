package com.quizy;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/SaveAttempt")
public class SaveAttempt extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public SaveAttempt() {
        super();
        // TODO Auto-generated constructor stub
    }
	/*
	 * protected static boolean isPresent(Connection con,String qid,String
	 * uid,String quesid) throws SQLException {
	 * 
	 * String sql; PreparedStatement ps;
	 * 
	 * ResultSet rs; sql="select * from result where qid=\""+qid+"\" and userid=\""
	 * +uid+"\" and quesid=\""+quesid+"\""; ps = con.prepareStatement(sql); rs =
	 * ps.executeQuery(); if(rs.next()) { System.out.println("result found"); return
	 * true; } System.out.println("result found"); return false; }
	 */

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String qid,uid,sql,remtime="0";
		int quescount,i;
		String quesid[],ca[];
		boolean flag=false;
		HttpSession session = request.getSession(false);
		 qid = request.getParameter("qid");
		 uid = request.getParameter("uid");
		 quescount = Integer.parseInt(request.getParameter("quescount"));
		 ca = new String[quescount];
		 quesid = new String[quescount];
		 for(i=0;i<quescount;i++) {
			 ca[i] = request.getParameter("selected-answer-"+(i+1));
			 if(ca[i]!=null) {
				 quesid[i] = ca[i].substring(2);
				 ca[i] = ca[i].charAt(0)+"";
			 }
			 else {
				 ca[i] = "0";
				 quesid[i] = request.getParameter((i+1)+"");
			 }
		 }
		/*
		 * System.out.println("qid="+qid); System.out.println("userid="+uid); for(int
		 * i1=0;i1<quescount;i1++) System.out.print("  quesid="+quesid[i1]);
		 * System.out.println("quescount="+quescount); for(int i1=0;i1<quescount;i1++)
		 * System.out.print("  ca="+ca[i1]);
		 */
		 try {
			Connection con = ConnectDb.getConnection();
			PreparedStatement ps;
			ResultSet rs1;
			int rs=0;
			
			for(i=0;i<quescount;i++) {
				
				sql="select * from result where qid="+qid+" and userid=\""+uid+"\" and quesid="+quesid[i]+"";
				ps = con.prepareStatement(sql);
				rs1 = ps.executeQuery();
				if(rs1.next()) {
					//System.out.println("final submit result found");
					flag= true;
				}else {
				//System.out.println("final submit result not found");
				flag= false;
				}
				
				
				//if(!isPresent(con,qid,uid,quesid[i])) {
				if(!flag) {
				sql = "insert into result(qid,userid,quesid,ca,remainingtime) values("+qid+",'"+uid+"',"+quesid[i]+","+ca[i]+",'"+remtime+"');";
				//System.out.println("so inserting final submit result not found");
				}
				else {
					sql = "update result set ca="+ca[i]+",remainingtime='"+remtime+"' where qid="+qid+" and userid='"+uid+"' and quesid="+quesid[i]+";";
					//System.out.println("so updating final submit result found");
				}
				ps = con.prepareStatement(sql);
				rs = ps.executeUpdate(); 
				if(rs<1) {
					response.sendRedirect("error.jsp");
				}
			}
			if(rs>=1) {
				session.invalidate();
				response.sendRedirect("index.jsp?result=AttemptSuccess");
			}
			
			con.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
