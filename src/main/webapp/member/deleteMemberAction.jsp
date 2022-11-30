<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>

<%
	if(session.getAttribute("loginMember") == null) { //비 로그인 페이지 접속 시 로그인 폼으로 안내
		String msg = "로그인이 필요합니다.";
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?&msg="+URLEncoder.encode(msg,"UTF-8"));
		return;
	}
	Member loginMember = (Member)session.getAttribute("loginMember");

	Member paramMember = new Member();
	paramMember.setMemberId(request.getParameter("memberId"));
	paramMember.setMemberPw(request.getParameter("memberPw"));
	
	String memberPwCheck = request.getParameter("memberPwCheck");
	
	String msg = null;
	
	if(!loginMember.getMemberId().equals(paramMember.getMemberId())) {
		msg = "입력한 ID가 현재 정보와 일치하지 않습니다.";
		System.out.println("입력한 ID가 현재 정보와 일치하지 않습니다.");
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp?msg="+URLEncoder.encode(msg,"UTF-8"));
		return;
	}
	
	if(!paramMember.getMemberPw().equals(memberPwCheck)) {
		msg = "비밀번호를 동일하게 입력해주세요.";
		System.out.println("비밀번호를 동일하게 입력해주세요.");
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp?msg="+URLEncoder.encode(msg,"UTF-8"));
		return;
	}
	
	MemberDao memberDao = new MemberDao();
	
	if(!memberDao.deleteMemberCheck(paramMember)) {
		msg = "회원정보가 일치하지 않습니다.";
		System.out.println("회원정보가 일치하지 않습니다.");
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp?msg="+URLEncoder.encode(msg,"UTF-8"));
		return;
	}
	
	int deleteMember = memberDao.deleteMember(paramMember);
	
	if(deleteMember == 0) {
		msg = "ERROR!";
		System.out.println("action 삭제 실패");
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp?msg="+URLEncoder.encode(msg,"UTF-8"));
		return;
	}
	
	msg = "회원탈퇴 성공!";
	session.invalidate();
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp"+URLEncoder.encode(msg,"UTF-8"));
	
	
%>