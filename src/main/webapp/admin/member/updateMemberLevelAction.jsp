<%@page import="dao.MemberDao"%>
<%@page import="vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>

<%
	if(session.getAttribute("loginMember") == null) { // 세션 정보가 없을 시 로그인 페이지로 이동
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	} else {
		Member loginMember = (Member)session.getAttribute("loginMember");
		if(loginMember.getMemberLevel() < 1) { // 관리자 레벨이 아닐 시 가계부 페이지로 이동
			response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
			return;
		}
	}

	if(request.getParameter("memberNo") == null ||
		request.getParameter("memberNo").equals("") ||
		request.getParameter("memberId") == null ||
		request.getParameter("memberId").equals("") ||
		request.getParameter("memberLevel") == null ||
		request.getParameter("memberLevel").equals("")) { // 수정하려는 멤버의 정보가 없을시 list 페이지로 이동
			response.sendRedirect(request.getContextPath()+"/admin/memberList.jsp");
	}
	
	Member member = new Member();

	member.setMemberNo(Integer.parseInt(request.getParameter("memberNo")));
	member.setMemberId(request.getParameter("memberId"));
	member.setMemberLevel(Integer.parseInt(request.getParameter("memberLevel")));
	
	MemberDao memberDao = new MemberDao();
	
	int row = memberDao.updateMemberLevel(member);
	if (row == 0) { // 기능 작동 여부 / 작동 실패시 수정 폼으로, 성공시 list 페이지로 이동
		System.out.println("레벨수정이 실패");
		response.sendRedirect(request.getContextPath()+"/amdin/member/updateMemberLevelForm.jsp?memberId="+member.getMemberId());
	} else {
		System.out.println("레벨 수정 완료");
	}
	
	response.sendRedirect(request.getContextPath()+"/admin/memberList.jsp");
	return;
	
%>