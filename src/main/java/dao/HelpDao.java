package dao;
import vo.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;

import util.DBUtil;

public class HelpDao {
	public int insertHelp(Help help) { // 고객센터 문의글 작성
		int row = 0;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try {
			String sql = "INSERT INTO help(help_memo, member_id, updatedate, createdate) VALUES (?, ?, NOW(), NOW())";
			
			dbUtil = new DBUtil();
			
			conn = null;
			stmt = null;
			
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, help.getHelpMemo());
			stmt.setString(2, help.getMemberId());
			
			row = stmt.executeUpdate();
			
			if(row == 0) {
				System.out.println("작성실패");
			} else {
				System.out.println("작성성공");
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
	
	public ArrayList<HashMap<String, Object>> selectHelpList(Help help) {
		ArrayList<HashMap<String, Object>> list = null;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "SELECT h.*, c.* FROM help h LEFT OUTER JOIN comment c ON h.help_no = c.help_no WHERE h.member_id = ? ORDER BY h.help_no DESC";
			
			dbUtil = new DBUtil();
			
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, help.getMemberId());
			
			rs = stmt.executeQuery();
			
			list = new ArrayList<HashMap<String,Object>>();
			
			while(rs.next()) {
				HashMap<String, Object> h = new HashMap<String, Object>();
				h.put("helpNo", rs.getInt("h.help_no"));
				h.put("helpMemo", rs.getString("h.help_memo"));
				h.put("memberId", rs.getString("h.member_id"));
				h.put("helpUpdateDate", rs.getString("h.updatedate"));
				h.put("helpCreatedate", rs.getString("h.createdate"));
				
				h.put("commentNo", rs.getInt("c.comment_no"));
				h.put("commentMemberId", rs.getString("c.member_id"));
				h.put("commentMemo", rs.getString("c.comment_memo"));
				h.put("commentUpdateDate", rs.getString("c.updatedate"));
				h.put("commentCreateDate", rs.getString("c.createdate"));
				
				list.add(h);
			}
		} catch (Exception e) {
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
	//관리자 측 selectHelpList - 오버로딩
	public ArrayList<HashMap<String, Object>> selectHelpList(int beginRow, int rowPerPage) {
		ArrayList<HashMap<String, Object>> list = null;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		
		try {
			String sql = "SELECT h.*, c.* FROM help h LEFT OUTER JOIN comment c ON h.help_no = c.help_no ORDER BY h.help_no DESC LIMIT ?, ?";
			
			dbUtil = new DBUtil();
			
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			
			rs = stmt.executeQuery();
			list = new ArrayList<HashMap<String, Object>>();
			while(rs.next()) {
				HashMap<String, Object> h = new HashMap<String, Object>();
				h.put("helpNo", rs.getInt("h.help_no"));
				h.put("helpMemo", rs.getString("h.help_memo"));
				h.put("memberId", rs.getString("h.member_id"));
				h.put("helpUpdateDate", rs.getString("h.updatedate"));
				h.put("helpCreateDate", rs.getString("h.createdate"));
				
				h.put("commentNo", rs.getInt("c.comment_no"));
				h.put("commentMemberId", rs.getString("c.member_id"));
				h.put("commentMemo", rs.getString("c.comment_memo"));
				h.put("commentUpdateDate", rs.getString("c.updatedate"));
				h.put("commentCreateDate", rs.getString("c.createdate"));
				
				list.add(h);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try{
				dbUtil.close(rs, stmt, conn);
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		return list;
	}
	
	public Help selectHelp (int helpNo) {
		Help help = null;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql="SELECT * FROM help WHERE help_no = ?";
			
			dbUtil = new DBUtil();
			
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, helpNo);
			
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				help = new Help();
				help.setHelpNo(rs.getInt("help_no"));
				help.setHelpMemo(rs.getString("help_memo"));
				help.setMemberId(rs.getString("member_id"));
				help.setCreatedate(rs.getString("createdate"));
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
		
		return help;
	}
	
	public int updateHelp (Help help) {
		int row = 0;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try {
			String sql ="UPDATE help SET help_memo = ? WHERE help_no =? AND member_id = ? ";
			
			dbUtil = new DBUtil();
			
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, help.getHelpMemo());
			stmt.setInt(2, help.getHelpNo());
			stmt.setString(3, help.getMemberId());
			
			row = stmt.executeUpdate();
			
			if(row == 0) {
				System.out.println("업데이트 실패");
			} else {
				System.out.println("업데이트 성공");
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(null, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return row;
	}
	
	public int deleteHelp (Help help) {
		int row = 0;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try {
			String sql ="DELETE FROM help WHERE help_no =? AND member_id = ? ";
			
			dbUtil = new DBUtil();
			
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, help.getHelpNo());
			stmt.setString(2, help.getMemberId());
			
			row = stmt.executeUpdate();
			
			if(row == 0) {
				System.out.println("삭제 실패");
			} else {
				System.out.println("삭제 성공");
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
	
	public int selectHelpListCount() {
		int row = 0;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql ="SELECT COUNT(*) cnt FROM help";
			
			dbUtil = new DBUtil();
			
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				row = rs.getInt("cnt");
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
		return row;
	}
	
	public ArrayList<HashMap<String, Object>> selectHelpListOne(Help help) {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "SELECT h.*, c.* FROM HELP h LEFT OUTER JOIN COMMENT c ON h.help_no = c.help_no WHERE h.member_id = ? AND h.help_no = ? ORDER BY h.help_no DESC";
			
			dbUtil = new DBUtil();
			
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, help.getMemberId());
			stmt.setInt(2, help.getHelpNo());
			
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				HashMap<String, Object> h = new HashMap<String, Object>();
				h.put("helpNo", rs.getInt("h.help_no"));
				h.put("helpMemo", rs.getString("h.help_memo"));
				h.put("memberId", rs.getString("h.member_id"));
				h.put("helpUpdateDate", rs.getString("h.updatedate"));
				h.put("helpCreatedate", rs.getString("h.createdate"));
				
				h.put("commentNo", rs.getInt("c.comment_no"));
				h.put("commentMemberId", rs.getString("c.member_id"));
				h.put("commentMemo", rs.getString("c.comment_memo"));
				h.put("commentUpdateDate", rs.getString("c.updatedate"));
				h.put("commentCreateDate", rs.getString("c.createdate"));
				
				list.add(h);
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
}
