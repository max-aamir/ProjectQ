package com.quizy;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/Editor")
public class Editor extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public Editor() {
        super();
        
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String qid="",c1,c2,c3,c4,cc,diff,topic,ques,nmarks,marks,sql="",quesn="",quescount="";
		int status=0;
		String quesid="";
		String button = request.getParameter("submit");
		quesn = request.getParameter("quesn");
		quescount = request.getParameter("quescount");
		qid=request.getParameter("qid");
		if(button.equals("Save Changes")) {
		
		quesid = request.getParameter("quesid");
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
		sql = "update question set c1= ? ,c2 = ? ,c3 = ? ,c4 = ? , cc = ? , diff = ? , topic = ? , ques = ? , nmarks = ? , marks = ? where quesid="+quesid;
		Connection con;
		try {
			con = ConnectDb.getConnection();
			PreparedStatement ps = con.prepareStatement(sql);
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
			//System.out.println("status "+status);
			if(status<1) {
				response.sendRedirect("error.jsp");
			}
			con.close();
		}
		 catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
		// when discard
		else if(button.equals("Discard Changes")) {
			
		}
		int quesnint = Integer.parseInt(quesn) +1; 
		//System.out.println("quesnint "+quesnint);
		if(quesnint<=Integer.parseInt(quescount)) {
			request.setAttribute("quesn", quesnint);
			request.setAttribute("qid", qid);
			request.setAttribute("quescount", quescount);
			RequestDispatcher rd = request.getRequestDispatcher("editor.jsp");
			rd.forward(request, response);
			}
			else {
				response.sendRedirect("quizer.jsp?result=EditSuccess");
			}
  }
}