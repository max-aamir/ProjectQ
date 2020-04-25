package com.quizy;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Host")
public class Host extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public Host() {
        super();
        // TODO Auto-generated constructor stub
    }
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String qid = request.getParameter("qid"),sql;
		String qinfo = request.getParameter("qinfo");
		String sdate = request.getParameter("sdate");
		String rdate = request.getParameter("rdate");
		String edate = request.getParameter("edate");
		String duration = request.getParameter("duration");
		String diff = request.getParameter("diff");
		Connection con;
		try {
			con = ConnectDb.getConnection();
			sql = "update quiz set qinfo=?,sdate=?,edate=?,rdate=?,duration=?,diff=? where qid="+qid;
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1,qinfo);
			ps.setString(2,sdate);
			ps.setString(3,edate);
			ps.setString(4,rdate);
			ps.setString(5,duration);
			ps.setString(6,diff);
			int status = ps.executeUpdate();
			if(status>=1) {
				response.sendRedirect("profiled.jsp?result=HostingSuccess");
			}
			
			  else { response.sendRedirect("error.jsp"); }
			con.close();	 
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

}
