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
<%
//	String [] a = {"A","B","C","D","E","F","G","H","I","J"};
//	String[] name = new String[20];
// 	for(int i=0;i<20;i++){
// 	name[i]= request.getParameter("name[]");
// 	if(name[i]!=""){
// 		count++;
// 	}
// 	}
// 	for(int i=0;i<count;i++){
// 		out.println(names[i]);
// 		}
// 	out.println(names);
	String ar[] = new String[20];
	String far[] = new String[20];
	int count=0, i =0;
	ar[0]= request.getParameter("user1");
	ar[1]= request.getParameter("user2");
	ar[2]= request.getParameter("user3");
	ar[3]= request.getParameter("user4");
	ar[4]= request.getParameter("user5");
	ar[5]= request.getParameter("user6");
	String paidby = request.getParameter("paidby");
	int amount = Integer.parseInt(request.getParameter("amount"));
	String connectionURL = "jdbc:mysql://localhost:3310/student?autoReconnect=true&useSSL=false";
	Connection connection = null;
	Statement statement1 = null;
	PreparedStatement pstatement1 = null;
	ResultSet rs1 = null;
	for(String s : ar){
		if(s!=null){
			far[i] = s;
			count++;
			i++;
		}
	}
	String query1 = "select paidby,paidfor from rive_expenses";
	String query2 = "insert into rive_expenses (paidby,paidfor,amount) values(?,?,?)";
	try{
		Class.forName("com.mysql.jdbc.Driver");
		connection = DriverManager.getConnection(connectionURL,"root","mysql");
		statement1 = connection.createStatement();
		rs1 = statement1.executeQuery(query1);
		pstatement1 = connection.prepareStatement(query2);
		//if there is no entry in the database
		if(rs1==null){
			for(int j=0;j<count;j++){
				pstatement1.setString(1,paidby);
				pstatement1.setInt(3,(amount/count));
				if(!(far[j].equals(paidby))){
					pstatement1.setString(2,far[j]);
					pstatement1.executeUpdate();
				}
				rs1.next();
			}
		}
		//if there are entries in db but they do not match the new entry
		else{
		int k=0;
		while(rs1.next()){
			//if there are entires in db but they dont match the new entry and paidby is same
			if(rs1.getString(1)==paidby){
				if((rs1.getString(2).equals(paidby)) || (rs1.getString(2).equals(far[k])) || (far[k].equals(paidby))){
					k++;
					continue;
				}
				else{
					pstatement1.setString(1,paidby);
					pstatement1.setString(2,far[k]);
					pstatement1.setInt(3,(amount/count));
					pstatement1.executeUpdate();
				}
			}
			else{
				//if there are entries in db but they dont match the new entry and paidby is df
				for(int j=0;j<count;j++){
					pstatement1.setString(1,paidby);
					pstatement1.setInt(3,(amount/count));
					if(!(far[j].equals(paidby))){
						pstatement1.setString(2,far[j]);
						pstatement1.executeUpdate();
					}
			}
		}
		
		
		}
	}
	}
	catch(Exception e){
		
	}
	finally{
		
	}
	
%>
</body>
</html>