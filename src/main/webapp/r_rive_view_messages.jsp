<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
	String u = (String) session.getAttribute("uuname");
	String connectionURL = "jdbc:mysql://localhost:3310/student?autoReconnect=true&useSSL=false";
	Connection con= null;
	Statement st = null;
	ResultSet alltable = null;
	String query1 = "select * from rrive_messages";
	try{
		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection(connectionURL,"root","mysql");
		st = con.createStatement();
		alltable = st.executeQuery(query1);
		alltable.beforeFirst();
		while(alltable.next()){
			if(alltable.getString(1).equals(u)){
				out.println("You messaged \"" + alltable.getString(3) + "\" to " + alltable.getString(2) + ".");%><br><%
			}
			else if(alltable.getString(2).equals(u)){
				out.println(alltable.getString(1) + " messaged You \"" + alltable.getString(3) + "\".");%><br><%
			}
			else{
			}
		}
	}
	catch (Exception e){
		
	}
%>
</body>
</html>