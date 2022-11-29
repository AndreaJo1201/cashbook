package dao;
import vo.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;

import util.DBUtil;

public class HelpDao {
	public int insertHelp(Help help) throws Exception { // 고객센터 문의글 작성
		int row = 0;
		
		String sql = "INSERT INTO help(help_memo, member_id, updatedate, createdate) VALUES (?, ?, NOW(), NOW())";
		
		DBUtil dbUtil = new DBUtil();
		
		Connection conn = null;
		PreparedStatement stmt = null;
		
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
		
		dbUtil.close(null, stmt, conn);
		
		return row;
	}
	
	public ArrayList<HashMap<String, Object>> selectHelpList(Help help) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		
		String sql = "SELECT h.*, c.* FROM HELP h LEFT OUTER JOIN COMMENT c ON h.help_no = c.help_no WHERE h.member_id = ? ORDER BY h.help_no DESC";
		
		DBUtil dbUtil = new DBUtil();
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, help.getMemberId());
		
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
		
		dbUtil.close(rs, stmt, conn);
		
		return list;
	}
	//관리자 측 selectHelpList - 오버로딩
	public ArrayList<HashMap<String, Object>> selectHelpList(int beginRow, int rowPerPage) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		
		String sql = "SELECT h.*, c.* FROM HELP h LEFT OUTER JOIN COMMENT c ON h.help_no = c.help_no ORDER BY h.help_no DESC LIMIT ?, ?";
		
		DBUtil dbUtil = new DBUtil();
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		
		rs = stmt.executeQuery();
		
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
		
		dbUtil.close(rs, stmt, conn);
		
		return list;
	}
	
	public Help selectHelp (int helpNo) throws Exception {
		Help help = null;
		
		String sql="SELECT * FROM help WHERE help_no = ?";
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, helpNo);
		
		rs = stmt.executeQuery();
		
		if(rs.next()) {
			help = new Help();
			help.setHelpMemo(rs.getString("help_memo"));
			help.setMemberId(rs.getString("member_id"));
			help.setCreatedate(rs.getString("createdate"));
		}
		
		return help;
	}

}
