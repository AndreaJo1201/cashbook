package dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DBUtil;
import vo.*;

public class CommentDao {
	
	//선택
	public Comment selectCommentOne(int commentNo) throws Exception {
		Comment comment = null;
		
		String sql = "SELECT * FROM comment WHERE comment_no = ?";
		
		DBUtil dbUtil = new DBUtil();
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, commentNo);
		
		rs = stmt.executeQuery();
		
		if(rs.next()) {
			comment = new Comment();
			comment.setCommentNo(rs.getInt("comment_no"));
			comment.setHelpNo(rs.getInt("help_no"));
			comment.setCommentMemo(rs.getString("comment_memo"));
			comment.setMemberId(rs.getString("member_id"));
			comment.setUpdatedate(rs.getString("updatedate"));
			comment.setCreatedate(rs.getString("createdate"));
		}
		
		dbUtil.close(rs, stmt, conn);
		
		return comment;
	}
	
	//추가
	public int insertComment(Comment comment) throws Exception {
		int row = 0;
		
		String sql = "INSERT INTO comment (help_no, comment_memo, member_id, updatedate, createdate) VALUES (?, ?, ?, NOW(), NOW()) ";
		
		DBUtil dbUtil = new DBUtil();
		
		Connection conn = null;
		PreparedStatement stmt = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, comment.getHelpNo());
		stmt.setString(2, comment.getCommentMemo());
		stmt.setString(3, comment.getMemberId());
		
		row = stmt.executeUpdate();
		
		if(row == 0) {
			System.out.println("추가실패");
		} else {
			System.out.println("추가 성공");
		}
		
		dbUtil.close(null, stmt, conn);
		
		return row;
	}
	
	
	//수정
	public int updateComment(Comment comment) throws Exception {
		int row = 0;
		
		String sql = "UPDATE comment SET comment_memo = ?, updatedate = NOW() WHERE comment_no = ?";
		
		DBUtil dbUtil = new DBUtil();
		
		Connection conn = null;
		PreparedStatement stmt = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, comment.getCommentMemo());
		stmt.setInt(2, comment.getCommentNo());
		
		row = stmt.executeUpdate();
		
		if(row == 0) {
			System.out.println("수정실패");
		} else {
			System.out.println("수정 성공");
		}
		
		dbUtil.close(null, stmt, conn);
		
		return row;
	}
	
	
	//삭제
	public int deleteComment(Comment comment) throws Exception {
		int row = 0;
		
		String sql = "DELETE FROM comment WHERE comment_no = ?";
		
		DBUtil dbUtil = new DBUtil();
		
		Connection conn = null;
		PreparedStatement stmt = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, comment.getCommentNo());
		
		row = stmt.executeUpdate();
		
		if(row == 0) {
			System.out.println("삭제실패");
		} else {
			System.out.println("삭제 성공");
		}
		
		dbUtil.close(null, stmt, conn);
		
		return row;
	}
}
