<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.net.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>

<%
	if(session.getAttribute("loginMember") == null) { //비 로그인 페이지 접속 시 로그인 폼으로 안내
		String msg = "로그인이 필요합니다.";
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?&msg="+URLEncoder.encode(msg,"UTF-8"));
		return;
	}
	
	if(request.getParameter("memberId") == null ||
		request.getParameter("memberId").equals("") ||
		request.getParameter("memberName") == null ||
		request.getParameter("memberName").equals("") ||
		request.getParameter("memberPw") == null ||
		request.getParameter("memberPw").equals("")) {
			String msg = "빈칸을 입력해주세요.";
			response.sendRedirect(request.getContextPath()+"/member/updateMemberForm.jsp?msg="+URLEncoder.encode(msg,"UTF-8"));
			return;
	}
	
	Member loginMember = (Member) session.getAttribute("loginMember");
	String sessionMemberId = loginMember.getMemberId();

	Member paramMember = new Member();
	paramMember.setMemberNo(loginMember.getMemberNo());
	paramMember.setMemberId(request.getParameter("memberId"));
	paramMember.setMemberName(request.getParameter("memberName"));
	paramMember.setMemberPw(request.getParameter("memberPw"));
	paramMember.setMemberLevel(loginMember.getMemberLevel());
	
	MemberDao memberDao = new MemberDao();
	
	int duplicateMemberIdCheck = memberDao.selectDuplicateUpdateMember(paramMember, sessionMemberId);
	if(duplicateMemberIdCheck != 0) {
		String msg = "중복된 ID 입니다. 다른 ID를 선택해주세요.";
		response.sendRedirect(request.getContextPath()+"/member/updateMemberForm.jsp?msg="+URLEncoder.encode(msg,"UTF-8"));
		return;
	}
	
	int updateMemberCheck = memberDao.updateMember(paramMember);
	String msg = null;
	if(updateMemberCheck == 0) {
		System.out.println("업데이트 실패");
		msg = "업데이트 실패";
		response.sendRedirect(request.getContextPath()+"/member/updateMemberForm.jsp?msg="+URLEncoder.encode(msg,"UTF-8"));
		return;
		
	} else {
		System.out.println("업데이트 성공");
		session.setAttribute("loginMember", paramMember);
		msg = "업데이트 성공";
	}
	

	response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp?msg="+URLEncoder.encode(msg,"UTF-8"));

	
%>