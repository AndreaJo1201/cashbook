package dao;
import java.util.*;

import util.DBUtil;
import vo.*;
import java.sql.*;

public class NoticeDao {
	//loginForm.jsp 공지목록
	public ArrayList<Notice> selectNoticeListByPage(int beginRow, int rowPerPage) {
		ArrayList<Notice> list = null;
		
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "SELECT notice_no noticeNo, notice_memo noticeMemo, createdate FROM notice ORDER BY createdate DESC LIMIT ?, ?";
			
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			
			rs = stmt.executeQuery();
			
			list = new ArrayList<Notice>();
			
			while(rs.next()) {
				Notice n = new Notice();
				n.setNoticeNo(rs.getInt("noticeNo"));
				n.setNoticeMemo(rs.getString("noticeMemo"));
				n.setCreatedate(rs.getString("createdate"));
				
				list.add(n);
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
	
	//마지막 페이지 용 > 공지사항 전체 갯수 구하기
	public int selectNoticeCount() {
		int count = 0;
		
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql ="SELECT COUNT(*) FROM notice";
			
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				count = rs.getInt("COUNT(*)");
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
		return count;
	}
	
	public int insertNotice(Notice notice) {
		int row = 0;
		
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try {
			String sql = "INSERT notice(notice_memo, updatedate, createdate) VALUES(?, NOW(), NOW())";
			
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, notice.getNoticeMemo());
			
			row = stmt.executeUpdate();
			if(row == 0) {
				System.out.println("공지사항 등록실패");
			} else {
				System.out.println("공지사항 등록성공");
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
	
	public int updateNotice(Notice notice) {
		int row = 0;
		
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try {
			String sql = "UPDATE notice SET notice_memo = ?, updatedate = NOW() WHERE notice_no = ?";
			
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, notice.getNoticeMemo());
			stmt.setInt(2, notice.getNoticeNo());
			
			row = stmt.executeUpdate();
			if(row == 0) {
				System.out.println("공지사항 수정실패");
			} else {
				System.out.println("공지사항 수정성공");
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
	
	public int deleteNotice(Notice notice) {
		int row = 0;
		
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try {
			String sql = "DELETE FROM notice WHERE notice_no = ?";
			
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, notice.getNoticeNo());
			
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
	
	public Notice selectNoticeByNo(int noticeNo) {
		Notice notice = null;
	
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "SELECT notice_no noticeNo, notice_memo noticeMemo, createdate, updatedate FROM notice WHERE notice_no = ?";
			
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, noticeNo);
			
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				notice = new Notice();
				
				notice.setNoticeNo(rs.getInt("noticeNo"));
				notice.setNoticeMemo(rs.getString("noticeMemo"));
				notice.setUpdatedate(rs.getString("updatedate"));
				notice.setCreatedate(rs.getString("createdate"));
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
		return notice;
	}
	
}
