<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>logging out.....</title>
</head>
<body>
<%	
		session.removeAttribute("whosthisadmin");
		session.removeAttribute("admineid");
		session.invalidate();
		response.sendRedirect("index.jsp?result=adminlogoutSuccess");
	%>
</body>
</html>