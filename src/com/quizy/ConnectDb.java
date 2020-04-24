package com.quizy;
import java.sql.Connection;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ConnectDb {
	public static Connection getConnection() throws Exception{
		try {
			Context initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:comp/env");
			DataSource ds = (DataSource) envContext.lookup("jdbc/quizyRepo");
			Connection con = ds.getConnection();
		//Connection con;
		//Class.forName("com.mysql.cj.jdbc.Driver");
		//con = DriverManager.getConnection("jdbc:mysql://localhost:3306/quizyRepo","Max","maxSQL8080?");
		return con;
		//?characterEncoding=latin1&useConfigs=maxPerformance
		}
		catch(Exception e) {
			System.out.println(e.getMessage());
			return null;
		}
	}
}	
	