<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, java.util.Arrays, java.io.StringWriter, java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>RiVe</title>
</head>
<body>
<%
	String paidfor = request.getParameter("between");
	String userpaidby = request.getParameter("paidby");
	int amount = Integer.parseInt(request.getParameter("amount"));
	String[] userpaidfor = paidfor.split(",");
	int length = userpaidfor.length;
	String connectionURL = "jdbc:mysql://localhost:3310/student?autoReconnect=true&useSSL=false";
	Connection con=null;
	Statement st =null;
	ResultSet alltable = null;
	String query1 = "select * from rive_expenses";
	String query2 = "insert into rive_expenses (`paidby`,`paidfor`,`amount`) values (?,?,?)";
	String query3 = "select amount from rive_expenses where paidby=? and paidfor=?";
	int result = 0;
	try{
		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection(connectionURL,"root","mysql");
		st = con.createStatement();
		alltable = st.executeQuery(query1);
		for(int i=0;i<length;i++){
			alltable.beforeFirst();
			flag1=0;
			findHistory(userpaidby,userpaidfor[i], alltable);
			if(flag1 == 1){
				ifResultSame(userpaidby, userpaidfor[i], amount, length, connectionURL, con);
				}
			if(flag1 == -1){
				ifResultOpposite(userpaidby, userpaidfor[i], amount, length, connectionURL, con);
				}
			if (flag1 == 0){
				ifResultNoHist(userpaidby, userpaidfor[i], amount, length, connectionURL, con);
			}
		}%><br><%
		
	}
	catch(Exception e){
	}
	finally{
		ResultSet fulltable = st.executeQuery("select * from rive_expenses");
		fulltable.beforeFirst();
		for(int j=0;j<length;j++){
			while(fulltable.next()){
				if(fulltable.getInt(3)>=0){
					out.println(fulltable.getString(2) + " owes " + fulltable.getInt(3) + " to " + fulltable.getString(1) + ".");%><br><%
				}
				else{
					out.println(fulltable.getString(1) + " owes " + (-(fulltable.getInt(3))) + " to " + fulltable.getString(2) + ".");%><br><%
				}
			}
		}
	}
%>
<%!
	int flag1= 0;
	public void ifResultSame(String userpaidby, String userpaidfor, int amount, int length, String connectionURL, Connection con) throws Exception{
		PreparedStatement samepst = null;
		String query3 = "select amount from rive_expenses where paidby=? and paidfor=?";
		String query4 = "update rive_expenses set amount=? where paidby=? and paidfor=?";
		samepst = con.prepareStatement(query3);
		samepst.setString(1,userpaidby);
		samepst.setString(2,userpaidfor);
		ResultSet samers = samepst.executeQuery();
		samers.next();
		int sameam = samers.getInt(1);
		int finalamount = sameam + (amount/length);
		samepst = con.prepareStatement(query4);
		samepst.setInt(1,finalamount);
		samepst.setString(2,userpaidby);
		samepst.setString(3,userpaidfor);
		samepst.executeUpdate();
	}
	public void ifResultOpposite(String userpaidby, String userpaidfor, int amount, int length, String connectionURL, Connection con) throws Exception{
		PreparedStatement opppst = null;
		String query3 = "select amount from rive_expenses where paidby=? and paidfor=?";
		String query4 = "update rive_expenses set amount=? where paidby=? and paidfor=?";
		opppst = con.prepareStatement(query3);
		opppst.setString(1,userpaidfor);
		opppst.setString(2,userpaidby);
		ResultSet opprs = opppst.executeQuery();
		opprs.next();
		int oppam = opprs.getInt("amount");
		int finalamount = oppam - (amount/length);
		opppst = con.prepareStatement(query4);
		opppst.setInt(1,finalamount);
		opppst.setString(2,userpaidfor);
		opppst.setString(3,userpaidby);
		opppst.executeUpdate();
	}
	public void ifResultNoHist(String userpaidby, String userpaidfor, int amount, int length, String connectionURL, Connection con){
		try{
			PreparedStatement nohistpst = null;
		String query2 = "insert into rive_expenses (`paidby`,`paidfor`,`amount`) values (?,?,?)";
		nohistpst = con.prepareStatement(query2);
		int finalamount = amount/length;
		nohistpst.setString(1,userpaidby);
		nohistpst.setString(2,userpaidfor);
		nohistpst.setInt(3,finalamount);
		nohistpst.executeUpdate();
		}
		catch (Exception e){
			System.out.println(e);
		}
	}
	public void findHistory(String userpaidby, String userpaidfor, ResultSet alltable){
		try{
			while(alltable.next()){
				String tablepaidby = alltable.getString(1);
				String tablepaidfor = alltable.getString(2);
				if(tablepaidby.equals(userpaidby) && tablepaidfor.equals(userpaidfor)){
					flag1=1;
					break;
				}
				else if(tablepaidby.equals(userpaidfor) && tablepaidfor.equals(userpaidby)){
					flag1=-1;
					break;
				}
			}
		}
		catch(Exception e){
			 e.printStackTrace();
		}
	}
	
%>
</body>
</html>