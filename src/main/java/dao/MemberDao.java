package dao;

import java.sql.*;
import vo.*;
import util.*;

public class MemberDao {
	public Member login(Member paramMember) throws Exception { // null 값이면 로그인 실패, True면 로그인 성공
		Member resultMember = new Member();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT member_id memberId, member_name memberName FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberId());
		stmt.setString(2, paramMember.getMemberPw());
		
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			resultMember.setMemberId(rs.getString("memberId"));
			resultMember.setMemberName(rs.getString("memberName"));
		}
		
		rs.close();
		stmt.close();
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
		
		String sql = "INSERT INTO(member_id, member_name, member_pw, updatedate, createdate) VALUES(?, ?, PASSWORD(?), CURDATE(), CURDATE())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberId());
		stmt.setString(2, paramMember.getMemberName());
		stmt.setString(3, paramMember.getMemberPw());
		
		int row = stmt.executeUpdate();
		
		if(row == 1) {
			System.out.println("INSERT Complete!");
		} else {
			System.out.println("INSERT False...");
		}
		
		stmt.close();
		conn.close();
		
		return resultRow;
	}
}
