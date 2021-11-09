<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<h2>Rive Expenses</h2><br><br>
	<h2>-Add Expense</h2><br>
	<%
	String connectionURL = "jdbc:mysql://localhost:3310/student?autoReconnect=true&useSSL=false";
	Connection con=null;
	Statement st =null;
	ResultSet rs =null;
	try{
		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection(connectionURL,"root", "mysql");
		st = con.createStatement();
		rs = st.executeQuery("select username from rive_user");
// 		rs.next();
// 		String user1 = rs.getString(1);
// 		rs.next();
// 		String user2 = rs.getString(2);
// 		rs.next();
// 		String user3 = rs.getString(3);
		%>
		<form action="rive_expenses.jsp" method="get">
			<b>Total Amount : </b> <input type="number" name="amount"><br>
			<p><b>Paid By : </b>
			<input type="text" name="paidby"></p>
			
			<b>Split Between :</b><br>
			 <input type="checkbox" id="us1" name="user1" value="Aman">
  			 <label for="user1">Aman</label><br>
  			 
  			 <input type="checkbox" id="us2" name="user2" value="Devyansh">
  			 <label for="user2">Devyansh</label><br>
  			 
  			 <input type="checkbox" id="us3" name="user3" value="Dhruv">
  			 <label for="user3">Dhruv</label><br>
  			 
  			 <input type="checkbox" id="us1" name="user4" value="Mahender">
  			 <label for="user4">Mahender</label><br>
  			 
  			 <input type="checkbox" id="us2" name="user5" value="Manas">
  			 <label for="user5">Manas</label><br>
  			 
  			 <input type="checkbox" id="us3" name="user6" value="Naman">
  			 <label for="user6">Naman</label><br><br>
  			 
  			 <input type="submit" value="Split">			
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