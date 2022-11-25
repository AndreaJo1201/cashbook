package dao;

import java.sql.*;
import java.util.ArrayList;

import vo.*;
import util.*;

public class MemberDao {
	public Member login(Member paramMember) throws Exception { // null 값이면 로그인 실패, True면 로그인 성공
		Member resultMember = null;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT member_no memberNo, member_id memberId, member_name memberName, member_level memberLevel FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberId());
		stmt.setString(2, paramMember.getMemberPw());
		System.out.println("Prepare Statement SQL Query : "+ sql);
		
		
		ResultSet rs = stmt.executeQuery();
		System.out.println("SQL Query EXECUTE");
		
		if(rs.next()) {
			resultMember = new Member();
			resultMember.setMemberNo(rs.getInt("memberNo"));
			resultMember.setMemberId(rs.getString("memberId"));
			resultMember.setMemberName(rs.getString("memberName"));
			resultMember.setMemberLevel(rs.getInt("memberLevel"));
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
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		//중복검사(ID), ID, NAME, PW 유효성검사 필요.
		
		
		String sql = "INSERT INTO member (member_id, member_name, member_pw, updatedate, createdate) VALUES(?, ?, PASSWORD(?), NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberId());
		stmt.setString(2, paramMember.getMemberName());
		stmt.setString(3, paramMember.getMemberPw());
		
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
	
	//회원가입 신규 방법
	public int insertMember1(Member member) throws Exception {
		int row = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "INSERT INTO member (member_id, member_name, member_pw, updatedate, createdate) VALUES(?, ?, PASSWORD(?), NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, member.getMemberId());
		stmt.setString(2, member.getMemberName());
		stmt.setString(3, member.getMemberPw());
		
		row = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return row;
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
	
	//id중복확인 또다른 방법 > t:아이디가 중복, f:아이디를 사용가능
	public boolean selectMemberIdCheck(String memberId) throws Exception{
		boolean result = false;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT * FROM member WHERE member_id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			result = true;
		}
		
		dbUtil.close(rs, stmt, conn);
		
		return result;
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
	
	public boolean deleteMemberCheck(Member paramMember) throws Exception {
		boolean result = false;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql ="SELECT * FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberId());
		stmt.setString(2, paramMember.getMemberPw());
		
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			result = true;
		}
		
		dbUtil.close(rs, stmt, conn);
		
		return result;
	}
	
	public int deleteMember(Member paramMember) throws Exception {
		int row = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "DELETE FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberId());
		stmt.setString(2, paramMember.getMemberPw());
		
		row = stmt.executeUpdate();
		if(row == 0) {
			System.out.println("삭제 실패");
		} else {
			System.out.println("삭제 성공");
		}
		
		dbUtil.close(null, stmt, conn);
		
		return row;
	}
	
	
	//관리자 멤버 리스트
	public ArrayList<Member> selectMemberListByPage(int beginRow, int rowPerPage) throws Exception {
		ArrayList<Member> list = new ArrayList<Member>();
		
		/*
		 ORDER BY createdate DESC
		 */
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql="SELECT member_no memberNo, member_id memberId, member_name memberName, updatedate, createdate, member_level memberLevel FROM member ORDER BY createdate DESC LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			
			Member m = new Member();
			m.setMemberNo(rs.getInt("memberNo"));
			m.setMemberId(rs.getString("memberId"));
			m.setMemberName(rs.getString("memberName"));
			m.setMemberLevel(rs.getInt("memberLevel"));
			m.setCreatedate(rs.getString("createdate"));
			m.setUpdatedate(rs.getString("updatedate"));
			
			list.add(m);
		}
		
		return list;
	}
	
	//관리자용 회원강제탈퇴
	public int deleteMemberByAdmin(Member member) throws Exception {
		int row = 0;
		
		return row;
	}
	
	//관리자 : 회원 수 카운트 
	public int selectMemberCount( ) throws Exception {
		int row = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT COUNT(*) cnt FROM member";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			row = rs.getInt("cnt");
		}
		
		return row;
	}
	
	//관리자 멤버 레벨 수정
	public int updateMemberLevel(Member member) throws Exception {
		int row = 0;
		
		return row;
	}
}
