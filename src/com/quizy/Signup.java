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

@WebServlet("/Signup")
public class Signup extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public Signup() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String enroll,name,email,dob,role,akey,passkey;
		String sql,sql2;
		Connection con;
		PreparedStatement ps,ps1;
		ResultSet rs;
		int status,flag=0;
		
		try {
			con = ConnectDb.getConnection();
			enroll = request.getParameter("enroll");
			name = request.getParameter("name");
			email = request.getParameter("email");
			dob = request.getParameter("dob");
			role = request.getParameter("role");
			akey = request.getParameter("akey");
			passkey = dob.substring(8,10)+dob.substring(5,7)+dob.substring(0,4);
			
			if(role.equals("admin")) {
				sql = "select * from admin where email='"+email+"' and eid='"+enroll+"';";
				ps = con.prepareStatement(sql);
				rs = ps.executeQuery();
				if(rs.next()) {
					response.sendRedirect("signup?result=AdminFailure");
				}
				flag=1;
			}
			else if(role.equals("user")) {
				sql = "select * from user where email='"+email+"' and uid='"+enroll+"';";
				ps = con.prepareStatement(sql);
				rs = ps.executeQuery();
				if(rs.next()) {
					response.sendRedirect("signup?result=UserFailure");
				}
				flag=0;
			}
			else {
				response.sendRedirect("signup?result=unknown");
			}
			if(flag==1 && akey.equals("$$2020$$")) {
				sql2 = "insert into admin(eid,fullName,email,dob,akey,passkey) values(?,?,?,?,?,?)";
				ps = con.prepareStatement(sql2);
				ps.setString(1, enroll);
				ps.setString(2, name);
				ps.setString(3, email);
				ps.setString(4, dob);
				ps.setString(5, akey);
				ps.setString(6, passkey);
				status = ps.executeUpdate();
				if(status>=1) {
					response.sendRedirect("index.jsp?result=AdminSuccess");
				}
				else {
					response.sendRedirect("index.jsp?result=AdminFailure");
				}
			}
			else if(flag==0) {
				sql2 = "insert into user(uid,fullName,email,dob,passkey) values(?,?,?,?,?)";
				ps1 = con.prepareStatement(sql2);
				ps1.setString(1, enroll);
				ps1.setString(2, name);
				ps1.setString(3, email);
				ps1.setString(4, dob);
				ps1.setString(5, passkey);
				
				status = ps1.executeUpdate();
				if(status>=1) {
					response.sendRedirect("index.jsp?result=UserSuccess");
				}
				else {
					response.sendRedirect("index.jsp?result=UserFailure");
				}
			}
			else {
				response.sendRedirect("index.jsp?result=AdminFailure");
			}
			con.close();
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
	}
}
