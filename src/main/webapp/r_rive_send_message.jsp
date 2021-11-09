<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>R_RiVe</title>
</head>
<body>
	<h1>R_RiVe</h1>
	<h2>Send Message</h2><br>
		<form action="" method="get">
			<b>Your Message  : </b> <input type="text" name="message"><br>
			<p><b>Sent By : </b>
			<input type="text" name="sentby"></p>
			
			<b>Send To :</b>
			 <input type="text" name="sentto"><br><br>
  			 <input type="submit" value="Send Message">			
		</form> 
</body>
</html>