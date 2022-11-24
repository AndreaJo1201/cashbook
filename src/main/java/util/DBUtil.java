package util;

import java.sql.*;
import vo.DataBase;

public class DBUtil {
	public Connection getConnection() throws Exception{
		DataBase db = new DataBase();
		
		Class.forName(db.getDriver());
		System.out.println("Driver Loading COMPLETE!");
		
		Connection conn = DriverManager.getConnection(db.getUrl(), db.getUser(), db.getPassword());
		System.out.println("DB Connection COMPLETE");
		
		return conn;
	}
	
	public void close(ResultSet rs, PreparedStatement stmt, Connection conn) throws Exception {
		if(rs != null) {
			rs.close();
		}
		if(stmt != null) {
			stmt.close();
		}
		if(conn != null) {
			conn.close();
		}
	}
}
