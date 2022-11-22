package dao;
import java.sql.*;
import java.util.*;

import util.DBUtil;

public class CashDateDao {
	public ArrayList<HashMap<String, Object>> selectCashDateList(int year, int month, String date, String ID) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT c.cash_price cashPrice, c.cash_memo cashMemo, ct.category_name categoryName, ct.category_kind categoryKind FROM cash c INNER JOIN category ct ON c.category_no = ct.category_no WHERE YEAR(c.cash_date) = ? AND MONTH(c.cash_date) = ? AND DAY(c.cash_date) = ? AND c.member_id = ? ORDER BY ct.category_kind ASC;";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, year);
		stmt.setInt(2, month);
		stmt.setString(3, date);
		stmt.setString(4, ID);
		
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("cashPrice", rs.getLong("cashPrice"));
			m.put("cashMemo", rs.getString("cashMemo"));
			m.put("categoryName", rs.getString("categoryName"));
			m.put("categoryKind", rs.getString("categoryKind"));
			
			list.add(m);
		}
		
		rs.close();
		stmt.close();
		conn.close();
		
		return list;
	}
}
