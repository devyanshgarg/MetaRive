<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
	if(request.getParameter("sendotp")==null){
	%>
	<form action="r_fogetpw.jsp" method="get">
		Enter your Email : <input type="text" name="email"><br>
		<input type="submit" name="sendotp" value="Send OTP">
	</form><br><br><%
	}else{%>
	<form action="r_resetpw.jsp" method="get">
		Enter the OTP received : <input type="text" name="otp"><br>
		<input type="submit" name="verifyotp" value="Verify OTP">
	</form>
	<%} %>
</body>
</html>