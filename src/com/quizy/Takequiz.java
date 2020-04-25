package com.quizy;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/Takequiz")
public class Takequiz extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public Takequiz() {
        super();
        // TODO Auto-generated constructor stub
    }
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String qid = request.getParameter("qid");
		HttpSession session = request.getSession();
		session.setAttribute("qid", qid);
		response.sendRedirect("login.jsp");
	}

}
