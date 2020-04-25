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

@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 
		try {
			Connection con = ConnectDb.getConnection();
			String sql="",eid="",uid="",qid="";
			String email = request.getParameter("email");
			String pass = request.getParameter("pass");
			String role = request.getParameter("role");
			HttpSession session=request.getSession();;
			if(role.equalsIgnoreCase("admin")) {
				sql = "select fullName,eid from admin where email=? and passkey=?;";
			}
			else if(role.equalsIgnoreCase("user")) {
				sql = "select fullName,uid from user where email=? and passkey=?;";
			}
			
			PreparedStatement ps = con.prepareStatement(sql);
			//System.out.println(sql);
			ps.setString(1, email);
			ps.setString(2, pass);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				String fname = rs.getString(1);
				 
				if(session.getAttribute("qid")!=null) {
					qid=String.valueOf(session.getAttribute("qid"));
				}
				if(role.equalsIgnoreCase("admin")) {
					eid = rs.getString(2);
					session.setAttribute("whosthisadmin",fname);
					session.setAttribute("admineid",eid);
					session.removeAttribute("qid");
					response.sendRedirect("profiled.jsp");
				}
				else if(role.equalsIgnoreCase("user")) {
					uid = rs.getString(2);
					session.setAttribute("whosthis",fname);
					session.setAttribute("useruid",uid);
					if(qid.length()>=1)
						response.sendRedirect("iamonline.jsp");
					else
						response.sendRedirect("profile.jsp");
				}
			}
			else {
				session.removeAttribute("qid");
				response.sendRedirect("login.jsp?result=Failure");
			}
			con.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			System.out.println(e.getMessage());
		}
		
	}

}
