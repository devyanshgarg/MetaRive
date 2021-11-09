<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
	String name= request.getParameter("uname");
	String password= request.getParameter("pwd");
	String connectionURL = "jdbc:mysql://localhost:3310/student?autoReconnect=true&useSSL=false";
	Connection connection = null;
	Statement statement = null;
	ResultSet rs = null;
	int flag=0;
	if(name!="" && password!=""){
		try {	
			Class.forName("com.mysql.jdbc.Driver");
			connection = DriverManager.getConnection(connectionURL, "root", "mysql");
			 statement = connection.createStatement();
			 rs = statement.executeQuery("select username,password from rive_user");
			while(rs.next()){
				if(name.equals(rs.getString(1)) && password.equals(rs.getString(2))){
					flag=1;
					break;
				}
			}
			if(flag==0){
				out.println("Invalid Credentials.");
			}
			else{
			response.sendRedirect("rive_view_last.jsp");
			statement.close();
			connection.close();}
			
		} catch (Exception e) {
			
		}finally
		{
			
		}
	}
	else{
		out.println("Both fields are mandatory to be filled.");
	}
%>

</body>
</html>