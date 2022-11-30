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
		if(loginMember.getMemberLevel() < 1) { // 관리자 레벨이 아닐시 가계부 페이지로 이동
			response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
			return;
		}
	}

	if(request.getParameter("memberNo") == null ||
		request.getParameter("memberNo").equals("") ||
		request.getParameter("memberId") == null ||
		request.getParameter("memberId").equals("") ||
		request.getParameter("memberLevel") == null ||
		request.getParameter("memberLevel").equals("")) { // 강제탈퇴 시키려는 사람의 정보가 없을 시 list 페이지로 이동
		response.sendRedirect(request.getContextPath()+"/admin/memberList.jsp");
	}

	Member member = new Member();
	member.setMemberNo(Integer.parseInt(request.getParameter("memberNo")));
	member.setMemberId(request.getParameter("memberId"));
	member.setMemberLevel(Integer.parseInt(request.getParameter("memberLevel")));
	
	MemberDao memberDao = new MemberDao();
	
	int row = memberDao.deleteMemberByAdmin(member);
	
	if(row == 0) { // 기능 동작 여부, 실패 시 삭제확인 폼 / 성공시 멤버 리스트 페이지 이동
		System.out.println("삭제실패");
		response.sendRedirect(request.getContextPath()+"/admin/member/deleteMemberByAdminForm.jsp?memberId="+member.getMemberId());
		return;
	} else {
		System.out.println("삭제 성공");
	}
	
	response.sendRedirect(request.getContextPath()+"/admin/memberList.jsp");
%>