package dao;
import java.sql.*;
import java.util.*;

import util.DBUtil;

public class CashDao {
	public ArrayList<HashMap<String, Object>> selectCashListByMont(int year, int month) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT c.cash_no cashNo, c.cash_date cashDate, c.cash_price cashPrice, ct.category_no categoryNo, ct.category_kind categoryKind, ct.category_name categoryName\r\n"
				+ "FROM cash c\r\n"
				+ "INNER JOIN category ct\r\n"
				+ "ON c.category_no = ct.category_no\r\n"
				+ "WHERE YEAR(c.cash_date) = 2022 AND MONTH(c.cash_date) = 11\r\n"
				+ "ORDER BY cash_date ASC;";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, year);
		stmt.setInt(2, month);
		
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("cashNo", rs.getInt("cashNo"));
			m.put("cashDate", rs.getString("cashDate"));
			m.put("cashPrice", rs.getLong("cashPrice"));
			m.put("categoryNo", rs.getInt("categoryNo"));
			m.put("categoryKind", rs.getString("categoryKind"));
			m.put("categoryName", rs.getString("categoryName"));
			
			list.add(m);
		}
		
		
		rs.close();
		stmt.close();
		conn.close();
		return list;
	}
}
