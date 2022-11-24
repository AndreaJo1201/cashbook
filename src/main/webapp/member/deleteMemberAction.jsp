<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>

<%
	Member loginMember = (Member)session.getAttribute("loginMember");

	Member paramMember = new Member();
	paramMember.setMemberId(request.getParameter("memberId"));
	paramMember.setMemberPw(request.getParameter("memberPw"));
	
	String memberPwCheck = request.getParameter("memberPwCheck");
	
	if(!loginMember.getMemberId().equals(paramMember.getMemberId())) {
		System.out.println("입력한 ID가 현재 정보와 일치하지 않습니다.");
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}
	
	if(!paramMember.getMemberPw().equals(memberPwCheck)) {
		System.out.println("비밀번호를 동일하게 입력해주세요.");
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}
	
	MemberDao memberDao = new MemberDao();
	
	if(!memberDao.deleteMemberCheck(paramMember)) {
		System.out.println("회원정보가 일치하지 않습니다.");
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}
	
	int deleteMember = memberDao.deleteMember(paramMember);
	
	if(deleteMember == 0) {
		System.out.println("action 삭제 실패");
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}
	
	session.invalidate();
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
	
	
%>