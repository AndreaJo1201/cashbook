<%@page import="dao.MemberDao"%>
<%@page import="vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>

<%
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	} else {
		Member loginMember = (Member)session.getAttribute("loginMember");
		if(loginMember.getMemberLevel() < 1) {
			response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
			return;
		}
	}

	if(request.getParameter("memberNo") == null ||
		request.getParameter("memberNo").equals("") ||
		request.getParameter("memberId") == null ||
		request.getParameter("memberId").equals("") ||
		request.getParameter("memberLevel") == null ||
		request.getParameter("memberLevel").equals("")) {
		response.sendRedirect(request.getContextPath()+"/admin/memberList.jsp");
	}

	Member member = new Member();
	member.setMemberNo(Integer.parseInt(request.getParameter("memberNo")));
	member.setMemberId(request.getParameter("memberId"));
	member.setMemberLevel(Integer.parseInt(request.getParameter("memberLevel")));
	
	MemberDao memberDao = new MemberDao();
	
	int row = memberDao.deleteMemberByAdmin(member);
	
	if(row == 0) {
		System.out.println("삭제실패");
		response.sendRedirect(request.getContextPath()+"/admin/member/deleteMemberByAdminForm.jsp?memberId="+member.getMemberId());
		return;
	} else {
		System.out.println("삭제 성공");
	}
	
	response.sendRedirect(request.getContextPath()+"/admin/memberList.jsp");
%>