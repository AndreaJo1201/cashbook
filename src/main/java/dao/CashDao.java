package dao;
import java.sql.*;
import java.util.*;

import util.DBUtil;

public class CashDao {
	public ArrayList<HashMap<String, Object>> selectCashListByMont(int year, int month, String memberId) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT c.cash_no cashNo, c.cash_date cashDate, c.cash_price cashPrice, ct.category_no categoryNo, ct.category_kind categoryKind, ct.category_name categoryName\r\n"
				+ "FROM cash c\r\n"
				+ "INNER JOIN category ct\r\n"
				+ "ON c.category_no = ct.category_no\r\n"
				+ "WHERE YEAR(c.cash_date) = ? AND MONTH(c.cash_date) = ? AND c.member_id = ?\r\n"
				+ "ORDER BY c.cash_date ASC, ct.category_kind ASC;";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, year);
		stmt.setInt(2, month);
		stmt.setString(3, memberId);
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
