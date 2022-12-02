package dao;
import vo.*;
import java.sql.*;
import java.util.*;

import util.DBUtil;

public class CashDao {
	
	//호출 : cashDateList.jsp
	public ArrayList<HashMap<String, Object>> selectCashListByDate(String memberId, int year, int month, int date) {
		ArrayList<HashMap<String, Object>> list = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DBUtil dbutil = null;
		
		try {
			dbutil = new DBUtil();
			conn = dbutil.getConnection();
			
			
			String sql = "SELECT c.cash_no cashNo, c.cash_date cashDate, c.cash_price cashPrice, c.cash_memo cashMemo, ct.category_kind categoryKind, ct.category_name categoryName\r\n"
					+ "FROM cash c\r\n"
					+ "INNER JOIN category ct\r\n"
					+ "ON c.category_no = ct.category_no\r\n"
					+ "WHERE YEAR(c.cash_date) = ? AND MONTH(c.cash_date) = ? AND DAY(c.cash_date) = ? AND c.member_id = ?\r\n"
					+ "ORDER BY c.cash_date ASC, ct.category_kind ASC;";
			
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, year);
			stmt.setInt(2, month);
			stmt.setInt(3, date);
			stmt.setString(4, memberId);
			rs = stmt.executeQuery();
			
			list = new ArrayList<HashMap<String, Object>>();
			
			while(rs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("cashNo", rs.getInt("cashNo"));
				m.put("cashDate", rs.getString("cashDate"));
				m.put("cashPrice", rs.getLong("cashPrice"));
				m.put("cashMemo", rs.getString("cashMemo"));
				m.put("categoryKind", rs.getString("categoryKind"));
				m.put("categoryName", rs.getString("categoryName"));
				
				list.add(m);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbutil.close(rs, stmt, conn);
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	
	// 호출 : cashList.jsp
	public ArrayList<HashMap<String, Object>> selectCashListByMont(int year, int month, String memberId) { // 전달받은 연,월,session ID값으로 list에 값 저장 후 return
		ArrayList<HashMap<String, Object>> list = null;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			String sql = "SELECT c.cash_no cashNo, c.cash_date cashDate, c.cash_price cashPrice, ct.category_no categoryNo, ct.category_kind categoryKind, ct.category_name categoryName\r\n"
					+ "FROM cash c\r\n"
					+ "INNER JOIN category ct\r\n"
					+ "ON c.category_no = ct.category_no\r\n"
					+ "WHERE YEAR(c.cash_date) = ? AND MONTH(c.cash_date) = ? AND c.member_id = ?\r\n"
					+ "ORDER BY c.cash_date ASC, ct.category_kind ASC;";
			
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, year);
			stmt.setInt(2, month);
			stmt.setString(3, memberId);
			rs = stmt.executeQuery();
			
			list = new ArrayList<HashMap<String, Object>>();
			
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
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(rs, stmt, conn);
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		return list;
	}
	
	public int deleteCashListByDate(int cashNo) throws Exception {
		int row = 0;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			String sql = "DELETE FROM cash WHERE cash_no = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, cashNo);
			
			row = stmt.executeUpdate();
			
			if(row == 1) {
				System.out.println("DELETE COMPLETE");
			} else {
				System.out.println("DELETE FALSE");
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(null, stmt, conn);
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return row;
	}
	
	public int updateCashListByDate(int cashNo, int categoryNo, String cashDate, long cashPrice, String cashMemo) {
		int row = 0;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			String sql = "UPDATE cash SET category_no = ?, cash_date = ?, cash_price = ?, cash_memo = ?, updatedate = CURDATE() WHERE cash_no = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, categoryNo);
			stmt.setString(2, cashDate);
			stmt.setLong(3, cashPrice);
			stmt.setString(4, cashMemo);
			stmt.setInt(5, cashNo);
			
			row = stmt.executeUpdate();
		
			
			if(row == 1) {
				System.out.println("UPDATE COMPLETE");
			} else {
				System.out.println("UPDATE FALSE");
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(null, stmt, conn);
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return row;
	}
	
	public Cash selectUpdateCashData(int cashNo) {
		Cash cash = null;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			String sql = "SELECT cash_no cashNo, category_no categoryNo, cash_date cashDate, cash_price cashPrice, cash_memo cashMemo, updatedate FROM cash Where cash_no = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, cashNo);
			
			rs = stmt.executeQuery();
			cash = new Cash();
			if(rs.next()) {
				cash.setCashNo(rs.getInt("cashNo"));
				cash.setCategoryNo(rs.getInt("categoryNo"));
				cash.setCashDate(rs.getString("cashDate"));
				cash.setCashPrice(rs.getLong("cashPrice"));
				cash.setCashMemo(rs.getString("cashMemo"));
				cash.setUpdatedate(rs.getString("updatedate"));
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(rs, stmt, conn);
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return cash;
	}
	
	public int insertCashListByDate(Cash cash) {
		int row = 0;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			String sql = "INSERT INTO cash (category_no, member_id, cash_date, cash_price, cash_memo, updatedate, createdate) VALUES(?, ?, ?, ?, ?, CURDATE(), CURDATE())";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, cash.getCategoryNo());
			stmt.setString(2, cash.getMemberId());
			stmt.setString(3, cash.getCashDate());
			stmt.setLong(4, cash.getCashPrice());
			stmt.setString(5, cash.getCashMemo());
			
			
			row = stmt.executeUpdate();
			if(row == 0) {
				System.out.println("insert false");
			} else {
				System.out.println("insert complete");
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(null, stmt, conn);
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		return row;
	}
}
