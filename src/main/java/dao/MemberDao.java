package dao;

import java.sql.*;
import java.util.ArrayList;

import vo.*;
import util.*;

public class MemberDao {
	public Member login(Member paramMember) { // null 값이면 로그인 실패, True면 로그인 성공
		Member resultMember = null;
		
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "SELECT member_no memberNo, member_id memberId, member_name memberName, member_level memberLevel FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
			
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramMember.getMemberId());
			stmt.setString(2, paramMember.getMemberPw());
			System.out.println("Prepare Statement SQL Query : "+ sql);
			
			rs = stmt.executeQuery();
			System.out.println("SQL Query EXECUTE");
			
			if(rs.next()) {
				resultMember = new Member();
				resultMember.setMemberNo(rs.getInt("memberNo"));
				resultMember.setMemberId(rs.getString("memberId"));
				resultMember.setMemberName(rs.getString("memberName"));
				resultMember.setMemberLevel(rs.getInt("memberLevel"));
				System.out.println("SQL Set");
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
		return resultMember;
	}
	
	public int insertMember(Member paramMember) {
		int resultRow = 0;
		
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		//중복검사(ID), ID, NAME, PW 유효성검사 필요.
		try {
			String sql = "INSERT INTO member (member_id, member_name, member_pw, updatedate, createdate) VALUES(?, ?, PASSWORD(?), NOW(), NOW())";
			
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramMember.getMemberId());
			stmt.setString(2, paramMember.getMemberName());
			stmt.setString(3, paramMember.getMemberPw());
			
			resultRow = stmt.executeUpdate();
			
			if(resultRow == 1) {
				System.out.println("INSERT Complete!");
			} else {
				System.out.println("INSERT False...");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(null, stmt, conn);
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return resultRow;
	}
	
	public int selectDuplicateInsertMember(Member paramMember) {
		int row = 0;
		
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "SELECT * FROM member WHERE member_id = ?";
			
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1,paramMember.getMemberId());
			
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				row = row + 1;
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
		return row;
	}
	
	/*id중복확인 또다른 방법 > t:아이디가 중복, f:아이디를 사용가능
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
	}*/
	
	public int updateMember(Member paramMember) {
		int row = 0;
		
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try {
			String sql = "UPDATE member SET member_id = ?, member_name = ?, updatedate = CURDATE() WHERE member_no = ?";
			
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramMember.getMemberId());
			stmt.setString(2, paramMember.getMemberName());
			stmt.setInt(3, paramMember.getMemberNo());
			
			row = stmt.executeUpdate();
			if(row == 0) {
				System.out.println("update false");
			} else {
				System.out.println("update complete");
			}
		} catch (Exception e) {
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
	
	public int selectDuplicateUpdateMember(Member paramMember, String sessionMemberId) {
		int row = 0;
		
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "SELECT member_id memberId FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
			
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramMember.getMemberId());
			stmt.setString(2, paramMember.getMemberPw());
			
			rs = stmt.executeQuery();
			if(rs.next()) {
				if(paramMember.getMemberId().equals(sessionMemberId)) {
					dbUtil.close(rs, stmt, conn);
					return row;
				} else {
					row = row + 1;
					System.out.println("duplicated ID");
					
					dbUtil.close(rs, stmt, conn);
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
					
					dbUtil.close(rs, stmt, conn);
					return row;
				}
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
	
	public int updateMemberPw(Member paramMember, String changePw) {
		int row = 0;
		
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "SELECT member_no memberNo, member_id memberId, member_pw memberPw FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
			
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramMember.getMemberId());
			stmt.setString(2, paramMember.getMemberPw());
			
			rs = stmt.executeQuery();
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
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(rs, stmt, conn);
			} catch(Exception e) {
				
			}
		}
		return row;
	}
	
	public boolean deleteMemberCheck(Member paramMember) {
		boolean result = false;
		
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql ="SELECT * FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
			
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramMember.getMemberId());
			stmt.setString(2, paramMember.getMemberPw());
			
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				result = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(rs, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return result;
	}
	
	public int deleteMember(Member paramMember) {
		int row = 0;
		
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try {
			String sql = "DELETE FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
			
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramMember.getMemberId());
			stmt.setString(2, paramMember.getMemberPw());
			
			row = stmt.executeUpdate();
			if(row == 0) {
				System.out.println("삭제 실패");
			} else {
				System.out.println("삭제 성공");
			}
		} catch (Exception e) {
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
	
	
	//관리자 멤버 리스트
	public ArrayList<Member> selectMemberListByPage(int beginRow, int rowPerPage) {
		ArrayList<Member> list = null;
		
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql="SELECT member_no memberNo, member_id memberId, member_name memberName, updatedate, createdate, member_level memberLevel FROM member ORDER BY member_level ASC, createdate DESC LIMIT ?, ?";
			
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			
			rs = stmt.executeQuery();
			
			list = new ArrayList<Member>();
			
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
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(rs, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	
	//관리자용 회원강제탈퇴
	public int deleteMemberByAdmin(Member member) {
		int row = 0;
		
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try {
			String sql = "DELETE FROM member WHERE member_no=? AND member_id=? AND member_level=?";
			
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, member.getMemberNo());
			stmt.setString(2, member.getMemberId());
			stmt.setInt(3, member.getMemberLevel());
			
			row = stmt.executeUpdate();
			if(row == 0) {
				System.out.println("탈퇴실패");
			} else {
				System.out.println("강제탈퇴성공");
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
	
	//관리자 : 회원 수 카운트 
	public int selectMemberCount( )  {
		int row = 0;
		
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "SELECT COUNT(*) cnt FROM member";
			
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			
			rs = stmt.executeQuery();
			if(rs.next()) {
				row = rs.getInt("cnt");
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
		return row;
	}
	
	//관리자 멤버 레벨 수정
	public int updateMemberLevel(Member member) {
		int row = 0;
		
		DBUtil dbUtil = null;
		Connection conn = null;	
		PreparedStatement stmt = null;
		
		try {
			String sql = "UPDATE member SET member_level = ?, updatedate = NOW() WHERE member_no = ? AND member_id = ?";
			
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, member.getMemberLevel());
			stmt.setInt(2, member.getMemberNo());
			stmt.setString(3, member.getMemberId());
			
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
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return row;
	}
	
	//관리자용 회원 선택기능
	public Member selectMemberByAdmin(String memberId)  {
		Member member = null;
		
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "SELECT * FROM member WHERE member_id = ?";
			
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			
			rs = stmt.executeQuery();
			member = new Member();
			
			if(rs.next()) {
				member.setMemberId(rs.getString("member_id"));
				member.setMemberName(rs.getString("member_name"));
				member.setMemberNo(rs.getInt("member_no"));
				member.setMemberLevel(rs.getInt("member_level"));
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
		return member;
	}
}
