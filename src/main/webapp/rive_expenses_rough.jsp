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
	ResultSet rs2 = null;
	ResultSet rs3 = null;
	ResultSet rs4 = null;
	ResultSet rs5 = null; //used when new entry is in paidby
	for(String s : ar){
		if(s!=null){
			far[i] = s;
			count++;
			i++;
		}
	}
	String query1 = "select * from rive_expenses";
	String query2 = "insert into rive_expenses (paidby,paidfor,amount) values(?,?,?)";
	String query3 = "select amount from rive_expenses where paidby=? and paidfor=?";
	String query4 = "update rive_expenses set amount=? where paidby=? and paidfor=?";
	try{
		Class.forName("com.mysql.jdbc.Driver");
		connection = DriverManager.getConnection(connectionURL,"root","mysql");
		statement1 = connection.createStatement();
		rs1 = statement1.executeQuery(query1);
		pstatement1 = connection.prepareStatement(query2);
		rs3 = statement1.executeQuery(query1);
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
		int l=0;
		int flag=0;//used to see if the person split bw is present in the db or not
		int flag2=0; // used with rs5
		int flag3=0; //to check the value of the paidby, if it is there in paidby/paidfor/db
		int tamount = 0;
		while(rs1.next()){
			//if there are entires in db but they dont match the new entry and paidby is same
			if(rs1.getString(1).equals(paidby)){
				//if the paidby is equal to the paidby in the db, there can be 3/4 cases now
				flag3=0;
				for(l=0;l<count;l++){
					if((rs1.getString(2).equals(far[l]))){
						pstatement1 = connection.prepareStatement(query3);
						pstatement1.setString(1,paidby);
						pstatement1.setString(2,far[l]);
						rs2 = pstatement1.executeQuery();
						int am = rs2.getInt(1);
						tamount = am + (amount/count);
						pstatement1 = connection.prepareStatement(query4);
						pstatement1.setInt(1,tamount);
						pstatement1.setString(2,paidby);
						pstatement1.setString(3,far[l]);
						pstatement1.executeUpdate();
					}
					else if(paidby.equals(far[l])){
						//if the person is equal to paidby, do nothing
					}
					else if(!(far[l].equals(rs1.getString(2)))){
						while(rs3.next()){
							//checking if the person split bw is present in the paidfor in db
							if(!(far[l].equals(rs3.getString(2)))){	
								//if not present flag=0, means entry not found
							}
							else if(far[l].equals(rs3.getString(2))){
								//if the person split bw is present in the table in any other row
								flag=1;
								break;
							}
						}
						if(flag==0){
							//now there can be 2 cases, 1)no entry 2)entry is in paidby
							statement1 = connection.createStatement();
							rs5 = statement1.executeQuery(query1);
							while(rs5.next()){
								if(far[l].equals(rs5.getString(1))){
									flag2=1;
									break;
								}
							}
							pstatement1.setString(1,paidby);
							pstatement1.setInt(3,(amount/count));
							pstatement1.setString(2,far[l]);
							pstatement1.executeUpdate();
						}
						else{
							//if the person is present in any other row, update the amount in db
							pstatement1 = connection.prepareStatement(query3);
							pstatement1.setString(1,paidby);
							pstatement1.setString(2,far[l]);
							rs4 = pstatement1.executeQuery();
							int am = rs4.getInt(1);
							tamount = am + (amount/count);
							pstatement1 = connection.prepareStatement(query4);
							pstatement1.setInt(1,tamount);
							pstatement1.setString(2,paidby);
							pstatement1.setString(3,far[l]);
							pstatement1.executeUpdate();
						}
					}
					else{}
				}
			}
			else if(rs1.getString(2).equals(paidby)){
				flag3=0;
				//if there are entries in db and the paidby is equal to the paidfor in the db for that particular row, so we will update the amount
				for(int j=0;j<count;j++){
					pstatement1.setString(1,paidby);
					pstatement1.setInt(3,(amount/count));
					pstatement1.setString(2,far[j]);
					pstatement1.executeUpdate();	
			}
		}
			else{
				flag3=1;
			}
		
		}
		//insert the new entry here
		if(flag3==1){
			for(int j=0;j<count;j++){
				pstatement1.setString(1,paidby);
				pstatement1.setInt(3,(amount/count));
				pstatement1.setString(2,far[j]);
				pstatement1.executeUpdate();	
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