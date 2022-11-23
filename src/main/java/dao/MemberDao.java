package dao;

import java.sql.*;
import vo.*;
import util.*;

public class MemberDao {
	public Member login(Member paramMember) throws Exception { // null 값이면 로그인 실패, True면 로그인 성공
		Member resultMember = new Member();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT member_no memberNo, member_id memberId, member_name memberName FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberId());
		stmt.setString(2, paramMember.getMemberPw());
		System.out.println("Prepare Statement SQL Query : "+ sql);
		
		
		ResultSet rs = stmt.executeQuery();
		System.out.println("SQL Query EXECUTE");
		
		if(rs.next()) {
			resultMember.setMemberNo(rs.getInt("memberNo"));
			resultMember.setMemberId(rs.getString("memberId"));
			resultMember.setMemberName(rs.getString("memberName"));
			System.out.println("SQL Set");
		}
		
		System.out.println("ResultSet CLOSE");
		rs.close();
		System.out.println("Statement CLOSE");
		stmt.close();
		System.out.println("DB Connection CLOSE");
		conn.close();
		
		return resultMember;
	}
	
	public int insertMember(Member paramMember) throws Exception {
		int resultRow = 0;
		
		/*
		DataBase db = new DataBase();
		
		Class.forName(db.getDriver());
		Connection conn = DriverManager.getConnection(db.getUrl(), db.getUser(), db.getPassword());
		-> DB 연결하는 코드는 DAO 메서드에서 거의 공통으로 중복
		-> 중복되는 코드를 하나의 이름(메서드)로 만들자
		-> 입력값과 반환값 결정
		-> 입력값 X, 반환값 : Connection타입의 결과값.
		*/
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		//중복검사(ID), ID, NAME, PW 유효성검사 필요.
		
		
		String sql = "INSERT INTO member (member_id, member_name, member_pw, updatedate, createdate) VALUES(?, ?, PASSWORD(?), NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberId());
		stmt.setString(2, paramMember.getMemberName());
		
		resultRow = stmt.executeUpdate();
		
		if(resultRow == 1) {
			System.out.println("INSERT Complete!");
		} else {
			System.out.println("INSERT False...");
		}
		
		stmt.close();
		conn.close();
		
		return resultRow;
	}
	
	public int selectDuplicateInsertMember(Member paramMember) throws Exception {
		int row = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT * FROM member WHERE member_id = ?";
		PreparedStatement stmt =conn.prepareStatement(sql);
		stmt.setString(1,paramMember.getMemberId());
		
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			row = row + 1;
		}
		
		return row;
	}
	
	public int updateMember(Member paramMember) throws Exception {
		int row = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "UPDATE member SET member_id = ?, member_name = ?, updatedate = CURDATE() WHERE member_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberId());
		stmt.setString(2, paramMember.getMemberName());
		stmt.setInt(3, paramMember.getMemberNo());
		
		row = stmt.executeUpdate();
		if(row == 0) {
			System.out.println("update false");
		} else {
			System.out.println("update complete");
		}
		
		stmt.close();
		conn.close();
		
		return row;
	}
	
	public int selectDuplicateUpdateMember(Member paramMember, String sessionMemberId) throws Exception {
		int row = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT member_id memberId FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberId());
		stmt.setString(2, paramMember.getMemberPw());
		
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			if(paramMember.getMemberId().equals(sessionMemberId)) {
				rs.close();
				stmt.close();
			} else {
				row = row + 1;
				System.out.println("duplicated ID");
				
				rs.close();
				stmt.close();
				conn.close();
				return row;
			}
		} else {
			rs.close();
			stmt.close();
			
			sql = "SELECT member_id memberId FROM member WHERE member_id = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramMember.getMemberId());
			
			rs = stmt.executeQuery();
			if(rs.next()) {
				row = row + 1;
				System.out.println("duplicated ID");
				
				rs.close();
				stmt.close();
				conn.close();
				return row;
			} else {
				rs.close();
				stmt.close();
				conn.close();
			}
		}

		return row;
	}
	
	public int updateMemberPw(Member paramMember, String changePw) throws Exception {
		int row = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT member_no memberNo, member_id memberId, member_pw memberPw FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberId());
		stmt.setString(2, paramMember.getMemberPw());
		
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			
			sql = "UPDATE member SET member_pw = PASSWORD(?) WHERE member_id = ?";
			
			PreparedStatement updateStmt = conn.prepareStatement(sql);
			updateStmt.setString(1, changePw);
			updateStmt.setString(2, paramMember.getMemberId());
			
			row = updateStmt.executeUpdate();
			
			if(row == 0) {
				System.out.println("update false:변경을 실패");
			} else {
				System.out.println("update complete");
			}
			
			updateStmt.close();
			
		 } else {
			 System.out.print("update false : 현재비밀번호 틀림");
		 }
		
		rs.close();
		stmt.close();
		conn.close();
		
		return row;
	}
}
