<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
		<title>Sign up</title>
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
	<div id="main-body">
		<form action="Signup" method="post" onsubmit="return validate_signup()" name="form-signup">
			<h1>Sign Up Form <a href="index.jsp">Quizy</a></h1>
			<div class="form-group">
				<label class="label">
					Enrollment Id:
				</label>
				<div class="input-align">
					<input class="enroll" id="enroll" name="enroll" type="text">
				</div>
				<label class="label">
					Full Name:
				</label>
				<div class="input-align">
					<input class="name" id="name" name="name" type="text">
				</div>
				<label class="label">
					Email:
				</label>
				<div class="input-align">
					<input class="email" id="email" name="email" type="email">
				</div>
				<label class="label"  title="Date of Birth">
					DOB:
				</label>
				<div class="input-align">
					<input class="dob" id="dob" name="dob" type="date">
				</div>
				<label class="label">
					Role:
				</label>
				<div class="input-align">
					<select  id="role" name="role" onchange="field_akey(this)">
					<option value="user" selected>User</option>
					<option value="admin">Admin</option>
					
					</select>
				</div>
				<label class="label">
					Key: 
				</label>
				<div class="input-align">
					<input class="password" id="akey" name="akey" type="password" disabled>
					<span class="link blink_me" onclick="open_modals()">What's this</span>
				</div>
				<div class="input-align">
				<input class="submit" name="submit" type="submit" value="SignUp">
				</div>
			</div>
		</form>
	</div>
	<div class="modal-one" id="modal-one">
		<div class="modal-content">
			<span class="closeBtn" onclick="close_modals()">&times;</span>
			<h3>Only for admins <strong>NOT REQUIRED FOR USER</strong></h3>
			<ul>
					<li>Contact the developer to get the key.</li>
					<li>Key is mandatory to sign up as an admin who can create and host quiz(s).</li>
			</ul>
		</div>
	</div>
</body>
</html>
