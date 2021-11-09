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
	<h2>Add Expense</h2><br>
	<%
	String connectionURL = "jdbc:mysql://localhost:3310/student?autoReconnect=true&useSSL=false";
	Connection con=null;
	Statement st =null;
	ResultSet rs =null;
	try{
		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection(connectionURL,"root", "mysql");
		st = con.createStatement();
		rs = st.executeQuery("select username from rrive_user");
		%>
		<form action="" method="get">
			<b>Total Amount : </b> <input type="number" name="amount"><br>
			<p><b>Paid By : </b>
			<input type="text" name="paidby"></p>
			
			<b>Paid For :</b>
			 <input type="text" name="between"><br><br>
  			 <input type="submit" value="R_RiVe">			
		</form> 
		<%	}
	catch(Exception e){
		
	}
	finally{
		st.close();
		con.close();
	}
	%>
</body>
</html>