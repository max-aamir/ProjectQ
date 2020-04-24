package com.quizy;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Creator")
public class Creator extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public Creator() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		String qid="",c1,c2,c3,c4,cc,diff,topic,ques,nmarks,marks,sql="",quesn="",quescount="";
		int status=0;
		String quesid="";
		quesn = request.getParameter("quesn");
		quescount = request.getParameter("quescount");
		qid = request.getParameter("qid");
		c1 = request.getParameter("c1");
		c2 = request.getParameter("c2");
		c3 = request.getParameter("c3");
		c4 = request.getParameter("c4");
		cc = request.getParameter("cc");
		diff = request.getParameter("diff");
		topic = request.getParameter("topic");
		ques = request.getParameter("ques");
		nmarks = request.getParameter("nmarks");
		marks = request.getParameter("marks");
		//System.out.println(quesn+" "+quescount+" "+qid);
		sql = "insert into question(c1,c2,c3,c4,cc,diff,topic,ques,nmarks,marks) values(?,?,?,?,?,?,?,?,?,?)";
		Connection con;
		try {
			con = ConnectDb.getConnection();
			PreparedStatement ps = con.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS);
			ps.setString(1, c1);
			ps.setString(2, c2);
			ps.setString(3, c3);
			ps.setString(4, c4);
			ps.setString(5, cc);
			ps.setString(6, diff);
			ps.setString(7, topic);
			ps.setString(8, ques);
			ps.setString(9, nmarks);
			ps.setString(10, marks);
			status=ps.executeUpdate();
			if(status>=1) {
				ResultSet rs = ps.getGeneratedKeys();
				if(rs.next()) {
					quesid=rs.getString(1);
					PreparedStatement ps2 = con.prepareStatement("insert into collects(quesid,qid) values("+quesid+","+qid+")");
					int st = ps2.executeUpdate();
					if(st<1){
						response.sendRedirect("error.jsp");
					}
				}
				if(Integer.parseInt(quesn)<Integer.parseInt(quescount)) {
				request.setAttribute("qid", qid);
				RequestDispatcher rd = request.getRequestDispatcher("creator.jsp");
				rd.forward(request, response);
				}
				else {
					response.sendRedirect("quizer.jsp?result=CreateSuccess");
				}
			}
			
			con.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
	}

}
