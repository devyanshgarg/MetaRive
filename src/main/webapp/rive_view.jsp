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
	<h1>Rive Expenses</h1><br>
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
		String[] user = new String[20];
		String [] a = {"A","B","C","D","E","F","G","H","I","J"};
// 		rs.next();
// 		String user1 = rs.getString(1);
// 		rs.next();
// 		String user2 = rs.getString(2);
// 		rs.next();
// 		String user3 = rs.getString(3);
		%>
		<form action="rive_expenses.jsp" method="get">
			<b>Total Amount : </b> <input type="number" name="amount"><br>
			<p><b>Paid By  : </b>
			<input type="text" name="paidby"></p>
			<b>Split Between :</b><br>
			<% int i=0; 
			while(rs.next()) {
				user[i] = rs.getString(1);%>
				<input type="checkbox" id="userid" name="name[]" value=""/>
	  			<label for="userid"><%=user[i]%></label><br>
	  			<%i++;
			}
			%>
  			 <input type="submit" value="Split">			
		</form> 
		<%
		}
	catch(Exception e){
	}
	finally{
		st.close();
		con.close();
	}
	%>
</body>
</html>