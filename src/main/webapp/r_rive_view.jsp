<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>R_RiVe_View</title>
</head>
<body>
	Hey, Welcome :<br><br>
	What do you plan on doing? <br><br>
	
	<form action="r_rive_add_expense.jsp">
		You want to add an expense . &emsp;
		<input type="submit" value="Add Expense">
	</form><br>
	
	<form action="r_rive_send_message.jsp">
		You want to send a message . &emsp;
		<input type="submit" value="Send Message">
	</form><br>
	
	<form action="r_rive_view_expenses.jsp">
		You want to view the expenses . &emsp;
		<input type="submit" value="View Expenses">
	</form><br>
	
	<form action="r_rive_view_messages.jsp">
		You want to view the messages . &emsp;
		<input type="submit" value="View Messages">
	</form><br>
</body>
</html>