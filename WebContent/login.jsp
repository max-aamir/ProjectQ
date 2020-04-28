<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Login</title>
		<link href="css/loginstyle.css" rel="stylesheet">
		<link href="css/popupstyle.css" rel="stylesheet">
		<script type="text/javascript" src="js/modal_functions.js"></script>
		<script type="text/javascript" src="js/functions.js"></script>
		<script type="text/javascript" src="js/info.js"></script>
		<link rel="stylesheet" type="text/css" href="css/infostyle.css">
	</head>
	<body>
	<div id="infobtn"  onclick="open_info()"><img src="img/infoblue.png"></div>
	<div class="modal-info" id="modal-info">
		<div class="modal-content">
			<span class="closeBtn" onclick="close_info()">&times;</span>
			<h3>Help </h3>
			<p>Contact the organizing team for any query. </p>
		</div>
	</div>
	<%
		if(request.getParameter("result")!=null){
			String str  = request.getParameter("result");
			if(str.equals("Failure")){
				out.print("<script>alert('Invalid login email, password or role');</script>");
				}
			else{
				out.print("<script>alert('Unknown Error');</script>");
				response.sendRedirect("logout.jsp");
			}
		}

	%>
		<div id="main-body">
		<form action="Login" method="post" onsubmit="return validate_login();">
			<h1>Login Form <a href="index.jsp">Quizy</a></h1>
			<h4>All fields required <span class="link blink_me" onclick="open_modals()">Know your password</span></h4>
			<div class="form-group">
				<label class="label">
					Email :
				</label>
				<div class="input-align">
					<input class="email" name="email" id="email" type="email">
				</div>
				<label class="label">
					Password :
				</label>
				<div class="input-align">
					<input class="password" id="pass" name="pass" type="password">
				</div>
				<label class="label">
					Role :
				</label>
				<div class="input-align">
					<select name="role">
					<option value="user">User</option>
					<option value="admin">Admin</option>
					
					</select>
				</div>
				<div class="input-align">
				<input class="submit" name="submit" type="submit" value="Login" >
				</div>
			</div>
		</form>
	</div>
	<div class="modal-one" id="modal-one">
		<div class="modal-content">
			<span class="closeBtn" onclick="close_modals()">&times;</span>
			<h3>User :</h3>
			<ul>
					<li>For the first time, your password is your D.O.B in format(ddmmyyyy).</li>
					<li>You can change it by visiting your profile.</li>
			</ul>
			<h3>Admin : </h3>
			<ul>
				<li>Use D.O.B(ddmmyyyy) for the first time.</li>
				<li>It is mandatory to change your password on first login.</li>
			</ul>
		</div>
	</div>
	</body>
</html>