package util;

import java.sql.*;
import vo.DataBase;

public class DBUtil {
	public Connection getConnection() {
		DataBase db = null;
		Connection conn = null;
		
		try {
			db = new DataBase();
			
			Class.forName(db.getDriver());
			System.out.println("Driver Loading COMPLETE!");
			
			conn = DriverManager.getConnection(db.getUrl(), db.getUser(), db.getPassword());
			System.out.println("DB Connection COMPLETE");
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return conn;
	}
	
	public void close(ResultSet rs, PreparedStatement stmt, Connection conn) {
		try {
			if(rs != null) {
				rs.close();
			}
			if(stmt != null) {
				stmt.close();
			}
			if(conn != null) {
				conn.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
