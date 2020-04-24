package com.quizy;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/Delete")
public class Delete extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public Delete() {
        super();
        
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String qid = request.getParameter("qid"),sql;
		Connection con;
		try {
			con = ConnectDb.getConnection();
			sql = "delete from quiz where qid="+qid;
			PreparedStatement ps = con.prepareStatement(sql);
			int status = ps.executeUpdate();
			if(status>=1) {
				response.sendRedirect("quizer.jsp?result=DeleteSuccess");
			}
			else {
				response.sendRedirect("error.jsp");
			}
			con.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}

}
