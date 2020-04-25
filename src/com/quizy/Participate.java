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


@WebServlet("/Participate")
public class Participate extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public Participate() {
        super();
        
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			Connection con = ConnectDb.getConnection();
			
			//String fullName = request.getParameter("fullName");
			String uid = request.getParameter("uid");
			String qid = request.getParameter("qid");
			//System.out.println(uid+" "+qid);
			
			String sql="select * from participate where userid=? and qid=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, uid);
			ps.setString(2, qid);
			
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				response.sendRedirect("participate.jsp?result=duplicate");
			}
			else {
				String sql2 = "insert into participate(userid,qid) values('"+uid+"',"+qid+")";
				PreparedStatement p = con.prepareStatement(sql2);
				//p.setString(1, uid);
				//p.setString(2, qid);
				int status = p.executeUpdate();
				if(status>0) {
					response.sendRedirect("participate.jsp?result=Success");
				}
				else {
					response.sendRedirect("error.jsp");
				}
			}
			
			con.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

}
