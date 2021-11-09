import java.sql.*;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
public class Db_Utils {
	public static void main(String[] args) throws Exception{
	Class.forName("com.mysql.jdbc.Driver");
	String url="jdbc:mysql://localhost:3310/student?autoReconnect=true&useSSL=false";
	Connection con = DriverManager.getConnection(url,"root","mysql");
	String query = null;
	String[] ar = new String[20];
	HttpServletRequest request = null;
	ar[0] = request.getParameter("user1");

	}
	
	

}
