package com.quizy;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Generate")
public class Generate extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public Generate() {
        super();
    }
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String eid,qid,sql="",sql2="",sql3="",sql4="";
		//String[] uid,fullname;
		ArrayList<String> uida = new ArrayList<>();
		ArrayList<String> fullnamea = new ArrayList<>();
		int i=0,uidn,j,incrtcount,crtcount,crtmarks,incrtmarks,quesidn,status;
		eid = request.getParameter("eid");
		eid=eid+"";
		qid = request.getParameter("qid");
		PreparedStatement ps,ps1,ps2,ps3;
		ResultSet rs,rs1;
		Connection con;
		try {
			con = ConnectDb.getConnection();
			sql = "select distinct userid,fullName from participate INNER JOIN user ON userid=uid where qid="+qid;
			DatabaseMetaData dbm = con.getMetaData();
			ResultSet tables = dbm.getTables(null,null,"generatedresult_"+qid,null);
			if(!tables.next()) {
			sql3="create table generatedresult_"+qid+" (uid varchar(20) not null, fullName varchar(100), correctcount int2 default 0, incorrectcount int2 default 0, correctmarks int2 default 0, incorrectmarks int2 default 0, totalmarks int2 default 0);";
			ps2 = con.prepareStatement(sql3);
			status = ps2.executeUpdate();
			if(status!=0)
				response.sendRedirect("error.jsp");

			ps= con.prepareStatement(sql);
			rs = ps.executeQuery();
			i=0;
			while(rs.next()) {
				uida.add(rs.getString(1));
				fullnamea.add(rs.getString(2));
				i++;
			}
			uidn=i;
			//uid = (String[]) uida.toArray();
			//fullname = (String[]) fullnamea.toArray();
			//uida.clear();
			//fullnamea.clear();
			for(i=0;i<uidn;i++) {
				
				sql2 = "select result.quesid,ca,cc,nmarks,marks from result INNER JOIN question ON result.quesid=question.quesid  where qid="+qid+" and userid='"+uida.get(i)+"';";
				ArrayList<String> quesida = new ArrayList<>();
				ArrayList<String> caa = new ArrayList<>();
				ArrayList<String> cca = new ArrayList<>();
				ArrayList<String> nmarksa = new ArrayList<>();
				ArrayList<String> marksa = new ArrayList<>();
				ps1 = con.prepareStatement(sql2);
				rs1 = ps1.executeQuery();
				j=0;
				while(rs1.next()) {
					quesida.add(rs1.getString(1));
					caa.add(rs1.getString(2));
					cca.add(rs1.getString(3));
					nmarksa.add(rs1.getString(4));
					marksa.add(rs1.getString(5));
					j++;
				}
				quesidn = j;
				crtcount = incrtcount = incrtmarks = crtmarks =0;
				
				for(j=0;j<quesidn;j++) {
					//System.out.println(" "+caa.get(j)+" "+cca.get(j));
					if(caa.get(j).equals(cca.get(j))) {
						crtmarks += Integer.parseInt(marksa.get(j));
						crtcount++;
					}
					else if(caa.get(j).equals("0")){
						
					}	
					else {
						incrtmarks += Integer.parseInt(nmarksa.get(j));
						incrtcount++;
					}
				}
				sql4 = "insert into generatedresult_"+qid+"(uid,fullName,correctcount,incorrectcount,correctmarks,incorrectmarks,totalmarks) values(?,?,?,?,?,?,?)";
				ps3 = con.prepareStatement(sql4);
				ps3.setString(1, uida.get(i));
				ps3.setString(2, fullnamea.get(i));
				ps3.setInt(3, crtcount);
				ps3.setInt(4, incrtcount);
				ps3.setInt(5, crtmarks);
				ps3.setInt(6, incrtmarks);
				ps3.setInt(7, (crtmarks-incrtmarks));
				ps3.executeUpdate();
				//ps3.close();
				//System.out.println("i = "+i);
			}
			//System.out.println("i end = "+i);
			if(i==uidn) {
				RequestDispatcher rd = request.getRequestDispatcher("generator.jsp");
				rd.forward(request, response);
			}
			else {
				response.sendRedirect("error.jsp");
			}
		}
			else {
				RequestDispatcher rd = request.getRequestDispatcher("generator.jsp");
				rd.forward(request, response);
			}
			con.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 
		
	}

}
