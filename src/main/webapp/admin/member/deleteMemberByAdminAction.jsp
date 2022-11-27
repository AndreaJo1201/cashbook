<%@page import="dao.MemberDao"%>
<%@page import="vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>

<%
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